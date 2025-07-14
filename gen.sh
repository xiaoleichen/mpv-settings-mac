#!/bin/bash

function replace_options() {
  local file=$1
  local options_name=$2[@]
  local options=("${!options_name}")
  for option in "${options[@]}"; do
    local old=`echo $option | cut -d ":" -f 1`
    local new=`echo $option | cut -d ":" -f 2`
    if grep -q "$old" "$file"; then
      sed -i -e "s@$old@$new@g" "$file"
      echo "✓" $old "===>" $new
    else
      echo "✘" $old not found
    fi
  done
}

rm -rf mpv mpv_win mpv_linux

# Use stock OSC
if [[ "$1" == "--stock" ]]; then

  echo "  Gen with stock OSC"
  mkdir -p ./mpv/scripts

  echo
  echo '  Downloading files...'
  curl -L -s https://raw.githubusercontent.com/xiaoleichen/mpv-settings-mac/refs/heads/main/mpv.conf -o ./mpv/mpv.conf
  curl -L -s https://raw.githubusercontent.com/xiaoleichen/mpv-settings-mac/refs/heads/main/input.conf -o ./mpv/input.conf
  curl -L -s https://raw.githubusercontent.com/AssrtOSS/mpv-assrt/refs/heads/master/scripts/assrt.lua -o ./mpv/scripts/assrt.lua

  options=(
    "sub-margin-y=34:sub-margin-y=55"
    "osd-font='DejaVu Sans':osd-font='sans-serif'"
  )

  replace_options "./mpv/mpv.conf" options

  echo
  echo '  Making Windows copy...'
  cp -r ./mpv/ ./mpv_win/

  disable_mac_dark_title_bar_options=(
    'macos-title-bar-appearance=darkAqua:# macos-title-bar-appearance=darkAqua'
  )
  win_options=(
    "sub-font='PingFang SC':sub-font='Microsoft Yahei'"
  )

  replace_options "./mpv_win/mpv.conf" disable_mac_dark_title_bar_options
  replace_options "./mpv_win/mpv.conf" win_options
  # Additional script for Windows
  curl -L -s https://raw.githubusercontent.com/zenyd/mpv-scripts/refs/heads/master/copy-paste-URL.lua -o ./mpv_win/scripts/paste_url.lua

  echo
  echo '  Making Linux copy...'
  cp -r ./mpv/ ./mpv_linux/

  linux_options=(
    "osd-font='sans-serif':osd-font='Adwaita Sans'"
    "sub-font='PingFang SC':sub-font='Adwaita Sans'"
  )

  replace_options "./mpv_linux/mpv.conf" disable_mac_dark_title_bar_options
  replace_options "./mpv_linux/mpv.conf" linux_options
  echo gpu-context=x11egl >> ./mpv_linux/mpv.conf

  echo
  echo '  Done'

  exit 0
fi

# Use ModernZ OSC

echo "  Gen with ModernZ OSC"
mkdir -p ./mpv/scripts ./mpv/script-opts ./mpv/fonts

echo
echo '  Downloading files...'
curl -L -s https://raw.githubusercontent.com/xiaoleichen/mpv-settings-mac/refs/heads/main/mpv.conf -o ./mpv/mpv.conf
curl -L -s https://raw.githubusercontent.com/xiaoleichen/mpv-settings-mac/refs/heads/main/input.conf -o ./mpv/input.conf
curl -L -s https://raw.githubusercontent.com/AssrtOSS/mpv-assrt/refs/heads/master/scripts/assrt.lua -o ./mpv/scripts/assrt.lua
curl -L -s https://raw.githubusercontent.com/po5/thumbfast/refs/heads/master/thumbfast.lua -o ./mpv/scripts/thumbfast.lua
curl -L -s https://raw.githubusercontent.com/po5/thumbfast/refs/heads/master/thumbfast.conf -o ./mpv/script-opts/thumbfast.conf
curl -L -s https://raw.githubusercontent.com/Samillion/ModernZ/refs/heads/main/modernz.lua -o ./mpv/scripts/modernz.lua
curl -L -s https://raw.githubusercontent.com/Samillion/ModernZ/refs/heads/main/modernz.conf -o ./mpv/script-opts/modernz.conf
curl -L -s https://raw.githubusercontent.com/Samillion/ModernZ/refs/heads/main/extras/locale/modernz-locale.json -o ./mpv/script-opts/modernz-locale.json
curl -L -s https://github.com/xiaoleichen/mpv-settings-mac/raw/refs/heads/main/fonts/PingFang-SC-Regular.ttf -o ./mpv/fonts/PingFang-SC-Regular.ttf
curl -L -s https://github.com/xiaoleichen/mpv-settings-mac/raw/refs/heads/main/fonts/DejaVuSans.ttf -o ./mpv/fonts/DejaVuSans.ttf
curl -L -s https://github.com/Samillion/ModernZ/raw/refs/heads/main/fluent-system-icons.ttf -o ./mpv/fonts/fluent-system-icons.ttf
curl -L -s https://github.com/Samillion/ModernZ/raw/refs/heads/main/material-design-icons.ttf -o ./mpv/fonts/material-design-icons.ttf

echo
echo '  Replacing options...'
options=(
  'bottomhover=yes:bottomhover=no'
  'vidscale=auto:vidscale=no'
  'cache_info=no:cache_info=yes'
  'cache_info_speed=no:cache_info_speed=yes'
  'cache_info_font_size=12:cache_info_font_size=14'
  'window_controls=yes:window_controls=no'
  'chapter_skip_buttons=no:chapter_skip_buttons=yes'
  'nibbles_style=triangle:nibbles_style=single-bar'
  'hover_effect_color=#FB8C00:hover_effect_color=#FFFFFF'
  'scalewindowed=1.0:scalewindowed=2.0'
  'scalefullscreen=1.0:scalefullscreen=2.0'
)

replace_options "./mpv/script-opts/modernz.conf" options
echo
echo '  Making Windows copy...'
cp -r ./mpv/ ./mpv_win/

win_options=(
  'scalewindowed=2.0:scalewindowed=1.5'
  'scalefullscreen=2.0:scalefullscreen=1.5'
)
disable_mac_dark_title_bar_options=(
  'macos-title-bar-appearance=darkAqua:# macos-title-bar-appearance=darkAqua'
)
replace_options "./mpv_win/script-opts/modernz.conf" win_options
replace_options "./mpv_win/mpv.conf" disable_mac_dark_title_bar_options
# Additional script for Windows
curl -L -s https://raw.githubusercontent.com/zenyd/mpv-scripts/refs/heads/master/copy-paste-URL.lua -o ./mpv_win/scripts/paste_url.lua

echo
echo '  Making Linux copy...'
cp -r ./mpv/ ./mpv_linux/

linux_options=(
  'scalewindowed=2.0:scalewindowed=1.0'
  'scalefullscreen=2.0:scalefullscreen=1.0'
)
replace_options "./mpv_linux/script-opts/modernz.conf" linux_options
replace_options "./mpv_linux/mpv.conf" disable_mac_dark_title_bar_options
echo gpu-context=x11egl >> ./mpv_linux/mpv.conf

echo
echo '  Done'

exit 0
#### Commands for clients ####

# Windows
rm -Path "$env:USERPROFILE\AppData\Roaming\mpv\" -Force -Recurse; cp "\\gmk\git\mpv-settings-mac\mpv_win\" "$env:USERPROFILE\AppData\Roaming\mpv" -Recurse
# Linux
rm -rf ~/.config/mpv && mkdir ~/.config/mpv && cd ~/.config/mpv && smbget --recursive smb://gmk.local/git/mpv-settings-mac/mpv_linux
# MacOS
rm -rf ~/.config/mpv && cp -r /Volumes/git/mpv-settings-mac/mpv ~/.config/mpv