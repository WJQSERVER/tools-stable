#! /bin/bash
# By WJQSERVER-STUDIO_WJQSERVER
#https://github.com/WJQSERVER-STUDIO/tools-stable

# 导入配置文件
source "repo_url.conf"

mikublue="\033[38;2;57;197;187m"
yellow='\033[33m'
white='\033[0m'
green='\033[0;32m'
blue='\033[0;34m'
red='\033[31m'
gray='\e[37m'

#彩色
mikublue(){
    echo -e "\033[38;2;57;197;187m\033[01m$1\033[0m"
}
white(){
    echo -e "\033[0m\033[01m$1\033[0m"
}
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
gray(){
    echo -e "\e[37m\033[01m$1\033[0m"
}
option(){
    echo -e "\033[32m\033[01m ${1}. \033[38;2;57;197;187m${2}\033[0m"
}

version=$(curl -s --max-time 3 ${repo_url}Version)
if [ $? -ne 0 ]; then
    version="unknown"  
fi

clear

# 显示免责声明
echo -e "${red}免责声明：${mikublue}请阅读并同意以下条款才能继续使用本脚本。"
echo -e "${yellow}===================================================================="
echo -e "${mikublue}本脚本仅供学习和参考使用，作者不对其完整性、准确性或实用性做出任何保证。"
echo -e "${mikublue}使用本脚本所造成的任何损失或损害，作者不承担任何责任。"
echo -e "${mikublue}不提供/保证任何功能的可用性，安全性，有效性，合法性"
echo -e "${mikublue}当前版本为${white}  [${yellow} V${version} ${white}]  ${white}"
echo -e "${yellow}===================================================================="
sleep 1

#BBR管理面板
function bbr-manager(){
    wget -O network_menu.sh ${repo_url}systools/network/network_menu.sh && chmod +x network_menu.sh && ./network_menu.sh
}

#WARP
function warp(){
    wget -N https://gitlab.com/fscarmen/warp/-/raw/main/menu.sh && bash menu.sh d
}

#WARP-GO
function warp-go(){
    wget -N https://gitlab.com/fscarmen/warp/-/raw/main/warp-go.sh && bash warp-go.sh d
}

#X-UI原版
function x-ui(){
    bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh) 0.3.2
}

#X-UI_F大魔改版
function x-ui_f(){
    bash <(curl -Ls https://raw.githubusercontent.com/FranzKafkaYu/x-ui/master/install.sh) 0.3.4.4
}

#3X-UI
function 3x-ui(){
    bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)
}

#3X-UI_中文
function 3x-ui-cn(){
    bash <(curl -Ls https://raw.githubusercontent.com/xeefei/3x-ui/master/install.sh) v2.4.1
}

#ArgoX F大
function argox(){
    bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/argox/main/argox.sh)
}

#返回主脚本
function back(){
    wget -O main.sh ${repo_url}main.sh && chmod +x main.sh && ./main.sh
}

#主菜单
function start_menu(){
    clear
    red " WJQserver Studio Linux工具箱"
    yellow " FROM: https://github.com/WJQSERVER-STUDIO/tools-stable "
    green " =================================================="
    option 1 "BBR管理面板" 
    green " =================================================="
    option 2 "WARP"
    option 3 "WARP-GO"
    green " =================================================="
    option 4 "X-UI"
    option 5 "X-UI_FranzKafkaYu分支"
    option 6 "3X-UI"
    option 7 "3X-UI_中文特化版(分支)"
    option 8 "ArgoX"
    green " =================================================="
    option 9 "返回主菜单"
    echo
    read -p "请输入数字:" menuNumberInput
    case "$menuNumberInput" in
        1 )
           bbr-manager
        ;;
        2 )
           warp
        ;;
        3 )
           warp-go
        ;;
        4 )
           x-ui
        ;;
        5 )
           x-ui_f
        ;;
        6 )
           3x-ui
        ;;
        7 )
           3x-ui-cn
        ;;   
        8 )
           argox
        ;;
        0 )
           back
        ;;
        
        * )
            clear
            red "请输入正确数字 !"
            start_menu
        ;;
    esac
}
start_menu "first"
