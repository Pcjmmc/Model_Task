export seg_dir=$PWD/../../seg_repo
mkdir -p ${seg_dir}/data/
ln -s /workspace/task/dataset/cityscape/ /workspace/task/seg_repo/data/cityscapes

# 创建日志路径
cur_path=`pwd`
model_name=${PWD##*/}
log_path=$PWD/../../log/$model_name/
mkdir -p $log_path