@echo off
cd ../..
cd detection_repo
cd static
rd /s /q dataset
md dataset
mklink /j dataset\coco  D:\liuhuanling\dataset\coco