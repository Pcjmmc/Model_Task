# encoding: utf-8
import os
ROOT_PATH = os.path.dirname(os.path.abspath(__file__))
PROJECT_ROOT = os.path.dirname(ROOT_PATH)
HTTP_PROXY = "http://172.19.61.250:3128"
HTTPS_PROXY = "http://172.19.61.250:3128"

NLP_ADDR = "https://github.com/PaddlePaddle/PaddleNLP.git"
SEG_ADDR  = "https://github.com/PaddlePaddle/PaddleSeg.git"
ClAS_ADDR = "https://github.com/PaddlePaddle/PaddleClas.git"
DETECTION_ADDR = "https://github.com/PaddlePaddle/PaddleDetection.git"



PADDLE_ON_MODEL_CE = "1"

EXEC_TAG = [
    "linux_st_gpu1", "linux_st_gpu4",
    "linux_dy_gpu1", "linux_dy_gpu4",
    "linux_st_gpu8", "linux_dy_gpu8",
    # 补充一些自定义标签
    "linux_download_data", "linux_finetune_gpu1_SST-2",
    "linux_finetune_gpu1_QNLI", "linux_finetune_gpu1_CoLA",
    "linux_finetune_gpu1_MRPC", "linux_finetune_gpu1_STS-B",
    "linux_finetune_gpu1_QQP", "linux_finetune_gpu1_MNLI",
    "linux_finetune_gpu1_RTE", 
]

SET_CUDA="1"

SET_MULTI_CUDA="0,1,2,3"

XPU="gpu"