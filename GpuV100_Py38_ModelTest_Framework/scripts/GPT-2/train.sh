#外部传入参数说明
# $1: 'single' 单卡训练； 'multi' 多卡训练； 'recv' 恢复训练
# $2:  $XPU = gpu or cpu
#获取当前路径
cur_path=`pwd`
model_name=${PWD##*/}
echo "$model_name 模型训练阶段"

#路径配置
root_path=$cur_path/../../
code_path=$cur_path/../../nlp_repo/examples/language_model/gpt2/
log_path=$root_path/log/$model_name/
mkdir -p $log_path
#访问RD程序
cd $code_path
if [[ $1 == 'multi' ]];then #多卡
    python -m paddle.distributed.launch --gpus "$3" run_pretrain.py \
        --model_type gpt2\
        --model_name_or_path gpt2-small-en\
        --input_dir "./data"\
        --output_dir "multi_output"\
        --max_lr 0.00015\
        --min_lr 0.00001\
        --weight_decay 0.01\
        --grad_clip 1.0\
        --max_steps 10\
        --save_steps 10\
        --decay_steps 320000\
        --warmup_rate 0.01\
        --batch_size 8\
        --device gpu > $log_path/multi_cards_train.log 2>&1
else #单卡或CPU
    python run_pretrain.py --model_type gpt2\
        --model_name_or_path gpt2-small-en\
        --input_dir "./data"\
        --output_dir "output"\
        --max_lr 0.00015\
        --min_lr 0.00001\
        --weight_decay 0.01\
        --grad_clip 1.0\
        --max_steps 10\
        --save_steps 10\
        --decay_steps 320000\
        --warmup_rate 0.01\
        --batch_size 8\
        --device gpu > $log_path/single_card_train.log 2>&1
fi
