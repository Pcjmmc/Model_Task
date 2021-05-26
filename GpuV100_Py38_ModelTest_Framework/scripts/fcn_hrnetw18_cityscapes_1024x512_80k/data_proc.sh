#!/bin/bash

#获取当前路径
cur_path=`pwd`
model_name=${PWD##*/}
echo "$model_name 模型数据预处理阶段"
#配置目标数据存储路径
root_path=$cur_path/../../




# 准备数据
if [ -d "$cur_path/../../seg_repo/data" ];then
rm -rf $cur_path/../../seg_repo/data
fi
mkdir $cur_path/../../seg_repo/data
if [ -d "$cur_path/../../seg_repo/data/cityscapes" ];then
rm -rf $cur_path/../../seg_repo/data/cityscapes
fi
ln -s /workspace/task/dataset/cityscape /workspace/task/seg_repo/data/cityscapes
