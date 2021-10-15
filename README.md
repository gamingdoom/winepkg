# Winepkg
A package manager for linux that installs windows apps through wine.

# Usage
```
winepkg -Si mspaint
```
# Install
Dependencies: ``wine`` ``winetricks``

Download the executable binary from releases and optionally move it to somewhere in path (ex. /usr/bin)

# Building from source
Dependencies: ``wine`` ``winetricks`` ``gcc``

```
git clone https://github.com/gamingdoom/winepkg.git
cd winepkg
gcc winepkg.c -o winepkg
```
From here you can use winepkg with
```
./winepkg
```
If you want a winepkg command, copy the binary to /usr/bin
```
# cp winepkg /usr/bin/winepkg
```
