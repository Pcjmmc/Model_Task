@echo off
cd ../..
cd seg_repo
rd /s /q data
md data
mklink /j data\cityscapes  D:\liuhuanling\dataset\cityscape