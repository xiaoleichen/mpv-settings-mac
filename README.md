# Intro

* Key bindings: https://github.com/xiaoleichen/mpv-settings-mac/blob/main/input.conf
* MPV border enabled and window controlls disabled
* Always show dark title bar
  * `macos-title-bar-appearance=darkAqua`

# OSC 

```
modernx.lua
```

![img](https://raw.githubusercontent.com/xiaoleichen/mpv-settings-mac/main/preview.png)

Forked from https://github.com/cyl0/ModernX

## Changes

* Use chars for button icons for pre-built MPV app.
* Always hide media title.
* Always hide window controls.
* Smaller OSC background.
* More responsive to mouse move (`minmousemove = 0`).
* Move down seekbar to align with time code.
* Show chapter list when skipping back/forward to previous/next chapter.
* Move subtitle (ass not supported) when controller appears and disappears.
* Add options to customize time code and tooltip font sizes.
* Add options to customize seek bar style (color, height, and alpha)

## Usage

### Seekbar
* Left mouse button: seek to chosen position.
* Right mouse button: seek to the head of chosen chapter
### Skip back/forward buttons
* Left mouse button: go to previous/next chapter.
* Right mouse button: show chapter list.
### Playlist back/forwad buttons
* Left mouse button: play previous/next file.
* Right mouse button: show playlist.
### Cycle audio/subtitle buttons
* Left mouse button/Right mouse button: cycle to next/previous track.
* Middle mouse button: show track list.
### Playback time
* Left mouse button: display time in milliseconds
### Duration
* Left mouse button: display total time instead of remaining time

# Other Scrpts

* `assrt.lua`: Dowload subtitles from assrt.net. Pulled from [mpv-assrt](https://github.com/AssrtOSS/mpv-assrt/).

* `paste_url.lua`: Copy and paste links into mpv with ctrl + v to start playback of a video. Works in windows only and requires PowerShell. Pulled from [mpv-scripts](https://github.com/zenyd/mpv-scripts).

* Alternative OSC [ModernZ](https://github.com/xiaoleichen/ModernZ). Works with MPV 0.39+ and suppports [thumbfast](https://github.com/po5/thumbfast).