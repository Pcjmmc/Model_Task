@echo off
cd ../..
xcopy /y /c /h /r .\Resnet\ResNet50.yaml  .\clas_repo\configs\ResNet
xcopy /y /c /h /r .\Resnet\ResNet50_vd.yaml  .\clas_repo\configs\ResNet
md log\ResNet50_vd
md log\ResNet50
cd clas_repo
rd /s /q dataset
md dataset
mklink /j  dataset\ILSVRC2012  D:\liuhuanling\dataset\ILSVRC2012