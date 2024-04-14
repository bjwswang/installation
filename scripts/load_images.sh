#!/bin/bash

# 获取当前目录下的所有镜像文件
image_files=$(find . -name "*.tar")

# 循环处理每个镜像文件
for image_file in $image_files; do
  # 提取镜像名称和标签
  image_name=$(basename $image_file | sed 's/\.tar$//')

  # 加载镜像文件到 Docker
  docker load -i $image_file

  echo "镜像 $image_name 加载成功"
done