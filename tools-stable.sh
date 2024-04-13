#! /bin/bash
# By WJQSERVER-STUDIO_WJQSERVER
#https://github.com/WJQSERVER/tools-dev

# 显示免责声明
echo "免责声明：请阅读并同意以下条款才能继续使用本程序。"
echo "本脚本仅供学习和参考使用，作者不对其完整性、准确性或实用性做出任何保证。"
echo "使用本脚本所造成的任何损失或损害，作者不承担任何责任。"
echo "当前版本为V.0.9"

sleep 1

conf_file="repo_url.conf"

#BETA版
repo_url="https://raw.githubusercontent.com/WJQSERVER/tools-stable/main/"

echo "repo_url=$repo_url" > "$conf_file"

# 导入配置文件
source "repo_url.conf"

# 显示确认提示
read -p "您是否同意上述免责声明？(y/n): " confirm

# 处理确认输入
if [[ $confirm != [Yy] ]]; then
    echo "您必须同意免责声明才能继续使用本脚本。"
    exit 1
fi

#install變量
# 检测发行版类型
if [ -f /etc/os-release ]; then
    source /etc/os-release
    DISTRIBUTION=$ID
elif [ -f /etc/redhat-release ]; then
    DISTRIBUTION="rhel"
elif [ -f /etc/openwrt_release ]; then
    DISTRIBUTION="openwrt"
elif [ -f /etc/alpine-release ]; then
    DISTRIBUTION="alpine"    
else
    echo "暂不支持该发行版"
    exit 1
fi

function apt(){ 
cat > "$file_path" << EOF
repo_url=$repo_url
install=apt
EOF

}

function yum(){
cat > "$file_path" << EOF
repo_url=$repo_url
install=yum
EOF

}

function apk(){
cat > "$file_path" << EOF
repo_url=$repo_url
install=apk
EOF

}
# 根据发行版类型执行相应的命令
case $DISTRIBUTION in
    "ubuntu")
        apt
        ;;
    "debian")
        apt
        ;;
    "centos" | "rhel")
        yum
        ;;
    "alpine")
        apk
        ;;    
    *)
        echo "暂不支持该发行版"
        exit 1
        ;;
esac

# 确认执行操作
read -p "此操作将安装 wget, curl, vim 等常用软件包并进行更新。是否继续？(不进行此操作可能造成脚本异常)(y/n) " choice

if [[ $choice == "y" ]]; then
  # 安装软件包
  ${install} update
  ${install} install wget curl vim git sudo -y
  ${install} upgrade -y
fi

#彩色
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}

#主脚本
wget -O main.sh ${repo_url}main.sh && chmod +x main.sh && clear && ./main.sh
