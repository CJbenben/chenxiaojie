# 崩溃日志 ips 解析脚本
# 脚本执行方法
# 1. 将此脚本放到新建文件夹后，还需要两个文件
# (1)dSYM 文件，非 zip 格式（只允许一个）
# (2)崩溃的 ips 文件，设置->隐私与安全性->分析与改进->分析数据（多个 ips 文件，默认执行最后一个）
# 2. cd 到此文件夹下后，执行  sh crashAnalysis.sh（可能会要求输入电脑密码）
# 脚本使用说明
# 1. 执行脚本后，控制台会打印 UUID 和 CrashSymbolicator.py 脚本路径
# 2. 脚本会自动打开两个 ips 文件，一个原始 ips 文件，另一个是 result.ips 文件（解析后）
# 3. 如果 result.ips 没有解析成功，注意 ips 文件的 UUID 和 dsym 的是否一样

# dsym 文件
dSYM_name="xxx.app.dSYM"
for file in *.app.dSYM; do
  dSYM_name=$file
done
# 原始的 ips 文件
ips_original=$(ls *.ips)
for file in *.ips; do
  ips_original=$file
done
# 解析后的 ips 文件名
ips_result="result.ips"

echo "dSYM_name = $dSYM_name"
echo "ips_original = $ips_original"

py_path="/Applications/Xcode.app/Contents/SharedFrameworks/CoreSymbolicationDT.framework/Versions/A/Resources"
# 读取 dsym 的uuid，如果对应不上，解析不出来
dwarfdump --uuid ${dSYM_name}
echo '查找 CrashSymbolicator.py 文件路径'
find /Applications/Xcode.app -name CrashSymbolicator.py -type f

# 打开原始的 ips 文件
open ${ips_original}

echo cp ${ips_original} ${py_path}
# 拷贝 dsym 和 原始 ips 文件
sudo cp -r ${dSYM_name} ${py_path}
sudo cp -r ${ips_original} ${py_path}

cd ${py_path}
# 删除上一次结果数据
sudo rm -rf ${ips_result}
# 解析 ips 文件
sudo python3 CrashSymbolicator.py -d ${dSYM_name} -o ${ips_result} -p ${ips_original}
# 删除文件
sudo rm -rf ${dSYM_name}
sudo rm -rf ${ips_original}
# 打开解析后的 ips 文件
open ${py_path}/${ips_result}
