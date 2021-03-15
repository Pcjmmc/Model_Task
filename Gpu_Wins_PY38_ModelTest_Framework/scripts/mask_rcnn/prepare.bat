@echo off
cd ../..
cd detection_repo
rd /s /q dataset
md dataset
mklink /j dataset\coco  D:\liuhuanling\dataset\coco