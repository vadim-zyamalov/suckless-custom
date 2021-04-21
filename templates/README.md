# Script for automatic package building

`process.sh` script can be used for automatic building of xbps packages using `xbps-src`.

Usage: `./process.sh -s <sources path> -t <templates path> -p <void-packages path> pkg[,[version][,[revision]]] ...`. Records are separated by whitespaces, fields are separated by commas.

The scipt works as follows:

1. Each record in the input is splitted by commas into three parts: package name, desired version and revision.
2. If there is a folder with the desired package name then we proceed further.
3. If version and/or revision number are not missing we substitute these into the template file. If any of these numbers are missing we don't touch it. E.g., `pkg,,1` means that we substitute only revivson number leaving the existing version number.
4. If there are `config.h` and/or `patch.diff` files in the `files/` folder the we substitute them with the latest corresponding files from `../sources/<pkg>` folders.
5. Then we replace the exiting template folder in `void-packages/srcpkgs/` folder with modified one.
6. Call `xbps-src`.

