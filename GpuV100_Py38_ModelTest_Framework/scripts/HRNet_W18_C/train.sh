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
code_path=$cur_path/../../clas_repo/
log_path=$root_path/log/$model_name/

if [ ! -d $log_path ]; then
  mkdir -p $log_path
fi

cd $code_path

sed -i 's/RandCropImage/ResizeImage/g' configs/HRNet/HRNet_W18_C.yaml
sed -ie '/RandFlipImage/d' configs/HRNet/HRNet_W18_C.yaml
sed -ie '/flip_code/d' configs/HRNet/HRNet_W18_C.yaml

if [[ $2 == 'multi' ]];then #多卡
  python -m paddle.distributed.launch tools/train.py -c configs/HRNet/HRNet_W18_C.yaml -o epochs=5 -o TRAIN.batch_size=64 -o validate=False > $log_path/train_$2_$1.log 2>&1
  # cat $log_path/train_$2_$1.log | grep " END epoch:4" >> $log_path/train_$2_$1.log
else #单卡
  python tools/train.py -c configs/HRNet/HRNet_W18_C.yaml -o epochs=5 -o TRAIN.batch_size=64 -o validate=False > $log_path/train_$2_$1.log 2>&1
  # cat $log_path/train_$2_$1.log | grep " END epoch:4" >> $log_path/train_$2_$1.log
fi
