#!/bin/bash
#name: file_message.sh
#

if [[ $# -ne 1 ]]; then  # not input any parameter
	#statements
	echo "usage is $0 basepath"
	exit
fi
path=$1 	#parameter is file path

declare -A statarray; 	#statarray is a array

while read line; do
	#statements
	echo "$line"
	ftype=`file -b "$line" | cut -d, -f1 ` 	#-d, 表示用,作为分割符，-f1表示提取第一个属性作为ftype
	let statarray["$ftype"]++; 				#统计每种类型的数量
done< <(find $path -type f -print ) 		#读取当前目录下的文件名，读到line中

echo ========= File types and counts ===========
for ftype in "${!statarray[@]}"; 			#返回数组的索引列表
do
	echo $ftype : ${statarray["$ftype"]}
done