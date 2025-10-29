
#!/bin/bash

# 获取所有 audio sinks（输出设备）
mapfile -t items < <(wpctl status | awk '/Audio/ && /Sink/ {p=1; next} p && /^  \*/{next} p && /^[[:space:]]+[0-9]+/ {print}' | sed 's/^[[:space:]]*//')

# 用 rofi 让用户选择
choice=$(printf "%s\n" "${items[@]}" | rofi -dmenu -p "Select Audio Output")

# 提取设备 ID 并设为默认输出
id=$(echo "$choice" | awk '{print $1}')
[ -n "$id" ] && wpctl set-default "$id"
