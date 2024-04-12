#!/bin/bash

# 获取所有镜像 ID
image_ids=$(docker images -q)

# 循环处理每个镜像
for image_id in $image_ids; do
  # 获取镜像名称和标签
  image_name=$(docker inspect --format='{{.RepoTags}}' $image_id | cut -d' ' -f1)
  # 去除镜像名称中的方括号
  image_name=${image_name#[}
  image_name=${image_name%]}

  # 替换镜像名称中的冒号为目录分隔符
  image_name=${image_name//:/\/}

  # 将镜像保存为 tar 归档文件
  output_file="${image_name//\//-}.tar"
  docker save -o $output_file $image_id

  echo "镜像 $image_name 保存为 $output_file"
done