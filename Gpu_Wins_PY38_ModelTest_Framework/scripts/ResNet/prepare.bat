@echo off
cd ../..
md log\ResNet50_vd
md log\ResNet50
cd clas_repo
rd /s /q dataset
md dataset
mklink /j  dataset\ILSVRC2012  D:\liuhuanling\dataset\ILSVRC2012