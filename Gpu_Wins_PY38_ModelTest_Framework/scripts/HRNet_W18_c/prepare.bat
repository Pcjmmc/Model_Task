@echo off
cd ../..
xcopy /y /c /h /r .\HRNet\HRNet_W18_C.yaml  .\clas_repo\configs\HRNet\
md log\HRNet_W18_c
cd clas_repo
rd /s /q dataset
md dataset
mklink /j  dataset\ILSVRC2012  D:\liuhuanling\dataset\ILSVRC2012