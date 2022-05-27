# Winepkg
[![build](https://github.com/gamingdoom/winepkg/actions/workflows/build.yml/badge.svg)](https://github.com/gamingdoom/winepkg/actions/workflows/build.yml)


A package manager for linux that installs windows apps through wine.

# Usage
```
winepkg -Si mspaint
```
# Install
Dependencies: ``wine`` ``winetricks`` ``wget`` ``curl``

Download the executable binary artifact from github actions "build" and optionally move it to somewhere in path (ex. /usr/bin)

# Building from source
Dependencies: ``wine`` ``winetricks`` ``wget`` ``curl`` ``gcc``

```
git clone https://github.com/gamingdoom/winepkg.git
cd winepkg
make
```
From here you can use winepkg with
```
build/winepkg -Si mspaint
```
If you want a winepkg command, copy the binary to /usr/bin
```
sudo cp build/winepkg /usr/bin/winepkg
```
