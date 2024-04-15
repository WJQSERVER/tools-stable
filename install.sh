#!/bin/bash

source "repo_url.conf"

# 检查文件是否存在并且包含repo_url值
if [[ -f "$conf_file" && $(grep -c "^repo_url=" "$conf_file") -gt 0 ]]; then
  sed -i "s/^repo_url=.*/repo_url=$repo_url/" "$conf_file"
else
  echo "repo_url=$repo_url" > "$conf_file"
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
${install} update
${install} install wget curl vim git sudo -y
${install} upgrade -y    
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
cat > "$conf_file" << EOF
repo_url=$repo_url
install=apt
EOF

}

function yum(){
cat > "$conf_file" << EOF
repo_url=$repo_url
install=yum
EOF

}

function apk(){
cat > "$conf_file" << EOF
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