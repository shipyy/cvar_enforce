# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0]

### Added

- workflow for auto release.

### Changed

- Change plugin name (`ez_config` -> `Cvar Enforce`).

### Fixed

- Points distribuition would sometimes not give correct value (i.e : would give `49` instead of `50` points because of some `float` to `int` conversions).

***Full Changelog***: https://github.com/shipyy/Map-Challenge/compare/v1.2.0...v2.0.0