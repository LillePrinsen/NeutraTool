# =====================================================================
#  NeutraTool v2.3 - Debloat / Virus / Network / Optimize / Dev / Settings
#  Slogan: Simple. Useful. Done.
#  by littlleprince
#  Discord: littlleprince
#  Contact: neutracocontact@gmail.com
#  Run through NeutraTool.bat as Administrator.
# =====================================================================

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Start-Process powershell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    exit
}

$ErrorActionPreference = 'Continue'
$ProgressPreference    = 'SilentlyContinue'

try {
    Add-Type -AssemblyName PresentationFramework
    Add-Type -AssemblyName PresentationCore
    Add-Type -AssemblyName WindowsBase

    # =================================================================
    #  THEMES
    # =================================================================
    $Global:Themes = [ordered]@{
        "GitHub Dark"   = @{ Bg="#0D1117"; Panel="#161B22"; Sidebar="#010409"; Accent="#58A6FF"; Text="#F0F6FC"; Sub="#8B949E"; Border="#30363D" }
        "Midnight Blue" = @{ Bg="#0A1929"; Panel="#112240"; Sidebar="#061326"; Accent="#4E9FFF"; Text="#E6F1FF"; Sub="#8892B0"; Border="#1E3A5F" }
        "Dracula"       = @{ Bg="#282A36"; Panel="#343746"; Sidebar="#1E1F29"; Accent="#BD93F9"; Text="#F8F8F2"; Sub="#6272A4"; Border="#44475A" }
        "Nord"          = @{ Bg="#2E3440"; Panel="#3B4252"; Sidebar="#242933"; Accent="#88C0D0"; Text="#ECEFF4"; Sub="#81A1C1"; Border="#434C5E" }
        "Tokyo Night"   = @{ Bg="#1A1B26"; Panel="#24283B"; Sidebar="#16161E"; Accent="#7AA2F7"; Text="#C0CAF5"; Sub="#565F89"; Border="#414868" }
        "Solarized"     = @{ Bg="#002B36"; Panel="#073642"; Sidebar="#001F27"; Accent="#268BD2"; Text="#EEE8D5"; Sub="#93A1A1"; Border="#0A4B5A" }
        "Crimson"       = @{ Bg="#1A0F14"; Panel="#2A1820"; Sidebar="#0F0609"; Accent="#F87171"; Text="#FEE2E2"; Sub="#A16B6B"; Border="#4C1D24" }
        "Emerald"       = @{ Bg="#0A1F14"; Panel="#14301F"; Sidebar="#051208"; Accent="#34D399"; Text="#D1FAE5"; Sub="#6B9A82"; Border="#1E4A32" }
        "Purple Haze"   = @{ Bg="#1A0F2E"; Panel="#251840"; Sidebar="#100820"; Accent="#A78BFA"; Text="#EDE9FE"; Sub="#8B7BA8"; Border="#3D2861" }
        "Amber"         = @{ Bg="#1C1407"; Panel="#2A1E0A"; Sidebar="#120D04"; Accent="#FBBF24"; Text="#FEF3C7"; Sub="#A68B4D"; Border="#4A370F" }
    }
    $Global:ActiveNav = "NavDebloat"

    # =================================================================
    #  XAML
    # =================================================================
    [xml]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="NeutraTool - Simple. Useful. Done."
        Height="780" Width="1180"
        WindowStartupLocation="CenterScreen"
        Background="{DynamicResource BgBrush}"
        FontFamily="Segoe UI"
        ResizeMode="CanResize">

  <Window.Resources>
    <SolidColorBrush x:Key="BgBrush"      Color="#0D1117"/>
    <SolidColorBrush x:Key="PanelBrush"   Color="#161B22"/>
    <SolidColorBrush x:Key="SidebarBrush" Color="#010409"/>
    <SolidColorBrush x:Key="AccentBrush"  Color="#58A6FF"/>
    <SolidColorBrush x:Key="TextBrush"    Color="#F0F6FC"/>
    <SolidColorBrush x:Key="SubBrush"     Color="#8B949E"/>
    <SolidColorBrush x:Key="BorderBrushX" Color="#30363D"/>
    <SolidColorBrush x:Key="TransBrush"   Color="Transparent"/>

    <Style TargetType="Button" x:Key="NavBtn">
      <Setter Property="Background" Value="{DynamicResource TransBrush}"/>
      <Setter Property="Foreground" Value="{DynamicResource SubBrush}"/>
      <Setter Property="BorderThickness" Value="0"/>
      <Setter Property="Padding" Value="14,11"/>
      <Setter Property="HorizontalContentAlignment" Value="Left"/>
      <Setter Property="FontSize" Value="13"/>
      <Setter Property="Cursor" Value="Hand"/>
      <Setter Property="Template">
        <Setter.Value>
          <ControlTemplate TargetType="Button">
            <Border x:Name="bd" Background="{TemplateBinding Background}" CornerRadius="6" Padding="{TemplateBinding Padding}">
              <ContentPresenter HorizontalAlignment="Left" VerticalAlignment="Center"/>
            </Border>
          </ControlTemplate>
        </Setter.Value>
      </Setter>
    </Style>

    <Style TargetType="Button" x:Key="ActBtn">
      <Setter Property="Background" Value="#238636"/>
      <Setter Property="Foreground" Value="White"/>
      <Setter Property="BorderThickness" Value="0"/>
      <Setter Property="Padding" Value="22,11"/>
      <Setter Property="FontSize" Value="13"/>
      <Setter Property="FontWeight" Value="SemiBold"/>
      <Setter Property="Cursor" Value="Hand"/>
      <Setter Property="Template">
        <Setter.Value>
          <ControlTemplate TargetType="Button">
            <Border x:Name="bd" Background="{TemplateBinding Background}" CornerRadius="6" Padding="{TemplateBinding Padding}">
              <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
            </Border>
            <ControlTemplate.Triggers>
              <Trigger Property="IsMouseOver" Value="True">
                <Setter TargetName="bd" Property="Opacity" Value="0.85"/>
              </Trigger>
            </ControlTemplate.Triggers>
          </ControlTemplate>
        </Setter.Value>
      </Setter>
    </Style>

    <Style TargetType="Button" x:Key="RedBtn"    BasedOn="{StaticResource ActBtn}"><Setter Property="Background" Value="#DA3633"/></Style>
    <Style TargetType="Button" x:Key="BlueBtn"   BasedOn="{StaticResource ActBtn}"><Setter Property="Background" Value="#1F6FEB"/></Style>
    <Style TargetType="Button" x:Key="PurpleBtn" BasedOn="{StaticResource ActBtn}"><Setter Property="Background" Value="#8957E5"/></Style>

    <Style TargetType="CheckBox">
      <Setter Property="Foreground" Value="{DynamicResource SubBrush}"/>
      <Setter Property="FontSize" Value="13"/>
      <Setter Property="Padding" Value="8,6"/>
      <Setter Property="Cursor" Value="Hand"/>
    </Style>

    <Style TargetType="TextBlock" x:Key="SectionTitle">
      <Setter Property="Foreground" Value="{DynamicResource AccentBrush}"/>
      <Setter Property="FontSize" Value="11"/>
      <Setter Property="FontWeight" Value="Bold"/>
      <Setter Property="Margin" Value="0,0,0,6"/>
    </Style>
    <Style TargetType="TextBlock" x:Key="CardTitle">
      <Setter Property="Foreground" Value="{DynamicResource TextBrush}"/>
      <Setter Property="FontSize" Value="22"/>
      <Setter Property="FontWeight" Value="Bold"/>
    </Style>
    <Style TargetType="TextBlock" x:Key="CardSub">
      <Setter Property="Foreground" Value="{DynamicResource SubBrush}"/>
      <Setter Property="FontSize" Value="12"/>
      <Setter Property="Margin" Value="0,4,0,20"/>
    </Style>
    <Style TargetType="Border" x:Key="Card">
      <Setter Property="Background" Value="{DynamicResource PanelBrush}"/>
      <Setter Property="CornerRadius" Value="8"/>
      <Setter Property="Padding" Value="16"/>
      <Setter Property="Margin" Value="0,0,0,12"/>
    </Style>
  </Window.Resources>

  <Grid>
    <Grid.ColumnDefinitions>
      <ColumnDefinition Width="240"/>
      <ColumnDefinition Width="*"/>
    </Grid.ColumnDefinitions>

    <Border Grid.Column="0" Background="{DynamicResource SidebarBrush}" Padding="12">
      <Grid>
        <Grid.RowDefinitions>
          <RowDefinition Height="Auto"/>
          <RowDefinition Height="*"/>
          <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <StackPanel Grid.Row="0">
          <TextBlock Text="NeutraTool" Foreground="{DynamicResource AccentBrush}" FontSize="24" FontWeight="Bold" Margin="8,18,0,2"/>
          <TextBlock Text="by littlleprince" Foreground="{DynamicResource TextBrush}" FontSize="11" FontWeight="SemiBold" Margin="8,0,0,2"/>
          <TextBlock Text="Simple. Useful. Done." Foreground="{DynamicResource SubBrush}" FontSize="11" FontStyle="Italic" Margin="8,0,0,24"/>

          <Button x:Name="NavDebloat"  Style="{StaticResource NavBtn}" Content="Debloat"/>
          <Button x:Name="NavVirus"    Style="{StaticResource NavBtn}" Content="Virus Scan" Margin="0,2,0,0"/>
          <Button x:Name="NavNetwork"  Style="{StaticResource NavBtn}" Content="Network" Margin="0,2,0,0"/>
          <Button x:Name="NavOptimize" Style="{StaticResource NavBtn}" Content="Optimize" Margin="0,2,0,0"/>
          <Button x:Name="NavDev"      Style="{StaticResource NavBtn}" Content="Dev Tools" Margin="0,2,0,0"/>
          <Button x:Name="NavSettings" Style="{StaticResource NavBtn}" Content="Settings" Margin="0,2,0,0"/>

          <Border Background="{DynamicResource PanelBrush}" CornerRadius="6" Padding="12" Margin="0,24,0,0">
            <StackPanel>
              <TextBlock Text="STATUS" Foreground="{DynamicResource SubBrush}" FontSize="10" FontWeight="Bold"/>
              <TextBlock x:Name="StatusText" Text="Ready" Foreground="#3FB950" FontSize="12" Margin="0,4,0,0" TextWrapping="Wrap"/>
            </StackPanel>
          </Border>
        </StackPanel>

        <StackPanel Grid.Row="2" Margin="8,16,0,0">
          <Border Height="1" Background="{DynamicResource BorderBrushX}" Margin="0,0,8,12"/>
          <TextBlock Text="Built by littlleprince" Foreground="{DynamicResource TextBrush}" FontSize="11" FontWeight="SemiBold"/>
          <TextBlock Text="Discord: littlleprince" Foreground="{DynamicResource SubBrush}" FontSize="10" Margin="0,2,0,0"/>
          <TextBlock Text="neutracocontact@gmail.com" Foreground="{DynamicResource SubBrush}" FontSize="10" Margin="0,2,0,0" TextWrapping="Wrap"/>
          <TextBlock Text="v2.3" Foreground="{DynamicResource SubBrush}" FontSize="9" Margin="0,6,0,0"/>
        </StackPanel>
      </Grid>
    </Border>

    <Grid Grid.Column="1" Margin="24,16,24,16">
      <Grid.RowDefinitions>
        <RowDefinition Height="*"/>
        <RowDefinition Height="190"/>
      </Grid.RowDefinitions>

      <Grid Grid.Row="0">

        <ScrollViewer x:Name="PanelDebloat" VerticalScrollBarVisibility="Auto">
          <StackPanel>
            <TextBlock Text="Windows Debloat" Style="{StaticResource CardTitle}"/>
            <TextBlock Text="Strip preinstalled junk, kill telemetry, remove AI features." Style="{StaticResource CardSub}"/>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="BLOATWARE" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkApps"     Content="Remove preinstalled apps (Xbox, Cortana, Bing, Candy Crush, News, Solitaire...)" IsChecked="True"/>
                <CheckBox x:Name="ChkProv"     Content="Remove provisioned packages (blocks reinstall for new users)" IsChecked="True"/>
                <CheckBox x:Name="ChkOneDrive" Content="Uninstall OneDrive" IsChecked="False"/>
                <CheckBox x:Name="ChkTeams"    Content="Uninstall Microsoft Teams (consumer)" IsChecked="True"/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="TELEMETRY AND AI" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkTelemetry" Content="Disable telemetry services (DiagTrack, dmwappushservice)" IsChecked="True"/>
                <CheckBox x:Name="ChkCopilot"   Content="Disable Windows Copilot and Recall" IsChecked="True"/>
                <CheckBox x:Name="ChkWidgets"   Content="Disable Widgets / News and Interests" IsChecked="True"/>
                <CheckBox x:Name="ChkSearchWeb" Content="Disable web search in Start Menu" IsChecked="True"/>
                <CheckBox x:Name="ChkAds"       Content="Disable ads, tips and suggested content" IsChecked="True"/>
              </StackPanel>
            </Border>

            <Button x:Name="BtnDebloat" Style="{StaticResource ActBtn}" Content="Run Debloat" HorizontalAlignment="Left" Margin="0,4,0,0"/>
          </StackPanel>
        </ScrollViewer>

        <ScrollViewer x:Name="PanelVirus" VerticalScrollBarVisibility="Auto" Visibility="Collapsed">
          <StackPanel>
            <TextBlock Text="Virus Scan" Style="{StaticResource CardTitle}"/>
            <TextBlock Text="Deep malware hunting with Windows Defender, offline scan, and custom path scans." Style="{StaticResource CardSub}"/>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="SCAN TYPE" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkQuick"   Content="Quick Scan (2-5 min, common malware locations)" IsChecked="True"/>
                <CheckBox x:Name="ChkFull"    Content="Full Scan (all files, 30-60 min)" IsChecked="False"/>
                <CheckBox x:Name="ChkOffline" Content="Offline Scan (reboots to scan before Windows loads)" IsChecked="False"/>
                <CheckBox x:Name="ChkCustom"  Content="Custom Path Scan (scan a specific folder)" IsChecked="False"/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="CUSTOM PATH" Style="{StaticResource SectionTitle}"/>
                <TextBox x:Name="TxtScanPath" Background="{DynamicResource BgBrush}" Foreground="{DynamicResource TextBrush}" BorderBrush="{DynamicResource BorderBrushX}" Padding="8,6" FontSize="12"/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="ACTIONS" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkThreats"   Content="Automatically remove detected threats" IsChecked="True"/>
                <CheckBox x:Name="ChkRootkit"   Content="Driver heuristic - flag suspicious recent .sys files" IsChecked="True"/>
                <CheckBox x:Name="ChkUpdateDef" Content="Update virus definitions before scan" IsChecked="True"/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="DEFENDER HARDENING" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkFirewall" Content="Enable Windows Firewall (all profiles)" IsChecked="True"/>
                <CheckBox x:Name="ChkASR"      Content="Enable Attack Surface Reduction (ASR) rules" IsChecked="True"/>
                <CheckBox x:Name="ChkCFA"      Content="Enable Controlled Folder Access (ransomware)" IsChecked="True"/>
                <CheckBox x:Name="ChkNetProt"  Content="Enable Network Protection" IsChecked="True"/>
                <CheckBox x:Name="ChkSMB1"     Content="Disable legacy SMBv1 protocol" IsChecked="True"/>
              </StackPanel>
            </Border>

            <Button x:Name="BtnVirus" Style="{StaticResource RedBtn}" Content="Scan and Clean" HorizontalAlignment="Left" Margin="0,4,0,0"/>
          </StackPanel>
        </ScrollViewer>

        <ScrollViewer x:Name="PanelNetwork" VerticalScrollBarVisibility="Auto" Visibility="Collapsed">
          <StackPanel>
            <TextBlock Text="Network" Style="{StaticResource CardTitle}"/>
            <TextBlock Text="Reset adapters, flush DNS, fix connectivity issues, and run diagnostics." Style="{StaticResource CardSub}"/>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="RESETS" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkFlushDns"  Content="Flush DNS cache" IsChecked="True"/>
                <CheckBox x:Name="ChkReleaseIp" Content="Release IP (DHCP)" IsChecked="False"/>
                <CheckBox x:Name="ChkRenewIp"   Content="Renew IP (DHCP)" IsChecked="False"/>
                <CheckBox x:Name="ChkWinsock"   Content="Reset Winsock catalog" IsChecked="True"/>
                <CheckBox x:Name="ChkTcpip"     Content="Reset TCP/IP stack" IsChecked="True"/>
                <CheckBox x:Name="ChkArp"       Content="Clear ARP cache" IsChecked="True"/>
                <CheckBox x:Name="ChkNetbios"   Content="Reset NetBIOS cache" IsChecked="True"/>
                <CheckBox x:Name="ChkProxy"     Content="Reset WinHTTP proxy" IsChecked="True"/>
                <CheckBox x:Name="ChkFirewallR" Content="Reset Windows Firewall to defaults" IsChecked="False"/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="DIAGNOSTICS" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkShowIp"       Content="Show IP configuration" IsChecked="True"/>
                <CheckBox x:Name="ChkShowAdapters" Content="Show network adapters" IsChecked="True"/>
                <CheckBox x:Name="ChkPingTest"     Content="Ping 8.8.8.8 (connectivity test)" IsChecked="True"/>
                <CheckBox x:Name="ChkDnsTest"      Content="Resolve google.com (DNS test)" IsChecked="True"/>
                <CheckBox x:Name="ChkTraceRoute"   Content="Traceroute to 8.8.8.8" IsChecked="False"/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="ADVANCED" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkTcpOpt" Content="Apply TCP optimizations (disable Nagle, enable RSS)" IsChecked="False"/>
                <CheckBox x:Name="ChkMtu"    Content="Set MTU to 1500" IsChecked="False"/>
              </StackPanel>
            </Border>

            <Button x:Name="BtnNetwork" Style="{StaticResource BlueBtn}" Content="Run Network Tools" HorizontalAlignment="Left" Margin="0,4,0,0"/>
          </StackPanel>
        </ScrollViewer>

        <ScrollViewer x:Name="PanelOptimize" VerticalScrollBarVisibility="Auto" Visibility="Collapsed">
          <StackPanel>
            <TextBlock Text="Optimize" Style="{StaticResource CardTitle}"/>
            <TextBlock Text="Performance tuning, power plans, junk cleanup, and privacy presets." Style="{StaticResource CardSub}"/>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="POWER PLAN" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkUltimate"  Content="Enable Ultimate Performance power plan (activates on this PC)" IsChecked="True"/>
                <CheckBox x:Name="ChkHighPerf"  Content="Fallback to High Performance if Ultimate not available" IsChecked="True"/>
                <CheckBox x:Name="ChkHibernate" Content="Disable hibernation (frees disk space)" IsChecked="False"/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="PERFORMANCE TWEAKS" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkSvcs"    Content="Disable unnecessary services (Fax, RemoteRegistry, RetailDemo, MapsBroker)" IsChecked="True"/>
                <CheckBox x:Name="ChkVisual"  Content="Visual effects - Best Performance" IsChecked="True"/>
                <CheckBox x:Name="ChkGameBar" Content="Disable Game Bar and Game DVR" IsChecked="True"/>
                <CheckBox x:Name="ChkStartup" Content="Disable common startup delay" IsChecked="True"/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="JUNK CLEANUP" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkTemp"     Content="Clean temp files and Windows Update cache" IsChecked="True"/>
                <CheckBox x:Name="ChkRecycle"  Content="Empty Recycle Bin" IsChecked="True"/>
                <CheckBox x:Name="ChkPrefetch" Content="Clear Prefetch" IsChecked="False"/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="PRIVACY" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkShutUp"    Content="Install and apply O and O ShutUp10++ recommended preset" IsChecked="True"/>
                <CheckBox x:Name="ChkSecUpdate" Content="Windows Update - security only, defer features 365 days" IsChecked="False"/>
              </StackPanel>
            </Border>

            <Button x:Name="BtnOptimize" Style="{StaticResource PurpleBtn}" Content="Apply Optimization" HorizontalAlignment="Left" Margin="0,4,0,0"/>
          </StackPanel>
        </ScrollViewer>

        <ScrollViewer x:Name="PanelDev" VerticalScrollBarVisibility="Auto" Visibility="Collapsed">
          <StackPanel>
            <TextBlock Text="Dev Tools" Style="{StaticResource CardTitle}"/>
            <TextBlock Text="Auto-install programming languages and dev tools via winget." Style="{StaticResource CardSub}"/>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="LANGUAGES" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkPython" Content="Python 3.12" IsChecked="True"/>
                <CheckBox x:Name="ChkNode"   Content="Node.js LTS" IsChecked="True"/>
                <CheckBox x:Name="ChkJava"   Content="Eclipse Temurin JDK 21" IsChecked="True"/>
                <CheckBox x:Name="ChkGo"     Content="Go" IsChecked="False"/>
                <CheckBox x:Name="ChkRust"   Content="Rust" IsChecked="False"/>
                <CheckBox x:Name="ChkPhp"    Content="PHP" IsChecked="False"/>
                <CheckBox x:Name="ChkRuby"   Content="Ruby" IsChecked="False"/>
                <CheckBox x:Name="ChkDotNet" Content=".NET SDK 8" IsChecked="False"/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="EDITORS AND SHELLS" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkVsCode"  Content="Visual Studio Code" IsChecked="True"/>
                <CheckBox x:Name="ChkPwsh7"   Content="PowerShell 7" IsChecked="True"/>
                <CheckBox x:Name="ChkGit"     Content="Git for Windows" IsChecked="True"/>
                <CheckBox x:Name="ChkWinTerm" Content="Windows Terminal" IsChecked="True"/>
                <CheckBox x:Name="ChkNeovim"  Content="Neovim" IsChecked="False"/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="BUILD AND UTILITIES" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkCmake"   Content="CMake" IsChecked="False"/>
                <CheckBox x:Name="ChkLLVM"    Content="LLVM / Clang" IsChecked="False"/>
                <CheckBox x:Name="ChkVSBT"    Content="Visual Studio 2022 Build Tools (C++ compiler)" IsChecked="False"/>
                <CheckBox x:Name="ChkDocker"  Content="Docker Desktop" IsChecked="False"/>
                <CheckBox x:Name="ChkPostman" Content="Postman" IsChecked="False"/>
                <CheckBox x:Name="ChkDBeaver" Content="DBeaver Community (SQL client)" IsChecked="False"/>
              </StackPanel>
            </Border>

            <Button x:Name="BtnDev" Style="{StaticResource ActBtn}" Content="Install Selected" HorizontalAlignment="Left" Margin="0,4,0,0"/>
          </StackPanel>
        </ScrollViewer>

        <ScrollViewer x:Name="PanelSettings" VerticalScrollBarVisibility="Auto" Visibility="Collapsed">
          <StackPanel>
            <TextBlock Text="Settings" Style="{StaticResource CardTitle}"/>
            <TextBlock Text="Theme, about, and system info." Style="{StaticResource CardSub}"/>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="THEME" Style="{StaticResource SectionTitle}"/>
                <TextBlock Text="Pick a color scheme. Applies instantly." Foreground="{DynamicResource SubBrush}" FontSize="11" Margin="0,0,0,8"/>
                <ComboBox x:Name="CmbTheme" Width="260" HorizontalAlignment="Left" FontSize="13" Padding="8,6"
                          Background="{DynamicResource PanelBrush}"
                          Foreground="{DynamicResource TextBrush}"
                          BorderBrush="{DynamicResource BorderBrushX}"/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="ABOUT" Style="{StaticResource SectionTitle}"/>
                <TextBlock Text="NeutraTool v2.3" Foreground="{DynamicResource TextBrush}" FontSize="14" FontWeight="Bold"/>
                <TextBlock Text="by littlleprince" Foreground="{DynamicResource TextBrush}" FontSize="12" FontWeight="SemiBold" Margin="0,2,0,4"/>
                <TextBlock Text="Simple. Useful. Done." Foreground="{DynamicResource AccentBrush}" FontSize="12" FontStyle="Italic" Margin="0,0,0,10"/>
                <TextBlock Text="A no-nonsense Windows toolkit for debloating, cleaning, optimizing, and developing." Foreground="{DynamicResource SubBrush}" FontSize="12" TextWrapping="Wrap" Margin="0,0,0,12"/>
                <Border Height="1" Background="{DynamicResource BorderBrushX}" Margin="0,0,0,12"/>

                <TextBlock Text="AUTHOR" Foreground="{DynamicResource SubBrush}" FontSize="10" FontWeight="Bold" Margin="0,0,0,4"/>
                <TextBlock Text="littlleprince" Foreground="{DynamicResource TextBrush}" FontSize="13" FontWeight="SemiBold"/>

                <TextBlock Text="DISCORD" Foreground="{DynamicResource SubBrush}" FontSize="10" FontWeight="Bold" Margin="0,10,0,4"/>
                <TextBlock Text="littlleprince" Foreground="{DynamicResource TextBrush}" FontSize="12"/>

                <TextBlock Text="EMAIL" Foreground="{DynamicResource SubBrush}" FontSize="10" FontWeight="Bold" Margin="0,10,0,4"/>
                <TextBlock Text="neutracocontact@gmail.com" Foreground="{DynamicResource TextBrush}" FontSize="12"/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="SYSTEM INFO" Style="{StaticResource SectionTitle}"/>
                <Button x:Name="BtnSysInfo" Style="{StaticResource BlueBtn}" Content="Show System Info" HorizontalAlignment="Left"/>
              </StackPanel>
            </Border>
          </StackPanel>
        </ScrollViewer>

      </Grid>

      <Border Grid.Row="1" Background="{DynamicResource SidebarBrush}" CornerRadius="8" Margin="0,16,0,0" Padding="12">
        <Grid>
          <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
          </Grid.RowDefinitions>
          <TextBlock Grid.Row="0" Text="LOG" Foreground="{DynamicResource SubBrush}" FontSize="10" FontWeight="Bold" Margin="0,0,0,6"/>
          <TextBox Grid.Row="1" x:Name="LogBox"
                   Background="Transparent" BorderThickness="0"
                   Foreground="{DynamicResource SubBrush}" FontFamily="Consolas" FontSize="11"
                   IsReadOnly="True" TextWrapping="Wrap" AcceptsReturn="True"
                   VerticalScrollBarVisibility="Auto"/>
        </Grid>
      </Border>
    </Grid>
  </Grid>
</Window>
"@

    $Reader = New-Object System.Xml.XmlNodeReader $XAML
    $Global:Window     = [Windows.Markup.XamlReader]::Load($Reader)
    $Global:LogBox     = $Global:Window.FindName("LogBox")
    $Global:StatusText = $Global:Window.FindName("StatusText")

    # =================================================================
    #  HELPERS
    # =================================================================
    function Write-Log {
        param([string]$Msg, [string]$Level = "INFO")
        $t = Get-Date -Format "HH:mm:ss"
        $p = switch ($Level) {
            "OK"   { "[+]" }
            "WARN" { "[!]" }
            "ERR"  { "[X]" }
            "HEAD" { "===" }
            default { "[-]" }
        }
        $Global:LogBox.AppendText("$t $p $Msg`r`n")
        $Global:LogBox.ScrollToEnd()
        try {
            $Global:Window.Dispatcher.Invoke([action]{}, [System.Windows.Threading.DispatcherPriority]::Background) | Out-Null
        } catch {}
    }

    function Set-Status {
        param([string]$Text, [string]$Color = "#3FB950")
        $Global:StatusText.Text = $Text
        try {
            $Global:StatusText.Foreground = [Windows.Media.BrushConverter]::new().ConvertFromString($Color)
        } catch {}
        try {
            $Global:Window.Dispatcher.Invoke([action]{}, [System.Windows.Threading.DispatcherPriority]::Background) | Out-Null
        } catch {}
    }

    function New-BrushFromHex {
        param([string]$Hex)
        $c = [Windows.Media.ColorConverter]::ConvertFromString($Hex)
        return [Windows.Media.SolidColorBrush]::new($c)
    }

    function Apply-NavColors {
        $active = $Global:ActiveNav
        $res    = $Global:Window.Resources
        $panelB = $res["PanelBrush"]
        $textB  = $res["TextBrush"]
        $transB = $res["TransBrush"]
        $subB   = $res["SubBrush"]

        foreach ($n in @("Debloat","Virus","Network","Optimize","Dev","Settings")) {
            $btn = $Global:Window.FindName("Nav$n")
            if (-not $btn) { continue }
            if ("Nav$n" -eq $active) {
                $btn.Background = $panelB
                $btn.Foreground = $textB
            } else {
                $btn.Background = $transB
                $btn.Foreground = $subB
            }
        }
    }

    function Show-Panel {
        param([string]$Name)
        foreach ($n in @("Debloat","Virus","Network","Optimize","Dev","Settings")) {
            $p = $Global:Window.FindName("Panel$n")
            if ($p) { $p.Visibility = "Collapsed" }
        }
        $target = $Global:Window.FindName("Panel$Name")
        if ($target) { $target.Visibility = "Visible" }
        $Global:ActiveNav = "Nav$Name"
        Apply-NavColors
    }

    function Set-Theme {
        param([string]$Name)
        if (-not $Global:Themes.Contains($Name)) { return }
        $t   = $Global:Themes[$Name]
        $res = $Global:Window.Resources

        $res["BgBrush"]      = New-BrushFromHex $t.Bg
        $res["PanelBrush"]   = New-BrushFromHex $t.Panel
        $res["SidebarBrush"] = New-BrushFromHex $t.Sidebar
        $res["AccentBrush"]  = New-BrushFromHex $t.Accent
        $res["TextBrush"]    = New-BrushFromHex $t.Text
        $res["SubBrush"]     = New-BrushFromHex $t.Sub
        $res["BorderBrushX"] = New-BrushFromHex $t.Border

        Apply-NavColors
        Write-Log "Theme applied: $Name" "OK"
    }

    function Test-Command {
        param([string]$Name)
        return [bool](Get-Command $Name -ErrorAction SilentlyContinue)
    }

    function Install-ViaWinget {
        param([string]$Id, [string]$Friendly)
        if (-not (Test-Command winget)) {
            Write-Log "winget not available - install App Installer from Microsoft Store" "ERR"
            return
        }
        try {
            Write-Log "Installing $Friendly..." "INFO"
            $a = "install --id $Id --exact --silent --accept-package-agreements --accept-source-agreements --disable-interactivity"
            $p = Start-Process winget -ArgumentList $a -Wait -PassThru -NoNewWindow -WindowStyle Hidden
            if ($p.ExitCode -eq 0) { Write-Log "Installed $Friendly" "OK" }
            else { Write-Log "Failed $Friendly (exit $($p.ExitCode))" "WARN" }
        } catch {
            Write-Log "Error installing $Friendly : $_" "ERR"
        }
    }

    # =================================================================
    #  DEBLOAT
    # =================================================================
    function Invoke-Debloat {
        param([bool]$Apps,[bool]$Prov,[bool]$OneDrive,[bool]$Teams,
              [bool]$Telemetry,[bool]$Copilot,[bool]$Widgets,[bool]$SearchWeb,[bool]$Ads)

        Set-Status "Debloating..." "#D29922"
        Write-Log "Debloat started" "HEAD"

        $Bloat = @(
            "Microsoft.3DBuilder","Microsoft.BingFinance","Microsoft.BingNews",
            "Microsoft.BingSports","Microsoft.BingWeather","Microsoft.GetHelp",
            "Microsoft.Getstarted","Microsoft.Messaging","Microsoft.Microsoft3DViewer",
            "Microsoft.MicrosoftOfficeHub","Microsoft.MicrosoftSolitaireCollection",
            "Microsoft.MicrosoftStickyNotes","Microsoft.MixedReality.Portal",
            "Microsoft.Office.OneNote","Microsoft.OneConnect","Microsoft.People",
            "Microsoft.Print3D","Microsoft.SkypeApp","Microsoft.Wallet",
            "Microsoft.WindowsAlarms","Microsoft.WindowsCamera",
            "Microsoft.WindowsFeedbackHub","Microsoft.WindowsMaps",
            "Microsoft.WindowsSoundRecorder","Microsoft.Xbox.TCUI","Microsoft.XboxApp",
            "Microsoft.XboxGameOverlay","Microsoft.XboxGamingOverlay",
            "Microsoft.XboxIdentityProvider","Microsoft.XboxSpeechToTextOverlay",
            "Microsoft.YourPhone","Microsoft.ZuneMusic","Microsoft.ZuneVideo",
            "Microsoft.549981C3F5F10","MicrosoftTeams","MSTeams",
            "Microsoft.Todos","Microsoft.PowerAutomateDesktop",
            "Microsoft.Windows.DevHome","Microsoft.Copilot"
        )

        if ($Apps) {
            Write-Log "Removing $($Bloat.Count) bloatware packages..." "INFO"
            foreach ($app in $Bloat) {
                try {
                    $p = Get-AppxPackage -Name $app -AllUsers -ErrorAction SilentlyContinue
                    if ($p) {
                        foreach ($pkg in $p) {
                            Remove-AppxPackage -Package $pkg.PackageFullName -AllUsers -ErrorAction SilentlyContinue
                        }
                        Write-Log "Removed $app" "OK"
                    }
                } catch { Write-Log "Skip $app" "WARN" }
            }
        }

        if ($Prov) {
            Write-Log "Removing provisioned packages..." "INFO"
            $pattern = "Bing|Xbox|Zune|Skype|OfficeHub|Solitaire|MixedReality|People|Wallet|Alarms|Camera|Maps|SoundRecorder|Feedback|GetHelp|Getstarted|3DViewer|StickyNotes|Teams|Cortana|Copilot|Todos|PowerAutomate"
            try {
                $list = Get-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue |
                        Where-Object { $_.DisplayName -match $pattern }
                foreach ($prov in $list) {
                    try {
                        Remove-AppxProvisionedPackage -Online -PackageName $prov.PackageName -ErrorAction SilentlyContinue | Out-Null
                        Write-Log "Removed provisioned: $($prov.DisplayName)" "OK"
                    } catch { Write-Log "Could not remove: $($prov.DisplayName)" "WARN" }
                }
            } catch { Write-Log "Provisioned removal failed: $_" "WARN" }
        }

        if ($OneDrive) {
            Write-Log "Uninstalling OneDrive..." "INFO"
            try {
                Stop-Process -Name OneDrive -Force -ErrorAction SilentlyContinue
                $od = "$env:SystemRoot\SysWOW64\OneDriveSetup.exe"
                if (-not (Test-Path $od)) { $od = "$env:SystemRoot\System32\OneDriveSetup.exe" }
                if (Test-Path $od) {
                    Start-Process $od -ArgumentList "/uninstall" -Wait -NoNewWindow
                    Write-Log "OneDrive uninstalled" "OK"
                } else { Write-Log "OneDriveSetup.exe not found" "WARN" }
            } catch { Write-Log "OneDrive uninstall failed" "WARN" }
        }

        if ($Teams) {
            try {
                Get-AppxPackage -Name "MSTeams" -AllUsers -ErrorAction SilentlyContinue |
                    Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
                Write-Log "Teams removed" "OK"
            } catch { Write-Log "Teams removal failed" "WARN" }
        }

        if ($Telemetry) {
            Write-Log "Disabling telemetry..." "INFO"
            foreach ($svc in @("DiagTrack","dmwappushservice","diagnosticshub.standardcollector.service")) {
                try {
                    Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
                    Set-Service -Name $svc -StartupType Disabled -ErrorAction SilentlyContinue
                    Write-Log "Disabled service: $svc" "OK"
                } catch { Write-Log "Could not disable $svc" "WARN" }
            }
            $rp = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
            if (-not (Test-Path $rp)) { New-Item -Path $rp -Force | Out-Null }
            Set-ItemProperty -Path $rp -Name "AllowTelemetry" -Value 0 -Type DWord -Force -ErrorAction SilentlyContinue
            Write-Log "Telemetry registry disabled" "OK"
        }

        if ($Copilot) {
            $cp = "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot"
            if (-not (Test-Path $cp)) { New-Item -Path $cp -Force | Out-Null }
            Set-ItemProperty -Path $cp -Name "TurnOffWindowsCopilot" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue
            $rp = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsAI"
            if (-not (Test-Path $rp)) { New-Item -Path $rp -Force | Out-Null }
            Set-ItemProperty -Path $rp -Name "DisableAIDataAnalysis" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue
            Write-Log "Copilot and Recall disabled" "OK"
        }

        if ($Widgets) {
            $wp = "HKLM:\SOFTWARE\Policies\Microsoft\Dsh"
            if (-not (Test-Path $wp)) { New-Item -Path $wp -Force | Out-Null }
            Set-ItemProperty -Path $wp -Name "AllowNewsAndInterests" -Value 0 -Type DWord -Force -ErrorAction SilentlyContinue
            Write-Log "Widgets disabled" "OK"
        }

        if ($SearchWeb) {
            $sp = "HKCU:\Software\Policies\Microsoft\Windows\Explorer"
            if (-not (Test-Path $sp)) { New-Item -Path $sp -Force | Out-Null }
            Set-ItemProperty -Path $sp -Name "DisableSearchBoxSuggestions" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue
            Write-Log "Web search in Start disabled" "OK"
        }

        if ($Ads) {
            $cp = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
            if (Test-Path $cp) {
                foreach ($n in @("SubscribedContent-338388Enabled","SubscribedContent-338389Enabled",
                                 "SubscribedContent-310093Enabled","SystemPaneSuggestionsEnabled",
                                 "SilentInstalledAppsEnabled","PreInstalledAppsEnabled",
                                 "OemPreInstalledAppsEnabled","ContentDeliveryAllowed")) {
                    Set-ItemProperty -Path $cp -Name $n -Value 0 -Type DWord -Force -ErrorAction SilentlyContinue
                }
            }
            Write-Log "Ads and suggestions disabled" "OK"
        }

        Set-Status "Debloat complete" "#3FB950"
        Write-Log "Debloat finished. Sign out / restart for full effect." "HEAD"
    }

    # =================================================================
    #  VIRUS SCAN
    # =================================================================
    function Invoke-VirusScan {
        param([bool]$Quick,[bool]$Full,[bool]$Offline,[bool]$Custom,[string]$CustomPath,
              [bool]$Threats,[bool]$Rootkit,[bool]$UpdateDef,
              [bool]$Firewall,[bool]$ASR,[bool]$CFA,[bool]$NetProt,[bool]$SMB1)

        Set-Status "Scanning..." "#DA3633"
        Write-Log "Virus scan started" "HEAD"

        $defenderOk = $true
        try { Import-Module Defender -ErrorAction Stop } catch { $defenderOk = $false }

        if (-not $defenderOk) {
            Write-Log "Windows Defender module unavailable" "ERR"
            Set-Status "Defender unavailable" "#DA3633"
            return
        }

        if ($UpdateDef) {
            try {
                Write-Log "Updating virus definitions..." "INFO"
                Update-MpSignature -ErrorAction Stop
                Write-Log "Definitions updated" "OK"
            } catch { Write-Log "Definition update failed: $_" "WARN" }
        }

        if ($Quick) {
            Write-Log "Running Quick Scan..." "INFO"
            try { Start-MpScan -ScanType QuickScan -ErrorAction Stop; Write-Log "Quick scan done" "OK" }
            catch { Write-Log "Quick scan error: $_" "WARN" }
        }

        if ($Full) {
            Write-Log "Running Full Scan (may take 30-60 min)..." "WARN"
            try { Start-MpScan -ScanType FullScan -ErrorAction Stop; Write-Log "Full scan done" "OK" }
            catch { Write-Log "Full scan error: $_" "WARN" }
        }

        if ($Offline) {
            Write-Log "Scheduling Offline Scan - runs BEFORE Windows boots on next restart" "WARN"
            try {
                Start-MpScan -ScanType OfflineScan -ErrorAction Stop
                Write-Log "Offline scan scheduled" "OK"
            } catch { Write-Log "Offline scan scheduling failed: $_" "WARN" }
        }

        if ($Custom -and $CustomPath -and (Test-Path $CustomPath)) {
            Write-Log "Custom scan on: $CustomPath" "INFO"
            try { Start-MpScan -ScanType CustomScan -ScanPath $CustomPath -ErrorAction Stop; Write-Log "Custom scan done" "OK" }
            catch { Write-Log "Custom scan failed: $_" "WARN" }
        } elseif ($Custom) {
            Write-Log "Custom path not valid: $CustomPath" "WARN"
        }

        if ($Threats) {
            Write-Log "Processing detected threats..." "INFO"
            try {
                $det = Get-MpThreatDetection -ErrorAction SilentlyContinue
                if ($det) {
                    foreach ($d in $det) {
                        Write-Log "Threat: $($d.ThreatName)" "WARN"
                        try {
                            Remove-MpThreat -ThreatID $d.ThreatID -ErrorAction Stop
                            Write-Log "Removed $($d.ThreatName)" "OK"
                        } catch { Write-Log "Could not remove $($d.ThreatName)" "WARN" }
                    }
                } else { Write-Log "No active threats" "OK" }
            } catch { Write-Log "Threat processing issue: $_" "WARN" }
        }

        if ($Rootkit) {
            Write-Log "Driver heuristic scan..." "INFO"
            try {
                $susp = Get-ChildItem "$env:SystemRoot\System32\drivers" -Filter "*.sys" -ErrorAction SilentlyContinue |
                        Where-Object { $_.CreationTime -gt (Get-Date).AddDays(-14) -and $_.Length -lt 10KB }
                if ($susp) {
                    foreach ($s in $susp) { Write-Log "Suspicious driver: $($s.Name)" "WARN" }
                } else { Write-Log "No suspicious drivers found" "OK" }
            } catch { Write-Log "Driver check failed" "WARN" }
        }

        if ($Firewall) {
            try {
                Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True -ErrorAction Stop
                Write-Log "Firewall enabled (all profiles)" "OK"
            } catch { Write-Log "Firewall config failed" "WARN" }
        }

        if ($ASR) {
            Write-Log "Enabling ASR rules..." "INFO"
            $rules = @(
                "BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550","D4F940AB-401B-4EFC-AADC-AD5F3C50688A",
                "3B576869-A4EC-4529-8536-B80A7769E899","75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84",
                "5BEB7EFE-FD9A-4556-801D-275E5FFC04CC","92E97FA1-2EDF-4476-BDD6-9DD0B4DDDC7B",
                "D3E037E1-3EB8-44C8-A917-57927947596D","C1DB55AB-C21A-4637-BB3F-A12568109D35"
            )
            $ok = 0
            foreach ($r in $rules) {
                try { Add-MpPreference -AttackSurfaceReductionRules_Ids $r -AttackSurfaceReductionRules_Actions Enabled -ErrorAction Stop; $ok++ } catch {}
            }
            Write-Log "ASR rules enabled: $ok / $($rules.Count)" "OK"
        }

        if ($CFA) {
            try { Set-MpPreference -EnableControlledFolderAccess Enabled -ErrorAction Stop; Write-Log "Controlled Folder Access enabled" "OK" }
            catch { Write-Log "CFA not available" "WARN" }
        }

        if ($NetProt) {
            try { Set-MpPreference -EnableNetworkProtection Enabled -ErrorAction Stop; Write-Log "Network Protection enabled" "OK" }
            catch { Write-Log "Network Protection not available" "WARN" }
        }

        if ($SMB1) {
            try { Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force -ErrorAction Stop; Write-Log "SMBv1 disabled" "OK" }
            catch { Write-Log "SMBv1 already disabled" "WARN" }
        }

        Set-Status "Virus scan complete" "#3FB950"
        Write-Log "Virus scan finished" "HEAD"
    }

    # =================================================================
    #  NETWORK
    # =================================================================
    function Invoke-Network {
        param([bool]$FlushDns,[bool]$ReleaseIp,[bool]$RenewIp,[bool]$Winsock,[bool]$Tcpip,
              [bool]$Arp,[bool]$Netbios,[bool]$Proxy,[bool]$FirewallR,
              [bool]$ShowIp,[bool]$ShowAdapters,[bool]$PingTest,[bool]$DnsTest,[bool]$TraceRoute,
              [bool]$TcpOpt,[bool]$Mtu)

        Set-Status "Running network tools..." "#1F6FEB"
        Write-Log "Network tools started" "HEAD"

        if ($FlushDns) {
            try { ipconfig /flushdns | Out-Null; Write-Log "DNS cache flushed" "OK" } catch { Write-Log "Flush DNS failed" "WARN" }
        }

        if ($ReleaseIp) {
            try { ipconfig /release | Out-Null; Write-Log "IP released" "OK" } catch { Write-Log "IP release failed" "WARN" }
        }

        if ($RenewIp) {
            try { ipconfig /renew | Out-Null; Write-Log "IP renewed" "OK" } catch { Write-Log "IP renew failed" "WARN" }
        }

        if ($Winsock) {
            try { netsh winsock reset | Out-Null; Write-Log "Winsock reset (reboot recommended)" "OK" }
            catch { Write-Log "Winsock reset failed" "WARN" }
        }

        if ($Tcpip) {
            try { netsh int ip reset | Out-Null; Write-Log "TCP/IP reset (reboot recommended)" "OK" }
            catch { Write-Log "TCP/IP reset failed" "WARN" }
        }

        if ($Arp) {
            try { netsh interface ip delete arpcache | Out-Null; Write-Log "ARP cache cleared" "OK" }
            catch { Write-Log "ARP clear failed" "WARN" }
        }

        if ($Netbios) {
            try { nbtstat -R | Out-Null; Write-Log "NetBIOS cache cleared" "OK" }
            catch { Write-Log "NetBIOS clear failed" "WARN" }
        }

        if ($Proxy) {
            try { netsh winhttp reset proxy | Out-Null; Write-Log "WinHTTP proxy reset" "OK" }
            catch { Write-Log "Proxy reset failed" "WARN" }
        }

        if ($FirewallR) {
            try { netsh advfirewall reset | Out-Null; Write-Log "Firewall reset to defaults" "OK" }
            catch { Write-Log "Firewall reset failed" "WARN" }
        }

        if ($ShowIp) {
            Write-Log "IP Configuration:" "INFO"
            try {
                Get-NetIPConfiguration | Where-Object { $_.IPv4Address } | ForEach-Object {
                    Write-Log "  $($_.InterfaceAlias) - $($_.IPv4Address.IPAddress) GW: $($_.IPv4DefaultGateway.NextHop)" "INFO"
                }
            } catch { Write-Log "IP info failed" "WARN" }
        }

        if ($ShowAdapters) {
            Write-Log "Network Adapters:" "INFO"
            try {
                Get-NetAdapter | ForEach-Object {
                    Write-Log "  $($_.Name) - $($_.Status) - $($_.LinkSpeed)" "INFO"
                }
            } catch { Write-Log "Adapter list failed" "WARN" }
        }

        if ($PingTest) {
            Write-Log "Pinging 8.8.8.8..." "INFO"
            try {
                $r = Test-Connection 8.8.8.8 -Count 4 -ErrorAction Stop
                $avg = ($r | Measure-Object -Property ResponseTime -Average).Average
                Write-Log "Ping OK - avg $([math]::Round($avg)) ms" "OK"
            } catch { Write-Log "Ping failed - no connectivity" "ERR" }
        }

        if ($DnsTest) {
            Write-Log "DNS lookup google.com..." "INFO"
            try {
                $d = Resolve-DnsName google.com -ErrorAction Stop
                Write-Log "DNS OK - $($d[0].IPAddress)" "OK"
            } catch { Write-Log "DNS lookup failed" "ERR" }
        }

        if ($TraceRoute) {
            Write-Log "Traceroute to 8.8.8.8 (may take a minute)..." "INFO"
            try {
                $tr = tracert -h 10 -w 500 8.8.8.8
                $tr | Select-Object -Skip 2 | Select-Object -First 12 | ForEach-Object {
                    Write-Log "  $_" "INFO"
                }
                Write-Log "Traceroute done" "OK"
            } catch { Write-Log "Traceroute failed" "WARN" }
        }

        if ($TcpOpt) {
            Write-Log "Applying TCP optimizations..." "INFO"
            try {
                netsh int tcp set global autotuninglevel=normal | Out-Null
                netsh int tcp set global rss=enabled | Out-Null
                $ifaces = Get-ChildItem "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
                foreach ($i in $ifaces) {
                    Set-ItemProperty -Path $i.PSPath -Name "TcpAckFrequency" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue
                    Set-ItemProperty -Path $i.PSPath -Name "TCPNoDelay"      -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue
                }
                Write-Log "TCP optimizations applied" "OK"
            } catch { Write-Log "TCP tweak failed" "WARN" }
        }

        if ($Mtu) {
            Write-Log "Setting MTU to 1500..." "INFO"
            try {
                $adapters = Get-NetAdapter | Where-Object { $_.Status -eq "Up" }
                foreach ($a in $adapters) {
                    netsh interface ipv4 set subinterface "$($a.Name)" mtu=1500 store=persistent | Out-Null
                }
                Write-Log "MTU set to 1500" "OK"
            } catch { Write-Log "MTU set failed" "WARN" }
        }

        Set-Status "Network tools complete" "#3FB950"
        Write-Log "Network tools finished" "HEAD"
    }

    # =================================================================
    #  OPTIMIZE
    # =================================================================
    function Invoke-Optimize {
        param([bool]$Ultimate,[bool]$HighPerf,[bool]$Hibernate,[bool]$Svcs,[bool]$Visual,
              [bool]$GameBar,[bool]$Startup,[bool]$Temp,[bool]$Recycle,[bool]$Prefetch,
              [bool]$ShutUp,[bool]$SecUpdate)

        Set-Status "Optimizing..." "#8957E5"
        Write-Log "Optimize started" "HEAD"

        if ($Ultimate) {
            Write-Log "Activating Ultimate Performance power plan..." "INFO"
            $guid = "e9a42b02-d5df-448d-aa00-03f14749eb61"
            $ok = $false
            try {
                $out = powercfg -duplicatescheme $guid 2>&1
                Start-Sleep -Milliseconds 300
                $dupGuid = $guid
                if ($out -match "([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})") {
                    $dupGuid = $matches[1]
                }
                powercfg -setactive $dupGuid 2>&1 | Out-Null
                $active = (powercfg -getactivescheme) -join " "
                if ($active -match "Ultimate|e9a42b02") {
                    Write-Log "Ultimate Performance ACTIVATED" "OK"
                    $ok = $true
                }
            } catch {
                Write-Log "Ultimate Performance failed: $_" "WARN"
            }

            if (-not $ok -and $HighPerf) {
                Write-Log "Falling back to High Performance..." "WARN"
                try {
                    powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 2>&1 | Out-Null
                    Write-Log "High Performance activated" "OK"
                } catch { Write-Log "Power plan activation failed" "ERR" }
            }
        }

        if ($Svcs) {
            Write-Log "Disabling unnecessary services..." "INFO"
            foreach ($s in @("Fax","RemoteRegistry","RetailDemo","MapsBroker","WMPNetworkSvc")) {
                try {
                    Stop-Service -Name $s -Force -ErrorAction SilentlyContinue
                    Set-Service -Name $s -StartupType Disabled -ErrorAction SilentlyContinue
                    Write-Log "Disabled: $s" "OK"
                } catch { Write-Log "Skip: $s" "WARN" }
            }
        }

        if ($Visual) {
            try {
                $vp = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects"
                if (-not (Test-Path $vp)) { New-Item -Path $vp -Force | Out-Null }
                Set-ItemProperty -Path $vp -Name "VisualFXSetting" -Value 2 -Type DWord -Force
                Write-Log "Visual effects set to Best Performance" "OK"
            } catch { Write-Log "Visual tweak failed" "WARN" }
        }

        if ($GameBar) {
            try {
                $gb = "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR"
                if (-not (Test-Path $gb)) { New-Item -Path $gb -Force | Out-Null }
                Set-ItemProperty -Path $gb -Name "AppCaptureEnabled" -Value 0 -Type DWord -Force
                $gc = "HKCU:\System\GameConfigStore"
                if (-not (Test-Path $gc)) { New-Item -Path $gc -Force | Out-Null }
                Set-ItemProperty -Path $gc -Name "GameDVR_Enabled" -Value 0 -Type DWord -Force
                Write-Log "Game Bar and DVR disabled" "OK"
            } catch { Write-Log "Game Bar tweak failed" "WARN" }
        }

        if ($Startup) {
            try {
                $sp = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize"
                if (-not (Test-Path $sp)) { New-Item -Path $sp -Force | Out-Null }
                Set-ItemProperty -Path $sp -Name "StartupDelayInMSec" -Value 0 -Type DWord -Force
                Write-Log "Startup delay disabled" "OK"
            } catch { Write-Log "Startup tweak failed" "WARN" }
        }

        if ($Hibernate) {
            try { powercfg -h off; Write-Log "Hibernation disabled" "OK" }
            catch { Write-Log "Hibernation tweak failed" "WARN" }
        }

        if ($Temp) {
            Write-Log "Cleaning temp files..." "INFO"
            foreach ($p in @("$env:TEMP\*","$env:SystemRoot\Temp\*",
                             "$env:SystemRoot\SoftwareDistribution\Download\*",
                             "$env:LOCALAPPDATA\Temp\*")) {
                try { Remove-Item $p -Recurse -Force -ErrorAction SilentlyContinue; Write-Log "Cleaned $p" "OK" } catch {}
            }
        }

        if ($Recycle) {
            try { Clear-RecycleBin -Force -ErrorAction SilentlyContinue; Write-Log "Recycle Bin emptied" "OK" }
            catch { Write-Log "Recycle Bin already empty" "WARN" }
        }

        if ($Prefetch) {
            try {
                Remove-Item "$env:SystemRoot\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue
                Write-Log "Prefetch cleared" "OK"
            } catch { Write-Log "Prefetch clear failed" "WARN" }
        }

        if ($ShutUp) {
            Write-Log "Installing O and O ShutUp10++..." "INFO"
            $dir = "$env:ProgramData\NeutraTool"
            $exe = "$dir\OOSU10.exe"
            $cfg = "$dir\ooshutup10.cfg"
            if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }

            $ok = $false
            if (-not (Test-Path $exe)) {
                try {
                    Invoke-WebRequest -Uri "https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe" `
                        -OutFile $exe -UseBasicParsing -TimeoutSec 60 -ErrorAction Stop
                    $ok = $true
                    Write-Log "Downloaded O and O ShutUp10" "OK"
                } catch { Write-Log "Download failed" "WARN" }
            } else { $ok = $true }

            if (-not $ok -and (Test-Command winget)) {
                Install-ViaWinget -Id "OO-Software.ShutUp10" -Friendly "O and O ShutUp10"
                $ok = (Test-Path $exe)
            }

            if ($ok -and (Test-Path $exe)) {
                $content = @"
Actions = 1
DisableTelemetry = 1
DisableCortana = 1
DisableLocation = 1
DisableAdvertisingID = 1
DisableFeedback = 1
DisableSync = 1
DisableInking = 1
DisableSpeechRecognition = 1
DisableDefender = 0
DisableWindowsUpdate = 0
"@
                Set-Content -Path $cfg -Value $content -Encoding UTF8
                try {
                    Start-Process $exe -ArgumentList "`"$cfg`" /quiet" -Wait -NoNewWindow
                    Write-Log "Applied ShutUp10 privacy preset" "OK"
                } catch { Write-Log "ShutUp10 run failed" "WARN" }
            }
        }

        if ($SecUpdate) {
            Write-Log "Configuring Windows Update (security only)..." "INFO"
            try {
                $au = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
                if (-not (Test-Path $au)) { New-Item -Path $au -Force | Out-Null }
                Set-ItemProperty -Path $au -Name "NoAutoUpdate" -Value 0 -Type DWord -Force
                Set-ItemProperty -Path $au -Name "AUOptions" -Value 2 -Type DWord -Force
                $wu = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
                if (-not (Test-Path $wu)) { New-Item -Path $wu -Force | Out-Null }
                Set-ItemProperty -Path $wu -Name "DeferFeatureUpdates" -Value 1 -Type DWord -Force
                Set-ItemProperty -Path $wu -Name "DeferFeatureUpdatesPeriodInDays" -Value 365 -Type DWord -Force
                Write-Log "Windows Update: security only" "OK"
            } catch { Write-Log "Update config failed" "WARN" }
        }

        Set-Status "Optimization complete" "#3FB950"
        Write-Log "Optimize finished. Restart recommended." "HEAD"
    }

    # =================================================================
    #  DEV TOOLS
    # =================================================================
    function Invoke-DevTools {
        param([hashtable]$Picks)

        Set-Status "Installing dev tools..." "#238636"
        Write-Log "Dev tools install started" "HEAD"

        if (-not (Test-Command winget)) {
            Write-Log "winget not found - install 'App Installer' from Microsoft Store" "ERR"
            Set-Status "winget missing" "#DA3633"
            return
        }

        foreach ($k in $Picks.Keys) {
            if ($Picks[$k]) { Install-ViaWinget -Id $k -Friendly $k }
        }

        Set-Status "Dev install complete" "#3FB950"
        Write-Log "Dev tools install finished" "HEAD"
    }

    # =================================================================
    #  NAV HANDLERS (unrolled - each button its own scriptblock)
    # =================================================================
    $Global:Window.FindName("NavDebloat").Add_Click({  Show-Panel "Debloat"  })
    $Global:Window.FindName("NavVirus").Add_Click({    Show-Panel "Virus"    })
    $Global:Window.FindName("NavNetwork").Add_Click({  Show-Panel "Network"  })
    $Global:Window.FindName("NavOptimize").Add_Click({ Show-Panel "Optimize" })
    $Global:Window.FindName("NavDev").Add_Click({      Show-Panel "Dev"      })
    $Global:Window.FindName("NavSettings").Add_Click({ Show-Panel "Settings" })

    # =================================================================
    #  ACTION HANDLERS
    # =================================================================
    $Global:Window.FindName("BtnDebloat").Add_Click({
        try {
            Invoke-Debloat `
                -Apps      ([bool]$Global:Window.FindName("ChkApps").IsChecked) `
                -Prov      ([bool]$Global:Window.FindName("ChkProv").IsChecked) `
                -OneDrive  ([bool]$Global:Window.FindName("ChkOneDrive").IsChecked) `
                -Teams     ([bool]$Global:Window.FindName("ChkTeams").IsChecked) `
                -Telemetry ([bool]$Global:Window.FindName("ChkTelemetry").IsChecked) `
                -Copilot   ([bool]$Global:Window.FindName("ChkCopilot").IsChecked) `
                -Widgets   ([bool]$Global:Window.FindName("ChkWidgets").IsChecked) `
                -SearchWeb ([bool]$Global:Window.FindName("ChkSearchWeb").IsChecked) `
                -Ads       ([bool]$Global:Window.FindName("ChkAds").IsChecked)
        } catch { Write-Log "Debloat crashed: $_" "ERR" }
    })

    $Global:Window.FindName("BtnVirus").Add_Click({
        try {
            Invoke-VirusScan `
                -Quick      ([bool]$Global:Window.FindName("ChkQuick").IsChecked) `
                -Full       ([bool]$Global:Window.FindName("ChkFull").IsChecked) `
                -Offline    ([bool]$Global:Window.FindName("ChkOffline").IsChecked) `
                -Custom     ([bool]$Global:Window.FindName("ChkCustom").IsChecked) `
                -CustomPath ($Global:Window.FindName("TxtScanPath").Text) `
                -Threats    ([bool]$Global:Window.FindName("ChkThreats").IsChecked) `
                -Rootkit    ([bool]$Global:Window.FindName("ChkRootkit").IsChecked) `
                -UpdateDef  ([bool]$Global:Window.FindName("ChkUpdateDef").IsChecked) `
                -Firewall   ([bool]$Global:Window.FindName("ChkFirewall").IsChecked) `
                -ASR        ([bool]$Global:Window.FindName("ChkASR").IsChecked) `
                -CFA        ([bool]$Global:Window.FindName("ChkCFA").IsChecked) `
                -NetProt    ([bool]$Global:Window.FindName("ChkNetProt").IsChecked) `
                -SMB1       ([bool]$Global:Window.FindName("ChkSMB1").IsChecked)
        } catch { Write-Log "Virus scan crashed: $_" "ERR" }
    })

    $Global:Window.FindName("BtnNetwork").Add_Click({
        try {
            Invoke-Network `
                -FlushDns     ([bool]$Global:Window.FindName("ChkFlushDns").IsChecked) `
                -ReleaseIp    ([bool]$Global:Window.FindName("ChkReleaseIp").IsChecked) `
                -RenewIp      ([bool]$Global:Window.FindName("ChkRenewIp").IsChecked) `
                -Winsock      ([bool]$Global:Window.FindName("ChkWinsock").IsChecked) `
                -Tcpip        ([bool]$Global:Window.FindName("ChkTcpip").IsChecked) `
                -Arp          ([bool]$Global:Window.FindName("ChkArp").IsChecked) `
                -Netbios      ([bool]$Global:Window.FindName("ChkNetbios").IsChecked) `
                -Proxy        ([bool]$Global:Window.FindName("ChkProxy").IsChecked) `
                -FirewallR    ([bool]$Global:Window.FindName("ChkFirewallR").IsChecked) `
                -ShowIp       ([bool]$Global:Window.FindName("ChkShowIp").IsChecked) `
                -ShowAdapters ([bool]$Global:Window.FindName("ChkShowAdapters").IsChecked) `
                -PingTest     ([bool]$Global:Window.FindName("ChkPingTest").IsChecked) `
                -DnsTest      ([bool]$Global:Window.FindName("ChkDnsTest").IsChecked) `
                -TraceRoute   ([bool]$Global:Window.FindName("ChkTraceRoute").IsChecked) `
                -TcpOpt       ([bool]$Global:Window.FindName("ChkTcpOpt").IsChecked) `
                -Mtu          ([bool]$Global:Window.FindName("ChkMtu").IsChecked)
        } catch { Write-Log "Network tools crashed: $_" "ERR" }
    })

    $Global:Window.FindName("BtnOptimize").Add_Click({
        try {
            Invoke-Optimize `
                -Ultimate  ([bool]$Global:Window.FindName("ChkUltimate").IsChecked) `
                -HighPerf  ([bool]$Global:Window.FindName("ChkHighPerf").IsChecked) `
                -Hibernate ([bool]$Global:Window.FindName("ChkHibernate").IsChecked) `
                -Svcs      ([bool]$Global:Window.FindName("ChkSvcs").IsChecked) `
                -Visual    ([bool]$Global:Window.FindName("ChkVisual").IsChecked) `
                -GameBar   ([bool]$Global:Window.FindName("ChkGameBar").IsChecked) `
                -Startup   ([bool]$Global:Window.FindName("ChkStartup").IsChecked) `
                -Temp      ([bool]$Global:Window.FindName("ChkTemp").IsChecked) `
                -Recycle   ([bool]$Global:Window.FindName("ChkRecycle").IsChecked) `
                -Prefetch  ([bool]$Global:Window.FindName("ChkPrefetch").IsChecked) `
                -ShutUp    ([bool]$Global:Window.FindName("ChkShutUp").IsChecked) `
                -SecUpdate ([bool]$Global:Window.FindName("ChkSecUpdate").IsChecked)
        } catch { Write-Log "Optimize crashed: $_" "ERR" }
    })

    $Global:Window.FindName("BtnDev").Add_Click({
        try {
            $picks = @{
                "Python.Python.3.12"                      = [bool]$Global:Window.FindName("ChkPython").IsChecked
                "OpenJS.NodeJS.LTS"                       = [bool]$Global:Window.FindName("ChkNode").IsChecked
                "EclipseAdoptium.Temurin.21.JDK"          = [bool]$Global:Window.FindName("ChkJava").IsChecked
                "GoLang.Go"                               = [bool]$Global:Window.FindName("ChkGo").IsChecked
                "Rustlang.Rustup"                         = [bool]$Global:Window.FindName("ChkRust").IsChecked
                "PHP.PHP"                                 = [bool]$Global:Window.FindName("ChkPhp").IsChecked
                "RubyInstallerTeam.Ruby"                  = [bool]$Global:Window.FindName("ChkRuby").IsChecked
                "Microsoft.DotNet.SDK.8"                  = [bool]$Global:Window.FindName("ChkDotNet").IsChecked
                "Microsoft.VisualStudioCode"              = [bool]$Global:Window.FindName("ChkVsCode").IsChecked
                "Microsoft.PowerShell"                    = [bool]$Global:Window.FindName("ChkPwsh7").IsChecked
                "Git.Git"                                 = [bool]$Global:Window.FindName("ChkGit").IsChecked
                "Microsoft.WindowsTerminal"               = [bool]$Global:Window.FindName("ChkWinTerm").IsChecked
                "Neovim.Neovim"                           = [bool]$Global:Window.FindName("ChkNeovim").IsChecked
                "Kitware.CMake"                           = [bool]$Global:Window.FindName("ChkCmake").IsChecked
                "LLVM.LLVM"                               = [bool]$Global:Window.FindName("ChkLLVM").IsChecked
                "Microsoft.VisualStudio.2022.BuildTools"  = [bool]$Global:Window.FindName("ChkVSBT").IsChecked
                "Docker.DockerDesktop"                    = [bool]$Global:Window.FindName("ChkDocker").IsChecked
                "Postman.Postman"                         = [bool]$Global:Window.FindName("ChkPostman").IsChecked
                "dbeaver.dbeaver"                         = [bool]$Global:Window.FindName("ChkDBeaver").IsChecked
            }
            Invoke-DevTools -Picks $picks
        } catch { Write-Log "Dev install crashed: $_" "ERR" }
    })

    $Global:Window.FindName("BtnSysInfo").Add_Click({
        try {
            Write-Log "System information" "HEAD"
            $os  = Get-CimInstance Win32_OperatingSystem
            $cs  = Get-CimInstance Win32_ComputerSystem
            $cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
            Write-Log "OS: $($os.Caption) build $($os.BuildNumber)" "INFO"
            Write-Log "CPU: $($cpu.Name)" "INFO"
            Write-Log "RAM: $([math]::Round($cs.TotalPhysicalMemory/1GB,1)) GB" "INFO"
            Write-Log "Host: $($cs.Name)" "INFO"
            try {
                $up = (Get-Date) - $os.LastBootUpTime
                Write-Log "Uptime: $($up.Days)d $($up.Hours)h $($up.Minutes)m" "INFO"
            } catch {}
        } catch { Write-Log "System info failed: $_" "WARN" }
    })

    # =================================================================
    #  THEME COMBO
    # =================================================================
    $cmb = $Global:Window.FindName("CmbTheme")
    foreach ($name in $Global:Themes.Keys) { [void]$cmb.Items.Add($name) }
    $cmb.Add_SelectionChanged({
        try {
            $sel = $Global:Window.FindName("CmbTheme").SelectedItem
            if ($sel) { Set-Theme $sel }
        } catch { Write-Log "Theme change error: $_" "ERR" }
    })

    # =================================================================
    #  GO
    # =================================================================
    Write-Log "NeutraTool v2.3 loaded - Simple. Useful. Done." "HEAD"
    Write-Log "by littlleprince - Discord: littlleprince - neutracocontact@gmail.com" "INFO"

    Set-Theme "GitHub Dark"
    $cmb.SelectedIndex = 0
    Show-Panel "Debloat"

    $Global:Window.ShowDialog() | Out-Null

} catch {
    $log = "$env:TEMP\NeutraTool-error.log"
    "NeutraTool fatal error at $(Get-Date)`r`n$_`r`n$($_.ScriptStackTrace)" | Out-File $log -Encoding UTF8
    try {
        [System.Windows.MessageBox]::Show("NeutraTool crashed.`n`n$($_.Exception.Message)`n`nLog: $log","NeutraTool Error")
    } catch {
        Write-Host "NeutraTool crashed: $_"
        Write-Host "Log: $log"
    }
}
