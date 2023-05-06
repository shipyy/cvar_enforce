# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.1.0]

### Added

- new CONVAR to use custom maxvels in case only certain maps need to be changed, but the rest just need to use the "default" values database ( I THINK THIS MAKES IT MORE LOGICAL, THIS CONVAR BASICALLY CHECKS IF MAXVEL_MAPS.TXT HAS A VALUE FOR THE MAP AND )
- added "on/off" CONVARS to indicate if plugin should be changing or not value of the CONVARS:
    `use_airaccelerate`
    `use_accelerate`
    `use_maxvel`
    `use_custom_maxvel`

## [2.0.2]

### Changed

- relocated `maxvel_maps.txt`.

## [2.0.1]

### Fixed

- reading lines from `maxvel_maps.txt`.

### Changed

- updated `readme` with install instructions.

## [2.0.0]

### Added

- workflow for auto release.

### Changed

- Change plugin name (`ez_config` -> `Cvar Enforce`).

***Full Changelog***: https://github.com/shipyy/Map-Challenge/compare/v1.2.0...v2.0.0