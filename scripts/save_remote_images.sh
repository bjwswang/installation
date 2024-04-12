#!/bin/bash

# 读取 JSON 文件
image_json="images.json"

# 解析 JSON 文件并迭代处理每个 image
cat "$image_json" | jq -r '.kind[]' | while read -r image
do
  # 拉取镜像
  echo "Pulling image: $image"
  docker pull "$image"

  # 提取镜像名称和标签
  image_name=$(echo "$image" | awk -F":" '{print $1}')
  image_tag=$(echo "$image" | awk -F":" '{print $2}')

  # 保存镜像为 tar 文件
  tar_filename="${image_name//\//-}_$image_tag.tar"
  echo "Saving image as tar file: $tar_filename"
  docker save -o "$tar_filename" "$image"
done