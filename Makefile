# This Makefile assists in exporting and packaging the project for
# various platforms.
# Godot must be available in the PATH for this Makefile to function correctly.
# The project's assets must also have been imported first by opening
# the project using the editor for exporting to be possible.

MAKEFLAGS += --silent
all: dist-linux dist-macos dist-windows
PHONY: all

name = godot-sponza
version = 2.0.0

# Export and package for Linux
dist-linux:
	mkdir -p "dist/linux/$(name)/"
	godot --export "Linux" "dist/linux/$(name)/$(name).x86_64"

	# Create Linux .tar.xz archive
	cd "dist/linux/" && \
	tar cfJ "../$(name)-$(version)-linux-x86_64.tar.xz" "$(name)/"

	# Clean up temporary files
	rm -rf "dist/linux/"

# Export and package for macOS
dist-macos:
	godot --export "macOS" "dist/$(name)-$(version)-macos.zip"

# Export and package for Windows
dist-windows:
	mkdir -p "dist/windows/$(name)/"
	godot --export "Windows" "dist/windows/$(name)/$(name).exe"

	# Create Windows ZIP archive
	cd "dist/windows/" && \
	zip -r9 "../$(name)-$(version)-windows-x86_64.zip" "$(name)/"

	# Clean up temporary files
	rm -rf "dist/windows/"

# Clean up build artifacts
clean:
	rm -rf "dist/"
