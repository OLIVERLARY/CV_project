#!/bin/bash

if [ $# -eq 0 ]; then
    echo "用法: $0 <视频文件.mp4>"
    echo "示例: $0 video.mp4"
    exit 1
fi

input_video="$1"
output_dir="frames_$(date +%Y%m%d_%H%M%S)"

mkdir -p "$output_dir"

duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$input_video")

echo "视频文件: $input_video"
echo "视频时长: $duration 秒"
echo "输出目录: $output_dir"

frame_count=0
for time in $(seq 0 0.5 $duration); do
    output_file="${output_dir}/frame_$(printf "%06d" $frame_count).jpg"
    
    ffmpeg -ss "$time" -i "$input_video" -frames:v 1 -q:v 2 -y "$output_file" 2>/dev/null
    
    echo "已抽取: $output_file (时间: ${time}s)"
    ((frame_count++))
done

echo "完成！共抽取 $frame_count 帧。"
echo "帧保存到: $output_dir/"