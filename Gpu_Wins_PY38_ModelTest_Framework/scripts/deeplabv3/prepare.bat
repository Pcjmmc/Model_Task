@echo off
set seg_dir=./../../seg_repo
md  %seg_dir%/data/
mklink /j /workspace/task/dataset/cityscape/ %seg_dir%/data/cityscapes