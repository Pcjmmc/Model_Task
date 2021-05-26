#!/bin/bash
# 外部传入参数
# $1 评估使用单卡or多卡

#获取当前路径
cur_path=`pwd`
model=${PWD##*/}
echo "${model} 模型数eval阶段"

#路径配置
root_path=$cur_path/../../
log_path=$root_path/log/$model/

if [ ! -d $log_path ]; then
  mkdir -p $log_path
fi


print_info(){
if [ $1 -ne 0 ];then
    echo "exit_code: 1.0" >> ${log_path}/${model}_eval_$2.log
else
    echo "exit_code: 0.0" >> ${log_path}/${model}_eval_$2.log
fi
}

eval_model_single(){
    python val.py \
       --config configs/bisenet/bisenet_cityscapes_1024x1024_160k.yml \
       --model_path https://bj.bcebos.com/paddleseg/dygraph/cityscapes/bisenet_cityscapes_1024x1024_160k/model.pdparams > ${log_path}/${model}_eval_single.log
    if [ $? -ne 0 ];then
        echo -e "${model},eval_single,FAIL"
    else
        echo -e "${model},eval_single,SUCCESS"
    fi
}

eval_model_multi(){
    python -m paddle.distributed.launch val.py \
       --config configs/bisenet/bisenet_cityscapes_1024x1024_160k.yml \
       --model_path https://bj.bcebos.com/paddleseg/dygraph/cityscapes/bisenet_cityscapes_1024x1024_160k/model.pdparams > ${log_path}/${model}_eval_multi.log
    if [ $? -ne 0 ];then
        echo -e "${model},eval_multi,FAIL"
    else
        echo -e "${model},eval_multi,SUCCESS"
    fi
}

cd $cur_path/../../seg_repo
if [ "$1" == 'single' ];then
eval_model_single
print_info $? single
else
eval_model_multi
print_info $? multi
fi
