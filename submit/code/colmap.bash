#!/bin/bash

if [ $# -ne 1 ]; then
    echo "用法: $0 <图像目录>"
    exit 1
fi

IMAGE_DIR="$1"
OUTPUT_DIR="colmap_output_$(date +%Y%m%d_%H%M%S)"

echo "开始 COLMAP 重建..."
echo "图像目录: $IMAGE_DIR"
echo "输出目录: $OUTPUT_DIR"

mkdir -p "$OUTPUT_DIR"

# 1. 特征提取
echo "步骤1: 特征提取..."
colmap feature_extractor \
    --database_path "$OUTPUT_DIR/database.db" \
    --image_path "$IMAGE_DIR" \
    --ImageReader.single_camera 1 \
    --SiftExtraction.max_image_size 4000 \
    --SiftExtraction.max_num_features 16000 \
    --SiftExtraction.num_threads 8

# 2. 特征匹配
echo "步骤2: 特征匹配..."
colmap sequential_matcher \
    --database_path "$OUTPUT_DIR/database.db" \
    --SiftMatching.max_num_matches 32768 \
    --SiftMatching.max_error 4.0

# 3. 稀疏重建
echo "步骤3: 稀疏重建..."
colmap mapper \
    --database_path "$OUTPUT_DIR/database.db" \
    --image_path "$IMAGE_DIR" \
    --output_path "$OUTPUT_DIR/sparse" \
    --Mapper.num_threads 8

echo "完成！输出在: $OUTPUT_DIR"