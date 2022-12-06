
run:
	.\bin\Debug-windows-x86_64\Sandbox\Sandbox.exe

build-run: build-hazel build-sandbox
	.\bin\Debug-windows-x86_64\Sandbox\Sandbox.exe

build-hazel:
	devenv.exe Hazel.sln /project "Hazel\Hazel.vcxproj" /build Debug /projectconfig Debug

build-sandbox:
	devenv.exe Hazel.sln /project "Sandbox\Sandbox.vcxproj" /build Debug /projectconfig Debug

.PHONY : clean
clean:
	rm -rf ./bin
	rm -rf ./bin-int