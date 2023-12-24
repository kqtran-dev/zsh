prompt
======

Initializes Zsh prompt themes.

Images of various themes can be found on the [wiki](https://github.com/zimfw/zimfw/wiki/Themes).

A list of available themes can be found by running `prompt -l`.

To get help for a given theme, run `prompt -h <theme_name>`.

To immediately switch the theme, simply run `prompt <theme_name>`.

Settings
--------

Set your default theme with the following zstyle. Additional theme-specific parameters can be defined too:

    zstyle ':zim:prompt' theme 'elite' 'cyan' 'blue'
