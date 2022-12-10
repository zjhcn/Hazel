param(
    [Parameter()]
    [switch] $Clean = $false,
    [switch] $Configure = $false,
    [switch] $Launch = $false,
    [switch] $Build = $false,
    [switch] $Hazel = $false,
    [switch] $Sandbox = $false
)

function Run {
    param (
        [Parameter()]
        [string] $Cmd,
        [string[]] $ArgumentList
    )
    
    $output = $Cmd 
    $output += " "
    $output += $ArgumentList 
    Write-Output $output
    Start-Process $Cmd -Wait -ArgumentList $ArgumentList -NoNewWindow
}

function Launch {
    Run "$PWD\bin\Debug-windows-x86_64\Sandbox\Sandbox.exe"
}

function Configure {
    Run "$PWD\vendor\bin\premake\premake5" 'vs2022'
}

function Clean {
    Remove-Item -Recurse -Force .\bin
    Remove-Item -Recurse -Force .\bin-int
}

function Hazel {
    $TRUE_FALSE = (Test-Path  "$PWD\bin\Debug-windows-x86_64\Sandbox")
    if ($TRUE_FALSE -eq $false) {
        mkdir "$PWD\bin\Debug-windows-x86_64\Sandbox"
    }
    Run "devenv" "Hazel.sln", "/Build", 'Debug', "/Project", "$PWD\Hazel\Hazel.vcxproj", "/Projectconfig", "Debug"
}

function Sandbox {
    Run "devenv" "Hazel.sln", "/Build", 'Debug', "/Project", "$PWD\Sandbox\Sandbox.vcxproj", "/Projectconfig", "Debug"
}

if ($Configure.IsPresent) {
    Configure
}

if ($Clean.IsPresent) {
    Clean
}

if ($Launch.IsPresent) {
    
    if ($Build.IsPresent) {
        Hazel
        Sandbox
    }

    if ($Hazel.IsPresent) {
        Hazel
    }
    if ($Sandbox.IsPresent) {
        Hazel
    }

    Launch
}

if ($Build.IsPresent) {
    Hazel
    Sandbox
}

if ($Hazel.IsPresent) {
    Hazel
}

if ($Sandbox.IsPresent) {
    Sandbox
}
