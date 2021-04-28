
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

sed -i 's/RandCropImage/ResizeImage/g' configs/MobileNetV3/MobileNetV3_large_x1_0.yaml
sed -ie '/RandFlipImage/d' configs/MobileNetV3/MobileNetV3_large_x1_0.yaml
sed -ie '/flip_code/d' configs/MobileNetV3/MobileNetV3_large_x1_0.yaml
# sed -i '46,47d' configs/MobileNetV3/MobileNetV3_large_x1_0.yaml

if [[ $2 == 'multi' ]];then #多卡
  python -m paddle.distributed.launch tools/train.py -c configs/MobileNetV3/MobileNetV3_large_x1_0.yaml -o epochs=5 -o TRAIN.batch_size=64 -o validate=False -o LEARNING_RATE.params.lr=0.65 > $log_path/train_$2_$1.log 2>&1
else #单卡
  python tools/train.py -c configs/MobileNetV3/MobileNetV3_large_x1_0.yaml -o epochs=5 -o TRAIN.batch_size=64 -o validate=False -o LEARNING_RATE.params.lr=0.65 > $log_path/train_$2_$1.log 2>&1
fi
