#!/bin/bash
# 外部传入参数
# $1 训练使用单卡or多卡

# export PYTHONPATH=`pwd`:$PYTHONPATH

#获取当前路径
cur_path=`pwd`
model=${PWD##*/}
echo "${model} 模型数train阶段"
#配置目标数据存储路径
root_path=$cur_path/../../
#创建日志路径
if [[ ! -d "$cur_path/../../log/${model}" ]];then
mkdir -p "$cur_path/../../log/${model}"
fi
#train
train_model_multi(){
    python -m paddle.distributed.launch train.py \
       --config configs/fcn/fcn_hrnetw18_cityscapes_1024x512_80k.yml \
       --save_interval 1000 \
       --iters 2000 \
       --save_dir output/fcn_hrnetw18_cityscapes_1024x512_80k >../log/${model}/${model}_train_multi.log 2>&1
    if [ $? -ne 0 ];then
        echo -e "${model},train_model_multi,FAIL"
    else
        echo -e "${model},train_model_multi,SUCCESS"
    fi
}
train_model_single(){
    python train.py \
       --config configs/fcn/fcn_hrnetw18_cityscapes_1024x512_80k.yml \
       --save_interval 1000 \
       --iters 2000 \
       --save_dir output/fcn_hrnetw18_cityscapes_1024x512_80k >../log/${model}/${model}_train_single.log 2>&1
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
