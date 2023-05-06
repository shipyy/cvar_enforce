# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.1.1]

### Fixed

- added missing check for  maxvelocity in hookvar for maxvelocity
- values now are set in the correct method `onmapstart()`
- setconvar for custom maxvelocity now works as intended

Full Changelog: https://github.com/shipyy/cvar_enforce/compare/v2.1.0...v2.1.1

## [2.1.0]

### Added

- new CONVAR to use custom maxvels in case only certain maps need to be changed, but the rest just need to use the "default" values database ( I THINK THIS MAKES IT MORE LOGICAL, THIS CONVAR BASICALLY CHECKS IF MAXVEL_MAPS.TXT HAS A VALUE FOR THE MAP AND )
- added "on/off" CONVARS to indicate if plugin should be changing or not value of the CONVARS:
    `use_airaccelerate`
    `use_accelerate`
    `use_maxvel`
    `use_custom_maxvel`

Full Changelog: https://github.com/shipyy/cvar_enforce/compare/v2.0.2...v2.1.0

## [2.0.2]

### Changed

- relocated `maxvel_maps.txt`.

Full Changelog: https://github.com/shipyy/cvar_enforce/compare/v2.0.1...v2.0.2

## [2.0.1]

### Fixed

- reading lines from `maxvel_maps.txt`.

### Changed

- updated `readme` with install instructions.

Full Changelog: https://github.com/shipyy/cvar_enforce/compare/v2.0.0...v2.0.1

## [2.0.0]

### Added

- workflow for auto release.

### Changed

- Change plugin name (`ez_config` -> `Cvar Enforce`).

***Full Changelog***: https://github.com/shipyy/cvar_enforce/compare/v1.2.0...v2.0.0
