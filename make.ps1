param(
    [Parameter()]
    [switch] $Clean = $false,
    [switch] $Configure = $false,
    [switch] $Launch = $false,
    [switch] $Build = $false,
    [switch] $Hazel = $false,
    [switch] $Sandbox = $false,
    [switch] $Glad = $false,
    [switch] $GLFW = $false,
    [switch] $ImGui = $false
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

function Glad {
    Run "devenv" "Hazel.sln", "/Build", 'Debug', "/Project", "$PWD\Hazel\vendor\Glad\Glad.vcxproj", "/Projectconfig", "Debug"
}
function GLFW {
    Run "devenv" "Hazel.sln", "/Build", 'Debug', "/Project", "$PWD\Hazel\vendor\GLFW\GLFW.vcxproj", "/Projectconfig", "Debug"
}
function ImGui {
    Run "devenv" "Hazel.sln", "/Build", 'Debug', "/Project", "$PWD\Hazel\vendor\imgui\ImGui.vcxproj", "/Projectconfig", "Debug"
}
function Hazel {
    Run "devenv" "Hazel.sln", "/Build", 'Debug', "/Project", "$PWD\Hazel\Hazel.vcxproj", "/Projectconfig", "Debug"
}

function Sandbox {
    Run "devenv" "Hazel.sln", "/Build", 'Debug', "/Project", "$PWD\Sandbox\Sandbox.vcxproj", "/Projectconfig", "Debug"
}

if ($Clean.IsPresent) {
    Clean
}

if ($Configure.IsPresent) {
    Configure
}

if ($Build.IsPresent) {
    Glad
    GLFW
    ImGui
    Hazel
    Sandbox
} else {
    if ($Glad.IsPresent) {
        Glad
    }
    if ($GLFW.IsPresent) {
        GLFW
    }
    if ($ImGui.IsPresent) {
        ImGui
    }
    if ($Hazel.IsPresent) {
        Hazel
    }
    if ($Sandbox.IsPresent) {
        Sandbox
    }
}

if ($Launch.IsPresent) {
    Launch
}
