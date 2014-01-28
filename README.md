UnusedStrings
=============

Helps Cocoa applications localization by detecting unused keys in '.strings' files.

What it can?
=============
1. It detects unused keys in .strings files in whole directory you pass as argument (it searches recursively).
2. It can removes unused keys (optional).

How-To
=============
1) Add rights to execute this script.

chmod +X unusedstrings.sh

2) To find unused strings execute script with -s argument.

./unusedstrings.sh -s pathToDirectory

3) To find and remove unused strings execute script with -r 1 argument.

./unusedstrings.sh -s pathToDirectory -r 1


Options
============
-s source directory, where start to search
-r 1 means that unused strings will be removed after search.
