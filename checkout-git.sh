#!/bin/bash

# 使用 find 命令找到深度为2的目录
for dir in $(find . -mindepth 2 -maxdepth 2 -type d)
do
    # 进入子目录
    cd "${dir}"

    # 检查是否存在.git目录，如果存在，则进行git操作
    if [ -d ".git" ]; then
        echo -e "\033[1;34mProcessing ${dir}\033[0m"

        # 获取remotes/origin/HEAD指向的分支，并移除 "origin/" 前缀
        head_branch=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} | sed 's/^origin\///')

        # 获取当前的分支
        current_branch=$(git branch --show-current)

        # 检查当前分支是否是remotes/origin/HEAD指向的分支
        if [ "${head_branch}" == "${current_branch}" ]; then
            echo -e "\033[1;32mCurrent branch ${current_branch} is the same as remotes/origin/HEAD, which is ${head_branch}\033[0m"
        else
            echo -e "\033[1;31mCurrent branch ${current_branch} is not the same as remotes/origin/HEAD, which is ${head_branch}\033[0m"
        fi
    fi

    # 返回到原始的工作目录
    cd - > /dev/null
done
