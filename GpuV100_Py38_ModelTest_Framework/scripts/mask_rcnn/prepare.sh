export seg_dir=$PWD/../../detection_repo
# export data_path=$PWD/../../dataset
# # 数据存储路径
# mkdir -p ${seg_dir}/data/
# ln -s ${dataset_path}/cityscape/ ${seg_dir}/data/cityscapes
mkdir -p ${seg_dir}/data/
ln -s /workspace/task/dataset/coco/ /workspace/task/detection_repo/data/coco