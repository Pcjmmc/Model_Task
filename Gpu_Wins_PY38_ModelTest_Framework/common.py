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

EXEC_TAG = [
    "win_st_gpu1",
    "win_dy_gpu1",
    # 补充一些自定义标签
    "win_download_data"
]

SET_CUDA="0"