export seg_dir=$PWD/../../seg_repo
export data_path=$PWD/../../dataset
# 数据存储路径
mkdir -p ${seg_dir}/dataset/
ln -s ${dataset_path}/cityscape  ${seg_dir}/dataset/cityscape