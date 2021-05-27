@echo off
cd ../..
xcopy /y /c /h /r .\MobileNetV3\MobileNetV3_large_x1_0.yaml  .\clas_repo\configs\MobileNetV3
md log\MobileNetV3_large_x1_0
cd clas_repo
rd /s /q dataset
md dataset
mklink /j  dataset\ILSVRC2012  D:\liuhuanling\dataset\ILSVRC2012