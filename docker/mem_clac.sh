#!/bin/bash

# 初始化总内存占用为 0，单位是 KB
total_rss_kb=0

# 遍历 /proc 目录下的所有数字文件夹
for pid_dir in /proc/[0-9]*; do
    # 检查 status 文件是否存在且可读
    if [ -r "$pid_dir/status" ]; then
        # 从 status 文件中提取 VmRSS 的值 (第二列)
        rss_kb=$(grep VmRSS "$pid_dir/status" | awk '{print $2}')
        programName=$(grep Name "$pid_dir/status" | awk '{print $2}')
        tempProgram=$(echo "scale=2; $rss_kb / 1024" | bc)
        
        # 如果成功提取到值，则累加
        if [ -n "$rss_kb" ]; then
            total_rss_kb=$((total_rss_kb + rss_kb))
        fi
        echo $pid_dir - $programName ":" $tempProgram"MB"
    fi
done

# 将结果从 KB 转换为 MB 以方便阅读
total_rss_mb=$(echo "scale=2; $total_rss_kb / 1024" | bc)

echo "所有进程的总物理内存占用 (RSS):"
echo "${total_rss_kb} KB"
echo "${total_rss_mb} MB"

