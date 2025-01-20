#!/bin/bash

rm -rf mpv mpv_win mpv_linux
mkdir -p ./mpv/scripts ./mpv/script-opts ./mpv/fonts

echo '  Downloading files...'
curl -L -s https://raw.githubusercontent.com/xiaoleichen/mpv-settings-mac/refs/heads/main/mpv.conf -o ./mpv/mpv.conf
curl -L -s https://raw.githubusercontent.com/xiaoleichen/mpv-settings-mac/refs/heads/main/input.conf -o ./mpv/input.conf
curl -L -s https://raw.githubusercontent.com/AssrtOSS/mpv-assrt/refs/heads/master/scripts/assrt.lua -o ./mpv/scripts/assrt.lua
curl -L -s https://raw.githubusercontent.com/po5/thumbfast/refs/heads/master/thumbfast.lua -o ./mpv/scripts/thumbfast.lua
curl -L -s https://raw.githubusercontent.com/po5/thumbfast/refs/heads/master/thumbfast.conf -o ./mpv/script-opts/thumbfast.conf
curl -L -s https://raw.githubusercontent.com/Samillion/ModernZ/refs/heads/main/modernz.lua -o ./mpv/scripts/modernz.lua
curl -L -s https://raw.githubusercontent.com/Samillion/ModernZ/refs/heads/main/modernz.conf -o ./mpv/script-opts/modernz.conf
curl -L -s https://github.com/xiaoleichen/mpv-settings-mac/raw/refs/heads/main/fonts/PingFang-SC-Regular.ttf -o ./mpv/fonts/PingFang-SC-Regular.ttf
curl -L -s https://github.com/xiaoleichen/mpv-settings-mac/raw/refs/heads/main/fonts/DejaVuSans.ttf -o ./mpv/fonts/DejaVuSans.ttf
curl -L -s https://github.com/xiaoleichen/ModernZ/raw/refs/heads/main/fluent-system-icons.ttf -o ./mpv/fonts/fluent-system-icons.ttf

function replace_options() {
  local file=$1
  local options_name=$2[@]
  local options=("${!options_name}")
  for option in "${options[@]}"; do
  	local old=`echo $option | cut -d ":" -f 1`
  	local new=`echo $option | cut -d ":" -f 2`
    if grep -q "$old" "$file"; then
    	sed -i -e "s@$old@$new@g" "$file"
      echo $old "===>" $new
    else
    	echo $old not found
    fi
  done
}
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

# Disable interactive menu on Linux. It's still buggy for v0.39.0
additional_linux_options=(
  'playlist_mbtn_left_command=script-binding select/select-playlist; script-message-to modernz osc-hide:playlist_mbtn_left_command=show-text ${playlist} 3000'
  'vol_ctrl_mbtn_right_command=script-binding select/select-audio-device; script-message-to modernz osc-hide:vol_ctrl_mbtn_right_command=no-osd cycle mute'
  'audio_track_mbtn_left_command=script-binding select/select-aid; script-message-to modernz osc-hide:audio_track_mbtn_left_command=cycle audio'
  'audio_track_mbtn_mid_command=cycle audio down:audio_track_mbtn_mid_command=ignore'
  'audio_track_mbtn_right_command=cycle audio:audio_track_mbtn_right_command=cycle audio down'
  'sub_track_mbtn_left_command=script-binding select/select-sid; script-message-to modernz osc-hide:sub_track_mbtn_left_command=cycle sub'
  'sub_track_mbtn_mid_command=cycle sub down:sub_track_mbtn_mid_command=ignore'
  'sub_track_mbtn_right_command=cycle sub:sub_track_mbtn_right_command=cycle sub down'
  'chapter_prev_mbtn_right_command=script-binding select/select-chapter; script-message-to modernz osc-hide:chapter_prev_mbtn_right_command=show-text ${chapter-list} 3000'
  'chapter_next_mbtn_right_command=script-binding select/select-chapter; script-message-to modernz osc-hide:chapter_next_mbtn_right_command=show-text ${chapter-list} 3000'
  'chapter_title_mbtn_left_command=script-binding select/select-chapter; script-message-to modernz osc-hide:chapter_title_mbtn_left_command=show-text ${chapter-list} 3000'
  'playlist_prev_mbtn_right_command=script-binding select/select-playlist; script-message-to modernz osc-hide:playlist_prev_mbtn_right_command=show-text ${playlist} 3000'
  'playlist_next_mbtn_right_command=script-binding select/select-playlist; script-message-to modernz osc-hide:playlist_next_mbtn_right_command=show-text ${playlist} 3000'
)
replace_options "./mpv_linux/script-opts/modernz.conf" additional_linux_options

lua_linux_updates=(
  'stats/display-page-1-toggle:stats/display-stats-toggle'
)
replace_options "./mpv_linux/scripts/modernz.lua" lua_linux_updates
echo
echo '  Done'
