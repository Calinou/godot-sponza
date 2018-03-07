# This Makefile assists in exporting and packaging the project for
# various platforms.
# Godot and linuxdeployqt must be available in the PATH for this Makefile
# to function correctly.
# The project's assets must also have been imported first by opening
# the project using the editor for exporting to be possible.

MAKEFLAGS += --silent
PHONY: dist

name = godot-sponza
version = 1.0.0

# Export and package for Linux, macOS and Windows
dist: clean
	mkdir -p "dist/linux/usr/bin" "dist/windows/$(name)/"

	godot --export "Linux" "dist/linux/usr/bin/$(name)"
	godot --export "macOS" "dist/$(name)-$(version)-macos.zip"
	godot --export "Windows" "dist/windows/$(name)/$(name).exe"

	# Create Linux AppImage
	cp "misc/dist/linux/$(name).desktop" "dist/linux/$(name).desktop"
	cp "icon.png" "dist/linux/$(name).png"
	linuxdeployqt "dist/linux/$(name).desktop" -appimage
	mv *.AppImage "dist/$(name)-$(version)-linux-x86_64.AppImage"

	# Create Windows ZIP archive
	cd "dist/windows/" && \
	zip -r9 "../$(name)-$(version)-windows-x86_64.zip" "$(name)/"

	# Clean up temporary files
	rm -rf "dist/linux/" "dist/windows/"

# Clean up build artifacts
clean:
	rm -rf "dist/"
