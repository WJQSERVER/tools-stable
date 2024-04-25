#! /bin/bash
# By WJQSERVER-STUDIO_WJQSERVER
#https://github.com/WJQSERVER/tools-dev

clear

# 显示免责声明
echo "免责声明：请阅读并同意以下条款才能继续使用本脚本。"
echo "本脚本仅供学习和参考使用，作者不对其完整性、准确性或实用性做出任何保证。"
echo "使用本脚本所造成的任何损失或损害，作者不承担任何责任。"

sleep 1

# 导入配置文件
source "repo_url.conf"

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


#重启
function reboot(){
echo "即将重启"
sleep 3    
reboot    
}

#返回主脚本
function back(){
    wget -O main.sh ${repo_url}main.sh && chmod +x main.sh && ./main.sh
}

#主菜单
function start_menu(){
    clear
    yellow " WJQserver Studio的快捷工具箱 BETA版 "
    green " WJQserver Studio tools BETA" 
    yellow " FROM: https://github.com/WJQSERVER/tools-dev "
    green " USE:  wget -O tools.sh ${repo_url}tools.sh && chmod +x tools.sh && clear && ./tools.sh "
    yellow " =================================================="
    green "1. 修改主机名"
    green "2. 修改时区"
    green "3. 修改密码"
    green "4. 修改SSH配置"
    green "5. 用户管理"
    yellow " =================================================="
    green "6. 修改网络配置&BBR"
    green "7. 修改日志配置"
    green "8. 防火墙配置"
    yellow " =================================================="
    green "9. SWAP配置"
    yellow " =================================================="
    green “10.解除腾讯云控”
    yellow " =================================================="
    green "90.一键DD系统"
    green "99.重启"
    yellow " =================================================="
    green " 0. 返回主脚本"
    echo
    read -p "请输入数字:" menuNumberInput
    case "$menuNumberInput" in
        1 )
         hostname
	     ;;
        2 )
	        timezone
        ;;
	     3 )
          ipv-switch
	     ;;
        4 )
	       networkinfo
        ;;
	     5 )
           change_dns
	     ;;
        6 )
	       bbr-manager
        ;;
	     7 )
           check_port_usage
	     ;;
        8 )
           ufw
        ;;
        9 )
           swap
        ;;
        10)
           user_management
        ;;
        11)
           change-root-password
        ;;
        12)
           create_user
        ;;
        13)
           generate_strong_password
        ;;
        14)
           ssh_connect
        ;;
        99)
           reboot
        ;;         

        0)
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
