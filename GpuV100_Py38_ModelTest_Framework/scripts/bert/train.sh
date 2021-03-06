
cur_path=`pwd`
model_name=${PWD##*/}

echo "$model_name 模型训练阶段"
#取消代理
HTTPPROXY=$http_proxy
HTTPSPROXY=$https_proxy
unset http_proxy
unset https_proxy

#路径配置
root_path=$cur_path/../../
code_path=$cur_path/../../nlp_repo/examples/language_model/$model_name/
log_path=$root_path/log/$model_name/

if [ ! -d $log_path ]; then
  mkdir -p $log_path
fi

echo $CUDA_VISIBLE_DEVICES
#访问RD程序
cd $code_path
unset CUDA_VISIBLE_DEVICES

print_info(){
if [ $1 -ne 0 ];then
    cat ${log_path}/$2.log
fi
}

if [[ $1 == 'multi' ]];then #多卡
    python -m paddle.distributed.launch --gpus "$2"  run_pretrain.py \
    --model_type bert \
    --model_name_or_path bert-base-uncased \
    --max_predictions_per_seq 20 \
    --batch_size 32   \
    --learning_rate 1e-4 \
    --weight_decay 1e-2 \
    --adam_epsilon 1e-6 \
    --warmup_steps 10000 \
    --num_train_epochs 1 \
    --input_dir data/ \
    --output_dir pretrained_models_multi/ \
    --logging_steps 1 \
    --save_steps 1 \
    --max_steps 3 \
    --device gpu \
    --use_amp False > $log_path/multi_cards_train.log 2>&1
    print_info $? "multi_cards_train"

else #单卡或CPU

    python -m paddle.distributed.launch --gpus "$2"  run_pretrain.py \
    --model_type bert \
    --model_name_or_path bert-base-uncased \
    --max_predictions_per_seq 20 \
    --batch_size 32   \
    --learning_rate 1e-4 \
    --weight_decay 1e-2 \
    --adam_epsilon 1e-6 \
    --warmup_steps 10000 \
    --num_train_epochs 3 \
    --input_dir data/ \
    --output_dir pretrained_models/ \
    --logging_steps 1 \
    --save_steps 1 \
    --max_steps 3 \
    --device gpu \
    --use_amp False > $log_path/single_card_train.log 2>&1
    print_info $? "single_card_train"
fi

export http_proxy=$HTTPPROXY
export https_proxy=$HTTPSPROXY	
