
launch:
	.\bin\Debug-windows-x86_64\Sandbox\Sandbox.exe

build-launch: build
	.\bin\Debug-windows-x86_64\Sandbox\Sandbox.exe

build: build-hazel build-sandbox

build-hazel:
	devenv.exe Hazel.sln /Build "Debug|x64" /Project "Hazel\Hazel.vcxproj" /Projectconfig "Debug|x64"

build-sandbox:
	devenv.exe Hazel.sln /build "Debug|x64" /project "Sandbox\Sandbox.vcxproj" /projectconfig "Debug|x64"

configure:
	./vendor/bin/premake/premake5.exe vs2017

.PHONY : clean
clean:
	rm -rf ./bin
	rm -rf ./bin-int