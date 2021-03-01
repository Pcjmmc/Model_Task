@echo off
set seg_dir=./../../clas_repo
md %seg_dir%/dataset/
mklink /j /workspace/task/dataset/ILSVRC2012/ %seg_dir%/dataset/ILSVRC2012