# =====================================================================
#  NeutraTool v2.4 - Debloat / Virus / Network / Optimize / Dev / Settings
#  Slogan: Simple. Useful. Done.
#  by littlleprince
#  Discord: littlleprince
#  Contact: neutracocontact@gmail.com
#  Website: https://neutraco.vercel.app/
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
        Height="800" Width="1200"
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
    <SolidColorBrush x:Key="OkBrush"      Color="#3FB950"/>
    <SolidColorBrush x:Key="WarnBrush"    Color="#D29922"/>
    <SolidColorBrush x:Key="ErrBrush"     Color="#F85149"/>

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
            <ControlTemplate.Triggers>
              <Trigger Property="IsMouseOver" Value="True">
                <Setter TargetName="bd" Property="Opacity" Value="0.72"/>
              </Trigger>
            </ControlTemplate.Triggers>
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
              <Trigger Property="IsPressed" Value="True">
                <Setter TargetName="bd" Property="Opacity" Value="0.65"/>
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
      <Setter Property="BorderBrush" Value="{DynamicResource BorderBrushX}"/>
      <Setter Property="BorderThickness" Value="1"/>
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

          <Button x:Name="NavDebloat"  Style="{StaticResource NavBtn}" Content="Debloat"      ToolTip="Remove preinstalled apps, telemetry, Copilot, ads."/>
          <Button x:Name="NavVirus"    Style="{StaticResource NavBtn}" Content="Virus Scan"   Margin="0,2,0,0" ToolTip="Defender scans, ASR, firewall, CFA."/>
          <Button x:Name="NavNetwork"  Style="{StaticResource NavBtn}" Content="Network"      Margin="0,2,0,0" ToolTip="Reset adapters, flush DNS, diagnostics."/>
          <Button x:Name="NavOptimize" Style="{StaticResource NavBtn}" Content="Optimize"     Margin="0,2,0,0" ToolTip="Power plans, tweaks, junk cleanup."/>
          <Button x:Name="NavDev"      Style="{StaticResource NavBtn}" Content="Dev Tools"    Margin="0,2,0,0" ToolTip="Install languages, editors, tooling via winget."/>
          <Button x:Name="NavSettings" Style="{StaticResource NavBtn}" Content="Settings"     Margin="0,2,0,0" ToolTip="Theme, about, system info."/>

          <Border Background="{DynamicResource PanelBrush}" CornerRadius="6" Padding="12" Margin="0,24,0,0"
                  BorderBrush="{DynamicResource BorderBrushX}" BorderThickness="1">
            <StackPanel>
              <StackPanel Orientation="Horizontal">
                <Ellipse x:Name="StatusDot" Width="8" Height="8" Fill="{DynamicResource OkBrush}" VerticalAlignment="Center"/>
                <TextBlock Text="STATUS" Foreground="{DynamicResource SubBrush}" FontSize="10" FontWeight="Bold" Margin="6,0,0,0"/>
              </StackPanel>
              <TextBlock x:Name="StatusText" Text="Ready" Foreground="{DynamicResource OkBrush}" FontSize="12" Margin="0,6,0,0" TextWrapping="Wrap"/>
            </StackPanel>
          </Border>
        </StackPanel>

        <StackPanel Grid.Row="2" Margin="8,16,0,0">
          <Border Height="1" Background="{DynamicResource BorderBrushX}" Margin="0,0,8,12"/>
          <TextBlock Text="Built by littlleprince" Foreground="{DynamicResource TextBrush}" FontSize="11" FontWeight="SemiBold"/>
          <TextBlock Text="Discord: littlleprince" Foreground="{DynamicResource SubBrush}" FontSize="10" Margin="0,2,0,0"/>
          <TextBlock Text="neutracocontact@gmail.com" Foreground="{DynamicResource SubBrush}" FontSize="10" Margin="0,2,0,0" TextWrapping="Wrap"/>
          <TextBlock Text="Website: neutraco.vercel.app" Foreground="{DynamicResource AccentBrush}" FontSize="10" Margin="0,4,0,0" TextWrapping="Wrap" Cursor="Hand" x:Name="SidebarSiteLink"/>
          <TextBlock Text="v2.4" Foreground="{DynamicResource SubBrush}" FontSize="9" Margin="0,6,0,0"/>
        </StackPanel>
      </Grid>
    </Border>

    <Grid Grid.Column="1" Margin="24,16,24,16">
      <Grid.RowDefinitions>
        <RowDefinition Height="*"/>
        <RowDefinition Height="200"/>
      </Grid.RowDefinitions>

      <Grid Grid.Row="0">

        <!-- ==================== DEBLOAT ==================== -->
        <ScrollViewer x:Name="PanelDebloat" VerticalScrollBarVisibility="Auto">
          <StackPanel>
            <TextBlock Text="Windows Debloat" Style="{StaticResource CardTitle}"/>
            <TextBlock Text="Strip preinstalled junk, kill telemetry, remove AI features." Style="{StaticResource CardSub}"/>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="BLOATWARE" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkApps"     Content="Remove preinstalled apps" IsChecked="True"
                          ToolTip="Removes Xbox, Cortana, Bing apps, Candy Crush, News, Solitaire and about 40 other preinstalled Microsoft apps. Recommended."/>
                <CheckBox x:Name="ChkProv"     Content="Remove provisioned packages" IsChecked="True"
                          ToolTip="Blocks removed apps from being auto-reinstalled for new user accounts. Recommended."/>
                <CheckBox x:Name="ChkOneDrive" Content="Uninstall OneDrive" IsChecked="False"
                          ToolTip="Fully uninstalls OneDrive. You will lose cloud sync. Only enable if you don't use it."/>
                <CheckBox x:Name="ChkTeams"    Content="Uninstall Microsoft Teams (consumer)" IsChecked="True"
                          ToolTip="Removes the personal Teams chat app that gets bundled with Windows."/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="TELEMETRY AND AI" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkTelemetry" Content="Disable telemetry services" IsChecked="True"
                          ToolTip="Stops DiagTrack and dmwappushservice and sets AllowTelemetry=0."/>
                <CheckBox x:Name="ChkCopilot"   Content="Disable Copilot and Recall" IsChecked="True"
                          ToolTip="Turns off Windows Copilot and Recall/AI data analysis via policy."/>
                <CheckBox x:Name="ChkWidgets"   Content="Disable Widgets / News" IsChecked="True"
                          ToolTip="Removes the Widgets panel and News and Interests from the taskbar."/>
                <CheckBox x:Name="ChkSearchWeb" Content="Disable web search in Start" IsChecked="True"
                          ToolTip="Stops Start Menu search from hitting Bing."/>
                <CheckBox x:Name="ChkAds"       Content="Disable ads, tips, suggested content" IsChecked="True"
                          ToolTip="Disables Windows Spotlight ads and suggested apps."/>
              </StackPanel>
            </Border>

            <Button x:Name="BtnDebloat" Style="{StaticResource ActBtn}" Content="Run Debloat" HorizontalAlignment="Left" Margin="0,4,0,0"
                    ToolTip="Apply all selected debloat actions. Sign out or restart afterwards."/>
          </StackPanel>
        </ScrollViewer>

        <!-- ==================== VIRUS ==================== -->
        <ScrollViewer x:Name="PanelVirus" VerticalScrollBarVisibility="Auto" Visibility="Collapsed">
          <StackPanel>
            <TextBlock Text="Virus Scan" Style="{StaticResource CardTitle}"/>
            <TextBlock Text="Deep malware hunting with Windows Defender, offline scan, and custom path scans." Style="{StaticResource CardSub}"/>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="SCAN TYPE" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkQuick"   Content="Quick Scan" IsChecked="True"
                          ToolTip="2-5 min. Scans common malware locations: registry run keys, startup folders, temp."/>
                <CheckBox x:Name="ChkFull"    Content="Full Scan" IsChecked="False"
                          ToolTip="30-60 min. Scans every file on every drive. Slow but thorough."/>
                <CheckBox x:Name="ChkOffline" Content="Offline Scan" IsChecked="False"
                          ToolTip="Reboots and scans before Windows loads. Best for rootkits and persistent threats."/>
                <CheckBox x:Name="ChkCustom"  Content="Custom Path Scan" IsChecked="False"
                          ToolTip="Scan a specific folder you type below."/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="CUSTOM PATH" Style="{StaticResource SectionTitle}"/>
                <TextBox x:Name="TxtScanPath" Background="{DynamicResource BgBrush}" Foreground="{DynamicResource TextBrush}"
                         BorderBrush="{DynamicResource BorderBrushX}" Padding="8,6" FontSize="12"
                         ToolTip="Example: C:\Users\You\Downloads"/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="ACTIONS" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkThreats"   Content="Auto-remove detected threats" IsChecked="True"
                          ToolTip="Any threat Defender finds is quarantined/removed automatically."/>
                <CheckBox x:Name="ChkRootkit"   Content="Driver heuristic scan" IsChecked="True"
                          ToolTip="Flags newly created, tiny .sys driver files as suspicious."/>
                <CheckBox x:Name="ChkUpdateDef" Content="Update definitions first" IsChecked="True"
                          ToolTip="Refresh virus signatures before scanning."/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="DEFENDER HARDENING" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkFirewall" Content="Enable Windows Firewall (all profiles)" IsChecked="True"
                          ToolTip="Enables firewall for Domain, Private and Public profiles."/>
                <CheckBox x:Name="ChkASR"      Content="Enable Attack Surface Reduction rules" IsChecked="True"
                          ToolTip="Blocks Office macros, script abuse, credential stealing. Best-practice ASR set."/>
                <CheckBox x:Name="ChkCFA"      Content="Enable Controlled Folder Access" IsChecked="True"
                          ToolTip="Ransomware protection - only allowed apps can write to Documents, Pictures, etc."/>
                <CheckBox x:Name="ChkNetProt"  Content="Enable Network Protection" IsChecked="True"
                          ToolTip="Blocks connections to known malicious hosts."/>
                <CheckBox x:Name="ChkSMB1"     Content="Disable legacy SMBv1" IsChecked="True"
                          ToolTip="SMBv1 is ancient and exploited by WannaCry. Recommended to disable."/>
              </StackPanel>
            </Border>

            <Button x:Name="BtnVirus" Style="{StaticResource RedBtn}" Content="Scan and Clean" HorizontalAlignment="Left" Margin="0,4,0,0"
                    ToolTip="Runs the selected scan(s) and applies the hardening options above."/>
          </StackPanel>
        </ScrollViewer>

        <!-- ==================== NETWORK ==================== -->
        <ScrollViewer x:Name="PanelNetwork" VerticalScrollBarVisibility="Auto" Visibility="Collapsed">
          <StackPanel>
            <TextBlock Text="Network" Style="{StaticResource CardTitle}"/>
            <TextBlock Text="Reset adapters, flush DNS, fix connectivity issues, and run diagnostics." Style="{StaticResource CardSub}"/>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="RESETS" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkFlushDns"  Content="Flush DNS cache" IsChecked="True"
                          ToolTip="Clears cached DNS entries. Fixes stale/bad lookups."/>
                <CheckBox x:Name="ChkReleaseIp" Content="Release IP (DHCP)" IsChecked="False"
                          ToolTip="WARNING: disconnects your network until you renew. Only use if you know what you're doing."/>
                <CheckBox x:Name="ChkRenewIp"   Content="Renew IP (DHCP)" IsChecked="False"
                          ToolTip="Requests a new IP from your router. Run AFTER release."/>
                <CheckBox x:Name="ChkWinsock"   Content="Reset Winsock" IsChecked="True"
                          ToolTip="Resets the Windows socket catalog. Fixes many 'no internet' bugs. Needs reboot."/>
                <CheckBox x:Name="ChkTcpip"     Content="Reset TCP/IP stack" IsChecked="True"
                          ToolTip="Restores TCP/IP to defaults. Needs reboot."/>
                <CheckBox x:Name="ChkArp"       Content="Clear ARP cache" IsChecked="True"
                          ToolTip="Clears stale MAC-to-IP mappings."/>
                <CheckBox x:Name="ChkNetbios"   Content="Reset NetBIOS cache" IsChecked="True"
                          ToolTip="Clears the NetBIOS name cache."/>
                <CheckBox x:Name="ChkProxy"     Content="Reset WinHTTP proxy" IsChecked="True"
                          ToolTip="Clears any leftover system-level proxy that blocks internet."/>
                <CheckBox x:Name="ChkFirewallR" Content="Reset Windows Firewall" IsChecked="False"
                          ToolTip="Restores firewall to Windows defaults. Wipes your custom rules."/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="DIAGNOSTICS" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkShowIp"       Content="Show IP configuration" IsChecked="True"
                          ToolTip="Lists each adapter's IP and gateway."/>
                <CheckBox x:Name="ChkShowAdapters" Content="Show network adapters" IsChecked="True"
                          ToolTip="Lists all adapters, link state and speed."/>
                <CheckBox x:Name="ChkPingTest"     Content="Ping 8.8.8.8" IsChecked="True"
                          ToolTip="Verifies internet reachability with a live ping."/>
                <CheckBox x:Name="ChkDnsTest"      Content="Resolve google.com" IsChecked="True"
                          ToolTip="Verifies DNS resolution is working."/>
                <CheckBox x:Name="ChkTraceRoute"   Content="Traceroute to 8.8.8.8" IsChecked="False"
                          ToolTip="Shows each hop. Can take up to a minute."/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="ADVANCED" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkTcpOpt" Content="TCP optimizations" IsChecked="False"
                          ToolTip="Disables Nagle, enables RSS. Helps latency for gaming."/>
                <CheckBox x:Name="ChkMtu"    Content="Set MTU to 1500" IsChecked="False"
                          ToolTip="Forces a standard 1500-byte MTU on all active adapters."/>
              </StackPanel>
            </Border>

            <Button x:Name="BtnNetwork" Style="{StaticResource BlueBtn}" Content="Run Network Tools" HorizontalAlignment="Left" Margin="0,4,0,0"
                    ToolTip="Runs every selected network operation with per-step error handling."/>
          </StackPanel>
        </ScrollViewer>

        <!-- ==================== OPTIMIZE ==================== -->
        <ScrollViewer x:Name="PanelOptimize" VerticalScrollBarVisibility="Auto" Visibility="Collapsed">
          <StackPanel>
            <TextBlock Text="Optimize" Style="{StaticResource CardTitle}"/>
            <TextBlock Text="Performance tuning, power plans, junk cleanup, and privacy presets." Style="{StaticResource CardSub}"/>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="POWER PLAN" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkUltimate"  Content="Enable Ultimate Performance" IsChecked="True"
                          ToolTip="Activates the hidden Ultimate Performance power plan. Best for desktops."/>
                <CheckBox x:Name="ChkHighPerf"  Content="Fallback to High Performance" IsChecked="True"
                          ToolTip="Used if Ultimate isn't available on this machine."/>
                <CheckBox x:Name="ChkHibernate" Content="Disable hibernation" IsChecked="False"
                          ToolTip="Frees disk space equal to your RAM. Removes hiberfil.sys."/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="PERFORMANCE TWEAKS" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkSvcs"    Content="Disable unnecessary services" IsChecked="True"
                          ToolTip="Stops Fax, RemoteRegistry, RetailDemo, MapsBroker, WMPNetworkSvc."/>
                <CheckBox x:Name="ChkVisual"  Content="Visual effects - Best Performance" IsChecked="True"
                          ToolTip="Turns off animations and shadows for snappier UI."/>
                <CheckBox x:Name="ChkGameBar" Content="Disable Game Bar and DVR" IsChecked="True"
                          ToolTip="Removes background game recording overhead."/>
                <CheckBox x:Name="ChkStartup" Content="Disable startup delay" IsChecked="True"
                          ToolTip="Removes the ~10 second delay Windows adds before launching startup apps."/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="JUNK CLEANUP" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkTemp"     Content="Clean temp files + WU cache" IsChecked="True"
                          ToolTip="Empties TEMP folders and the Windows Update download cache."/>
                <CheckBox x:Name="ChkRecycle"  Content="Empty Recycle Bin" IsChecked="True"
                          ToolTip="Permanently deletes everything in the Recycle Bin."/>
                <CheckBox x:Name="ChkPrefetch" Content="Clear Prefetch" IsChecked="False"
                          ToolTip="Deletes Prefetch files. Only do this if troubleshooting startup issues."/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="PRIVACY" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkShutUp"    Content="Install and apply O and O ShutUp10++" IsChecked="True"
                          ToolTip="Downloads ShutUp10 and applies a strong privacy preset."/>
                <CheckBox x:Name="ChkSecUpdate" Content="Security-only Windows Update" IsChecked="False"
                          ToolTip="Defers feature updates 365 days while keeping security patches."/>
              </StackPanel>
            </Border>

            <Button x:Name="BtnOptimize" Style="{StaticResource PurpleBtn}" Content="Apply Optimization" HorizontalAlignment="Left" Margin="0,4,0,0"
                    ToolTip="Applies every selected optimization. Restart recommended."/>
          </StackPanel>
        </ScrollViewer>

        <!-- ==================== DEV ==================== -->
        <ScrollViewer x:Name="PanelDev" VerticalScrollBarVisibility="Auto" Visibility="Collapsed">
          <StackPanel>
            <TextBlock Text="Dev Tools" Style="{StaticResource CardTitle}"/>
            <TextBlock Text="Auto-install programming languages and dev tools via winget." Style="{StaticResource CardSub}"/>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="LANGUAGES" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkPython" Content="Python 3.12" IsChecked="True" ToolTip="Python.Python.3.12"/>
                <CheckBox x:Name="ChkNode"   Content="Node.js LTS" IsChecked="True" ToolTip="OpenJS.NodeJS.LTS"/>
                <CheckBox x:Name="ChkJava"   Content="Eclipse Temurin JDK 21" IsChecked="True" ToolTip="EclipseAdoptium.Temurin.21.JDK"/>
                <CheckBox x:Name="ChkGo"     Content="Go" IsChecked="False" ToolTip="GoLang.Go"/>
                <CheckBox x:Name="ChkRust"   Content="Rust" IsChecked="False" ToolTip="Rustlang.Rustup"/>
                <CheckBox x:Name="ChkPhp"    Content="PHP" IsChecked="False" ToolTip="PHP.PHP"/>
                <CheckBox x:Name="ChkRuby"   Content="Ruby" IsChecked="False" ToolTip="RubyInstallerTeam.Ruby"/>
                <CheckBox x:Name="ChkDotNet" Content=".NET SDK 8" IsChecked="False" ToolTip="Microsoft.DotNet.SDK.8"/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="EDITORS AND SHELLS" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkVsCode"  Content="Visual Studio Code" IsChecked="True" ToolTip="Microsoft.VisualStudioCode"/>
                <CheckBox x:Name="ChkPwsh7"   Content="PowerShell 7" IsChecked="True" ToolTip="Microsoft.PowerShell"/>
                <CheckBox x:Name="ChkGit"     Content="Git for Windows" IsChecked="True" ToolTip="Git.Git"/>
                <CheckBox x:Name="ChkWinTerm" Content="Windows Terminal" IsChecked="True" ToolTip="Microsoft.WindowsTerminal"/>
                <CheckBox x:Name="ChkNeovim"  Content="Neovim" IsChecked="False" ToolTip="Neovim.Neovim"/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="BUILD AND UTILITIES" Style="{StaticResource SectionTitle}"/>
                <CheckBox x:Name="ChkCmake"   Content="CMake" IsChecked="False" ToolTip="Kitware.CMake"/>
                <CheckBox x:Name="ChkLLVM"    Content="LLVM / Clang" IsChecked="False" ToolTip="LLVM.LLVM"/>
                <CheckBox x:Name="ChkVSBT"    Content="VS 2022 Build Tools" IsChecked="False" ToolTip="Microsoft.VisualStudio.2022.BuildTools"/>
                <CheckBox x:Name="ChkDocker"  Content="Docker Desktop" IsChecked="False" ToolTip="Docker.DockerDesktop"/>
                <CheckBox x:Name="ChkPostman" Content="Postman" IsChecked="False" ToolTip="Postman.Postman"/>
                <CheckBox x:Name="ChkDBeaver" Content="DBeaver Community" IsChecked="False" ToolTip="dbeaver.dbeaver"/>
              </StackPanel>
            </Border>

            <Button x:Name="BtnDev" Style="{StaticResource ActBtn}" Content="Install Selected" HorizontalAlignment="Left" Margin="0,4,0,0"
                    ToolTip="Uses winget to install every checked item silently."/>
          </StackPanel>
        </ScrollViewer>

        <!-- ==================== SETTINGS ==================== -->
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
                          BorderBrush="{DynamicResource BorderBrushX}"
                          ToolTip="Changes the whole app's color scheme live."/>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="ABOUT" Style="{StaticResource SectionTitle}"/>
                <TextBlock Text="NeutraTool v2.4" Foreground="{DynamicResource TextBrush}" FontSize="14" FontWeight="Bold"/>
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

                <TextBlock Text="WEBSITE" Foreground="{DynamicResource SubBrush}" FontSize="10" FontWeight="Bold" Margin="0,10,0,4"/>
                <TextBlock x:Name="AboutSiteLink" FontSize="12" Cursor="Hand">
                  <Hyperlink x:Name="AboutSiteHyperlink" Foreground="{DynamicResource AccentBrush}">https://neutraco.vercel.app/</Hyperlink>
                </TextBlock>
              </StackPanel>
            </Border>

            <Border Style="{StaticResource Card}">
              <StackPanel>
                <TextBlock Text="SYSTEM INFO" Style="{StaticResource SectionTitle}"/>
                <Button x:Name="BtnSysInfo" Style="{StaticResource BlueBtn}" Content="Show System Info" HorizontalAlignment="Left"
                        ToolTip="Prints OS, CPU, RAM, hostname and uptime to the log."/>
              </StackPanel>
            </Border>
          </StackPanel>
        </ScrollViewer>

      </Grid>

      <Border Grid.Row="1" Background="{DynamicResource SidebarBrush}" CornerRadius="8" Margin="0,16,0,0" Padding="12"
              BorderBrush="{DynamicResource BorderBrushX}" BorderThickness="1">
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
    $Global:StatusDot  = $Global:Window.FindName("StatusDot")

    # =================================================================
    #  HELPERS
    # =================================================================
    function Pump-UI {
        try {
            $frame = New-Object System.Windows.Threading.DispatcherFrame
            $cb = [System.Windows.Threading.DispatcherOperationCallback]{
                param($f)
                $f.Continue = $false
                return $null
            }
            [System.Windows.Threading.Dispatcher]::CurrentDispatcher.BeginInvoke(
                [System.Windows.Threading.DispatcherPriority]::Background, $cb, $frame) | Out-Null
            [System.Windows.Threading.Dispatcher]::PushFrame($frame)
        } catch {}
    }

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
        try {
            $Global:LogBox.AppendText("$t $p $Msg`r`n")
            $Global:LogBox.ScrollToEnd()
        } catch {}
        Pump-UI
    }

    function New-BrushFromHex {
        param([string]$Hex)
        try {
            $c = [Windows.Media.ColorConverter]::ConvertFromString($Hex)
            return [Windows.Media.SolidColorBrush]::new($c)
        } catch { return [Windows.Media.Brushes]::Gray }
    }

    function Set-Status {
        param([string]$Text, [string]$Color = "#3FB950")
        try {
            $Global:StatusText.Text = $Text
            $br = New-BrushFromHex $Color
            $Global:StatusText.Foreground = $br
            if ($Global:StatusDot) { $Global:StatusDot.Fill = $br }
        } catch {}
        Pump-UI
    }

    function Get-Checked {
        param([string]$Name)
        try {
            $el = $Global:Window.FindName($Name)
            if ($el -and $el.IsChecked) { return [bool]$el.IsChecked }
        } catch {}
        return $false
    }

    function Get-Text {
        param([string]$Name)
        try {
            $el = $Global:Window.FindName($Name)
            if ($el) { return [string]$el.Text }
        } catch {}
        return ""
    }

    function Invoke-CliCommand {
        param(
            [string]$File,
            [string[]]$CmdArgs = @(),
            [int]$TimeoutSec = 45
        )
        $result = @{ Ok = $false; Output = ""; Error = ""; ExitCode = -1 }
        try {
            $psi = New-Object System.Diagnostics.ProcessStartInfo
            $psi.FileName               = $File
            $psi.Arguments              = ($CmdArgs -join " ")
            $psi.UseShellExecute        = $false
            $psi.RedirectStandardOutput = $true
            $psi.RedirectStandardError  = $true
            $psi.CreateNoWindow         = $true

            $proc = [System.Diagnostics.Process]::Start($psi)
            $outTask = $proc.StandardOutput.ReadToEndAsync()
            $errTask = $proc.StandardError.ReadToEndAsync()

            $exited = $proc.WaitForExit($TimeoutSec * 1000)
            if (-not $exited) {
                try { $proc.Kill() } catch {}
                $result.Error = "Timed out after ${TimeoutSec}s"
                return $result
            }
            $result.Output   = $outTask.Result
            $result.Error    = $errTask.Result
            $result.ExitCode = $proc.ExitCode
            $result.Ok       = ($proc.ExitCode -eq 0)
            return $result
        } catch {
            $result.Error = $_.Exception.Message
            return $result
        }
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

    function Open-Website {
        try { Start-Process "https://neutraco.vercel.app/" } catch {}
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
                Pump-UI
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
                $drvPath = Join-Path $env:SystemRoot "System32\drivers"
                if (Test-Path $drvPath) {
                    $susp = Get-ChildItem $drvPath -Filter "*.sys" -ErrorAction SilentlyContinue |
                            Where-Object { $_.CreationTime -gt (Get-Date).AddDays(-14) -and $_.Length -lt 10KB }
                    if ($susp) {
                        foreach ($s in $susp) { Write-Log "Suspicious driver: $($s.Name)" "WARN" }
                    } else { Write-Log "No suspicious drivers found" "OK" }
                }
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

        if ($ShowIp) {
            Write-Log "IP Configuration:" "INFO"
            try {
                $cfgs = Get-NetIPConfiguration -ErrorAction SilentlyContinue
                if ($cfgs) {
                    foreach ($c in $cfgs) {
                        if ($c -and $c.IPv4Address) {
                            $ip = ""
                            try { $ip = ($c.IPv4Address | Select-Object -First 1).IPAddress } catch {}
                            $gw = ""
                            try { $gw = $c.IPv4DefaultGateway.NextHop } catch {}
                            if ($ip) { Write-Log "  $($c.InterfaceAlias) - $ip  GW: $gw" "INFO" }
                        }
                    }
                } else { Write-Log "  No IPv4 configuration found" "WARN" }
            } catch { Write-Log "IP info failed: $($_.Exception.Message)" "WARN" }
        }

        if ($ShowAdapters) {
            Write-Log "Network Adapters:" "INFO"
            try {
                $adps = Get-NetAdapter -ErrorAction SilentlyContinue
                if ($adps) {
                    foreach ($a in $adps) {
                        Write-Log "  $($a.Name) - $($a.Status) - $($a.LinkSpeed)" "INFO"
                    }
                } else { Write-Log "  No adapters found" "WARN" }
            } catch { Write-Log "Adapter list failed: $($_.Exception.Message)" "WARN" }
        }

        if ($PingTest) {
            Write-Log "Pinging 8.8.8.8..." "INFO"
            try {
                $pinger = New-Object System.Net.NetworkInformation.Ping
                $rtts   = @()
                foreach ($i in 1..4) {
                    try {
                        $reply = $pinger.Send("8.8.8.8", 2000)
                        if ($reply -and $reply.Status -eq 'Success') { $rtts += $reply.RoundtripTime }
                    } catch {}
                }
                if ($rtts.Count -gt 0) {
                    $avg = [math]::Round(($rtts | Measure-Object -Average).Average)
                    Write-Log "Ping OK - avg $avg ms ($($rtts.Count)/4 replies)" "OK"
                } else {
                    Write-Log "Ping failed - no replies (network down or ICMP blocked)" "ERR"
                }
            } catch { Write-Log "Ping test error: $($_.Exception.Message)" "WARN" }
        }

        if ($DnsTest) {
            Write-Log "DNS lookup google.com..." "INFO"
            try {
                $addrs = [System.Net.Dns]::GetHostAddresses("google.com")
                if ($addrs -and $addrs.Count -gt 0) {
                    Write-Log "DNS OK - $($addrs[0].IPAddressToString)" "OK"
                } else { Write-Log "DNS returned no results" "WARN" }
            } catch { Write-Log "DNS lookup failed: $($_.Exception.Message)" "ERR" }
        }

        if ($TraceRoute) {
            Write-Log "Traceroute to 8.8.8.8 (may take a minute)..." "INFO"
            try {
                $r = Invoke-CliCommand -File "tracert.exe" -CmdArgs @("-h","10","-w","500","8.8.8.8") -TimeoutSec 90
                if ($r.Output) {
                    $lines = $r.Output -split "`r?`n" | Select-Object -Skip 2 | Select-Object -First 12
                    foreach ($ln in $lines) { if ($ln.Trim()) { Write-Log "  $ln" "INFO" } }
                }
                Write-Log "Traceroute done" "OK"
            } catch { Write-Log "Traceroute failed: $($_.Exception.Message)" "WARN" }
        }

        if ($FlushDns) {
            $r = Invoke-CliCommand -File "ipconfig.exe" -CmdArgs @("/flushdns") -TimeoutSec 15
            if ($r.Ok) { Write-Log "DNS cache flushed" "OK" } else { Write-Log "Flush DNS: $($r.Error)" "WARN" }
            Pump-UI
        }

        if ($ReleaseIp) {
            Write-Log "Releasing IP (network will drop briefly)..." "WARN"
            $r = Invoke-CliCommand -File "ipconfig.exe" -CmdArgs @("/release") -TimeoutSec 30
            if ($r.Ok) { Write-Log "IP released" "OK" } else { Write-Log "IP release: $($r.Error)" "WARN" }
            Pump-UI
        }

        if ($RenewIp) {
            Write-Log "Renewing IP..." "INFO"
            $r = Invoke-CliCommand -File "ipconfig.exe" -CmdArgs @("/renew") -TimeoutSec 90
            if ($r.Ok) { Write-Log "IP renewed" "OK" } else { Write-Log "IP renew: $($r.Error)" "WARN" }
            Pump-UI
        }

        if ($Winsock) {
            $r = Invoke-CliCommand -File "netsh.exe" -CmdArgs @("winsock","reset") -TimeoutSec 30
            if ($r.Ok) { Write-Log "Winsock reset (reboot recommended)" "OK" }
            else { Write-Log "Winsock reset: $($r.Error)" "WARN" }
            Pump-UI
        }

        if ($Tcpip) {
            $r = Invoke-CliCommand -File "netsh.exe" -CmdArgs @("int","ip","reset") -TimeoutSec 30
            if ($r.Ok) { Write-Log "TCP/IP reset (reboot recommended)" "OK" }
            else { Write-Log "TCP/IP reset: $($r.Error)" "WARN" }
            Pump-UI
        }

        if ($Arp) {
            $r = Invoke-CliCommand -File "netsh.exe" -CmdArgs @("interface","ip","delete","arpcache") -TimeoutSec 15
            if ($r.Ok) { Write-Log "ARP cache cleared" "OK" } else { Write-Log "ARP clear: $($r.Error)" "WARN" }
            Pump-UI
        }

        if ($Netbios) {
            $r = Invoke-CliCommand -File "nbtstat.exe" -CmdArgs @("-R") -TimeoutSec 15
            if ($r.Ok) { Write-Log "NetBIOS cache cleared" "OK" } else { Write-Log "NetBIOS clear: $($r.Error)" "WARN" }
            Pump-UI
        }

        if ($Proxy) {
            $r = Invoke-CliCommand -File "netsh.exe" -CmdArgs @("winhttp","reset","proxy") -TimeoutSec 15
            if ($r.Ok) { Write-Log "WinHTTP proxy reset" "OK" } else { Write-Log "Proxy reset: $($r.Error)" "WARN" }
            Pump-UI
        }

        if ($FirewallR) {
            $r = Invoke-CliCommand -File "netsh.exe" -CmdArgs @("advfirewall","reset") -TimeoutSec 30
            if ($r.Ok) { Write-Log "Firewall reset to defaults" "OK" } else { Write-Log "Firewall reset: $($r.Error)" "WARN" }
            Pump-UI
        }

        if ($TcpOpt) {
            Write-Log "Applying TCP optimizations..." "INFO"
            try {
                Invoke-CliCommand -File "netsh.exe" -CmdArgs @("int","tcp","set","global","autotuninglevel=normal") -TimeoutSec 15 | Out-Null
                Invoke-CliCommand -File "netsh.exe" -CmdArgs @("int","tcp","set","global","rss=enabled") -TimeoutSec 15 | Out-Null
                $ifaces = Get-ChildItem "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" -ErrorAction SilentlyContinue
                foreach ($i in $ifaces) {
                    try {
                        Set-ItemProperty -Path $i.PSPath -Name "TcpAckFrequency" -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue
                        Set-ItemProperty -Path $i.PSPath -Name "TCPNoDelay"      -Value 1 -Type DWord -Force -ErrorAction SilentlyContinue
                    } catch {}
                }
                Write-Log "TCP optimizations applied" "OK"
            } catch { Write-Log "TCP tweak failed: $($_.Exception.Message)" "WARN" }
        }

        if ($Mtu) {
            Write-Log "Setting MTU to 1500..." "INFO"
            try {
                $adapters = Get-NetAdapter -ErrorAction SilentlyContinue | Where-Object { $_.Status -eq "Up" }
                if ($adapters) {
                    foreach ($a in $adapters) {
                        if ($a.Name) {
                            Invoke-CliCommand -File "netsh.exe" -CmdArgs @("interface","ipv4","set","subinterface","`"$($a.Name)`"","mtu=1500","store=persistent") -TimeoutSec 15 | Out-Null
                        }
                    }
                    Write-Log "MTU set to 1500" "OK"
                } else { Write-Log "No active adapters found" "WARN" }
            } catch { Write-Log "MTU set failed: $($_.Exception.Message)" "WARN" }
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
                $dup = Invoke-CliCommand -File "powercfg.exe" -CmdArgs @("-duplicatescheme",$guid) -TimeoutSec 15
                Start-Sleep -Milliseconds 300
                $dupGuid = $guid
                if ($dup.Output -match "([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})") {
                    $dupGuid = $matches[1]
                }
                Invoke-CliCommand -File "powercfg.exe" -CmdArgs @("-setactive",$dupGuid) -TimeoutSec 15 | Out-Null
                $act = Invoke-CliCommand -File "powercfg.exe" -CmdArgs @("-getactivescheme") -TimeoutSec 15
                if ($act.Output -match "Ultimate|e9a42b02") {
                    Write-Log "Ultimate Performance ACTIVATED" "OK"
                    $ok = $true
                }
            } catch {
                Write-Log "Ultimate Performance failed: $($_.Exception.Message)" "WARN"
            }

            if (-not $ok -and $HighPerf) {
                Write-Log "Falling back to High Performance..." "WARN"
                try {
                    Invoke-CliCommand -File "powercfg.exe" -CmdArgs @("-setactive","8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c") -TimeoutSec 15 | Out-Null
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
            $r = Invoke-CliCommand -File "powercfg.exe" -CmdArgs @("-h","off") -TimeoutSec 15
            if ($r.Ok) { Write-Log "Hibernation disabled" "OK" } else { Write-Log "Hibernation tweak failed" "WARN" }
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
    #  NAV HANDLERS
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
                -Apps      (Get-Checked "ChkApps")      `
                -Prov      (Get-Checked "ChkProv")      `
                -OneDrive  (Get-Checked "ChkOneDrive")  `
                -Teams     (Get-Checked "ChkTeams")     `
                -Telemetry (Get-Checked "ChkTelemetry") `
                -Copilot   (Get-Checked "ChkCopilot")   `
                -Widgets   (Get-Checked "ChkWidgets")   `
                -SearchWeb (Get-Checked "ChkSearchWeb") `
                -Ads       (Get-Checked "ChkAds")
        } catch { Write-Log "Debloat crashed: $($_.Exception.Message)" "ERR" }
    })

    $Global:Window.FindName("BtnVirus").Add_Click({
        try {
            Invoke-VirusScan `
                -Quick      (Get-Checked "ChkQuick")   `
                -Full       (Get-Checked "ChkFull")    `
                -Offline    (Get-Checked "ChkOffline") `
                -Custom     (Get-Checked "ChkCustom")  `
                -CustomPath (Get-Text "TxtScanPath")   `
                -Threats    (Get-Checked "ChkThreats") `
                -Rootkit    (Get-Checked "ChkRootkit") `
                -UpdateDef  (Get-Checked "ChkUpdateDef") `
                -Firewall   (Get-Checked "ChkFirewall") `
                -ASR        (Get-Checked "ChkASR")      `
                -CFA        (Get-Checked "ChkCFA")      `
                -NetProt    (Get-Checked "ChkNetProt")  `
                -SMB1       (Get-Checked "ChkSMB1")
        } catch { Write-Log "Virus scan crashed: $($_.Exception.Message)" "ERR" }
    })

    $Global:Window.FindName("BtnNetwork").Add_Click({
        try {
            Invoke-Network `
                -FlushDns     (Get-Checked "ChkFlushDns")     `
                -ReleaseIp    (Get-Checked "ChkReleaseIp")    `
                -RenewIp      (Get-Checked "ChkRenewIp")      `
                -Winsock      (Get-Checked "ChkWinsock")      `
                -Tcpip        (Get-Checked "ChkTcpip")        `
                -Arp          (Get-Checked "ChkArp")          `
                -Netbios      (Get-Checked "ChkNetbios")      `
                -Proxy        (Get-Checked "ChkProxy")        `
                -FirewallR    (Get-Checked "ChkFirewallR")    `
                -ShowIp       (Get-Checked "ChkShowIp")       `
                -ShowAdapters (Get-Checked "ChkShowAdapters") `
                -PingTest     (Get-Checked "ChkPingTest")     `
                -DnsTest      (Get-Checked "ChkDnsTest")      `
                -TraceRoute   (Get-Checked "ChkTraceRoute")   `
                -TcpOpt       (Get-Checked "ChkTcpOpt")       `
                -Mtu          (Get-Checked "ChkMtu")
        } catch { Write-Log "Network tools crashed: $($_.Exception.Message)" "ERR" }
    })

    $Global:Window.FindName("BtnOptimize").Add_Click({
        try {
            Invoke-Optimize `
                -Ultimate  (Get-Checked "ChkUltimate")  `
                -HighPerf  (Get-Checked "ChkHighPerf")  `
                -Hibernate (Get-Checked "ChkHibernate") `
                -Svcs      (Get-Checked "ChkSvcs")      `
                -Visual    (Get-Checked "ChkVisual")    `
                -GameBar   (Get-Checked "ChkGameBar")   `
                -Startup   (Get-Checked "ChkStartup")   `
                -Temp      (Get-Checked "ChkTemp")      `
                -Recycle   (Get-Checked "ChkRecycle")   `
                -Prefetch  (Get-Checked "ChkPrefetch")  `
                -ShutUp    (Get-Checked "ChkShutUp")    `
                -SecUpdate (Get-Checked "ChkSecUpdate")
        } catch { Write-Log "Optimize crashed: $($_.Exception.Message)" "ERR" }
    })

    $Global:Window.FindName("BtnDev").Add_Click({
        try {
            $picks = @{
                "Python.Python.3.12"                      = (Get-Checked "ChkPython")
                "OpenJS.NodeJS.LTS"                       = (Get-Checked "ChkNode")
                "EclipseAdoptium.Temurin.21.JDK"          = (Get-Checked "ChkJava")
                "GoLang.Go"                               = (Get-Checked "ChkGo")
                "Rustlang.Rustup"                         = (Get-Checked "ChkRust")
                "PHP.PHP"                                 = (Get-Checked "ChkPhp")
                "RubyInstallerTeam.Ruby"                  = (Get-Checked "ChkRuby")
                "Microsoft.DotNet.SDK.8"                  = (Get-Checked "ChkDotNet")
                "Microsoft.VisualStudioCode"              = (Get-Checked "ChkVsCode")
                "Microsoft.PowerShell"                    = (Get-Checked "ChkPwsh7")
                "Git.Git"                                 = (Get-Checked "ChkGit")
                "Microsoft.WindowsTerminal"               = (Get-Checked "ChkWinTerm")
                "Neovim.Neovim"                           = (Get-Checked "ChkNeovim")
                "Kitware.CMake"                           = (Get-Checked "ChkCmake")
                "LLVM.LLVM"                               = (Get-Checked "ChkLLVM")
                "Microsoft.VisualStudio.2022.BuildTools"  = (Get-Checked "ChkVSBT")
                "Docker.DockerDesktop"                    = (Get-Checked "ChkDocker")
                "Postman.Postman"                         = (Get-Checked "ChkPostman")
                "dbeaver.dbeaver"                         = (Get-Checked "ChkDBeaver")
            }
            Invoke-DevTools -Picks $picks
        } catch { Write-Log "Dev install crashed: $($_.Exception.Message)" "ERR" }
    })

    $Global:Window.FindName("BtnSysInfo").Add_Click({
        try {
            Write-Log "System information" "HEAD"
            $os  = Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue
            $cs  = Get-CimInstance Win32_ComputerSystem -ErrorAction SilentlyContinue
            $cpu = Get-CimInstance Win32_Processor -ErrorAction SilentlyContinue | Select-Object -First 1
            if ($os) {
                Write-Log "OS: $($os.Caption) build $($os.BuildNumber)" "INFO"
                try {
                    $up = (Get-Date) - $os.LastBootUpTime
                    Write-Log "Uptime: $($up.Days)d $($up.Hours)h $($up.Minutes)m" "INFO"
                } catch {}
            }
            if ($cpu) { Write-Log "CPU: $($cpu.Name)" "INFO" }
            if ($cs) {
                Write-Log "RAM: $([math]::Round($cs.TotalPhysicalMemory/1GB,1)) GB" "INFO"
                Write-Log "Host: $($cs.Name)" "INFO"
            }
        } catch { Write-Log "System info failed: $($_.Exception.Message)" "WARN" }
    })

    # =================================================================
    #  WEBSITE LINKS
    # =================================================================
    try {
        $sidebarLink = $Global:Window.FindName("SidebarSiteLink")
        if ($sidebarLink) {
            $sidebarLink.Add_MouseLeftButtonUp({ Open-Website })
            $sidebarLink.Add_MouseEnter({ try { $sidebarLink.TextDecorations = [Windows.TextDecorations]::Underline } catch {} })
            $sidebarLink.Add_MouseLeave({ try { $sidebarLink.TextDecorations = $null } catch {} })
            $sidebarLink.ToolTip = "Open https://neutraco.vercel.app/ in your browser"
        }
    } catch {}

    try {
        $hyper = $Global:Window.FindName("AboutSiteHyperlink")
        if ($hyper) {
            $hyper.Add_Click({ Open-Website })
        }
    } catch {}

    # =================================================================
    #  THEME COMBO
    # =================================================================
    $cmb = $Global:Window.FindName("CmbTheme")
    foreach ($name in $Global:Themes.Keys) { [void]$cmb.Items.Add($name) }
    $cmb.Add_SelectionChanged({
        try {
            $sel = $Global:Window.FindName("CmbTheme").SelectedItem
            if ($sel) { Set-Theme $sel }
        } catch { Write-Log "Theme change error: $($_.Exception.Message)" "ERR" }
    })

    # =================================================================
    #  GO
    # =================================================================
    Write-Log "NeutraTool v2.4 loaded - Simple. Useful. Done." "HEAD"
    Write-Log "by littlleprince - Discord: littlleprince - neutracocontact@gmail.com" "INFO"
    Write-Log "Website: https://neutraco.vercel.app/" "INFO"
    Write-Log "Hover any checkbox or button for a description of what it does." "INFO"

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