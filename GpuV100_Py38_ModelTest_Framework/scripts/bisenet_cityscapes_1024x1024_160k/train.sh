#!/bin/bash
# 外部传入参数
# $1 训练使用单卡or多卡

# export PYTHONPATH=`pwd`:$PYTHONPATH

#获取当前路径
cur_path=`pwd`
model=${PWD##*/}
echo "${model} 模型数train阶段"
#路径配置
root_path=$cur_path/../../
log_path=$root_path/log/$model/

if [ ! -d $log_path ]; then
  mkdir -p $log_path
fi

#train
train_model_multi(){
    python -m paddle.distributed.launch train.py \
       --config configs/bisenet/bisenet_cityscapes_1024x1024_160k.yml \
       --save_interval 1000 \
       --iters 2000 \
       --save_dir output/bisenet_cityscapes_1024x1024_160k \
       --batch_size=2 > ${log_path}/${model}_train_multi.log 2>&1
    if [ $? -ne 0 ];then
        echo -e "${model},train_model_multi,FAIL"
    else
        echo -e "${model},train_model_multi,SUCCESS"
    fi
}
train_model_single(){
    python train.py \
       --config configs/bisenet/bisenet_cityscapes_1024x1024_160k.yml \
       --save_interval 1000 \
       --iters 2000 \
       --save_dir output/bisenet_cityscapes_1024x1024_160k \
       --batch_size=2 > ${log_path}/${model}_train_single.log 2>&1
    if [ $? -ne 0 ];then
        echo -e "${model},train_model_single,FAIL"
    else
        echo -e "${model},train_model_single,SUCCESS"
    fi
}

cd $cur_path/../../seg_repo
if [ "$1" == 'single' ];then
train_model_single
else
train_model_multi
fi
