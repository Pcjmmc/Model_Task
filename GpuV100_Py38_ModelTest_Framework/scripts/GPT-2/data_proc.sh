#获取当前路径
cur_path=`pwd`
model_name=${PWD##*/}
echo "$model_name 模型数据预处理阶段"
#配置目标数据存储路径
root_path=$cur_path/../../
code_path=$cur_path/../../nlp_repo/examples/language_model/gpt2/
#获取数据逻辑
#清除之前下载的脚本
rm -rf $code_path/raw_data
rm -rf $code_path/data
mkdir -p $code_path/data
wget -P $code_path http://10.21.226.155:8687/openwebtext.tar.xz
wget -P $code_path/data https://paddlenlp.bj.bcebos.com/models/transformers/gpt2/train.data.json_ids.npz
#数据处理逻辑
cd $code_path
xz -d openwebtext.tar.xz
tar xf openwebtext.tar
mkdir raw_data
bash decompress.sh
python process_data.py --input_path raw_data \
    --model_name gpt2-medium-en \
    --append_eod \
    --workers 8