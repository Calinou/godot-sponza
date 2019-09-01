# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- The welcome GUI and HUD elements now scale to match higher resolutions.
- New project icon.

### Changed

- Materials now use the Burley lighting model instead of Lambert.
- Materials are now more rough and less metallic.
- Increased the OmniLights' shadow bias to make shadow acne less visible.
- The FPS counter now uses a better-looking outline provided by DynamicFont.
- The frame time graph now features per-microsecond accuracy and can
  display changes in a more granular fashion.
- Upgraded project structure for Godot 3.1.

### Fixed

- Updated particle materials for Godot 3.2.
- Transparent materials are now displayed correctly.
- The frame time graph no longer blocks mouse input when visible.

## 1.0.0 - 2018-03-04

- Initial versioned release.

[Unreleased]: https://github.com/Calinou/godot-sponza/compare/v1.0.0...HEAD
