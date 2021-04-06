#unset http_proxy
HTTPPROXY=$http_proxy
HTTPSPROXY=$https_proxy
unset http_proxy
unset https_proxy
#外部传入参数说明
# $1:  $XPU = gpu or cpu
#获取当前路径
cur_path=`pwd`
model_name=${PWD##*/}
echo "$model_name 模型训练阶段"
#路径配置
root_path=$cur_path/../../
code_path=$cur_path/../../nlp_repo/examples/lexical_analysis/
log_path=$root_path/log/$model_name/
mkdir -p $log_path
#临时环境更改
cd $root_path/nlp_repo
#访问RD程序
cd $code_path

python train.py \
        --data_dir ./lexical_analysis_dataset_tiny \
        --model_save_dir ./save_dir \
        --epochs 10 \
        --batch_size 32 \
        --device $1 >$log_path/$1_$2_train.log 2>&1 

#set http_proxy
export http_proxy=$HTTPPROXY
export https_proxy=$HTTPSPROXY
