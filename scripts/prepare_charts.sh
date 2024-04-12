#!/bin/bash

# 读取 JSON 文件
json=$(cat charts.json)

# 解析 JSON 数据并克隆代码库
for row in $(echo "$json" | jq -r '.[] | @base64'); do
    _jq() {
        echo ${row} | base64 --decode | jq -r ${1}
    }

    repo_name=$(_jq '.name')
    repo_url=$(_jq '.url')

    echo "Cloning $repo_name from $repo_url"
    git clone "$repo_url"
done