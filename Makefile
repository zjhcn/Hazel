
launch:
	.\bin\Debug-windows-x86_64\Sandbox\Sandbox.exe

build-launch: build bin\Debug-windows-x86_64\Sandbox\Sandbox.exe
	.\bin\Debug-windows-x86_64\Sandbox\Sandbox.exe

build: build-hazel build-sandbox

build-hazel:
	devenv Hazel.sln /Build 'Debug' /Project '.\Hazel\Hazel.vcxproj' /Projectconfig 'Debug'

build-sandbox:
	devenv Hazel.sln /Build 'Debug' /Project 'Sandbox\Sandbox.vcxproj' /Projectconfig 'Debug'

configure:
	./vendor/bin/premake/premake5.exe vs2022

.PHONY : clean
clean:
	rm -Recurse -Force .\bin
	rm -Recurse -Force .\bin-int