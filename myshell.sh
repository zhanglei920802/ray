#!/usr/bin/env bash
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the 
# public domain worldwide. This software is distributed without any warranty. 
# You should have received a copy of the CC0 Public Domain Dedication along 
# with this software. 
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>. 

# base-files version 4.2-3

# ~/.bashrc: executed by bash(1) for interactive shells.

# The latest version as installed by the Cygwin Setup program can
# always be found at /etc/defaults/etc/skel/.bashrc

# Modifying /etc/skel/.bashrc directly will prevent
# setup from updating it.

# The copy in your home directory (~/.bashrc) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a patch to the cygwin mailing list.

# User dependent .bashrc file

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Shell Options
#
# See man bash for more options...
#
# Don't wait for job termination notification
# set -o notify
#
# Don't use ^D to exit
# set -o ignoreeof
#
# Use case-insensitive filename globbing
 shopt -s nocaseglob
#
# Make bash append rather than overwrite the history on disk
# shopt -s histappend
#
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# Completion options
#
# These completion tuning parameters change the default behavior of bash_completion:
#
# Define to access remotely checked-out files over passwordless ssh for CVS
# COMP_CVS_REMOTE=1
#
# Define to avoid stripping description in --option=description of './configure --help'
# COMP_CONFIGURE_HINTS=1
#
# Define to avoid flattening internal contents of tar files
# COMP_TAR_INTERNAL_PATHS=1
#
# Uncomment to turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
# [[ -f /etc/bash_completion ]] && . /etc/bash_completion

# History Options
#
# Don't put duplicate lines in the history.
# export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
#
# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"

# Aliases
#
# Some people use a different file for aliases
if [ -f "${HOME}/.bash_aliases" ]; then
  source "${HOME}/.bash_aliases"
fi

# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.
#
# Interactive operation...
 alias rm='rm -i'
 alias cp='cp -i'
 alias mv='mv -i'
#
# Default to human readable figures
 alias df='df -h'
 alias du='du -h'
#
# Misc :)
 alias less='less -r'                          # raw control characters
 alias whence='type -a'                        # where, of a sort
 alias grep='grep --color'                     # show differences in colour
 alias egrep='egrep --color=auto'              # show differences in colour
 alias fgrep='fgrep --color=auto'              # show differences in colour
#
# Some shortcuts for different directory listings
 alias ls='ls -hF --color=tty'                 # classify files in colour
 alias dir='ls --color=auto --format=vertical'
 alias vdir='ls --color=auto --format=long'
 alias ll='ls -al'                              # long list
 alias la='ls -A'                              # all but . and ..
 alias l='ls -CF'                              #

# Umask
#
# /etc/profile sets 022, removing write perms to group + others.
# Set a more restrictive umask: i.e. no exec perms for others:
# umask 027
# Paranoid: neither group nor others have any perms:
# umask 077

# Functions
#
# Some people use a different file for functions
# if [ -f "${HOME}/.bash_functions" ]; then
#   source "${HOME}/.bash_functions"
# fi
#
# Some example functions:
#
# a) function settitle
settitle () 
{ 
  echo -ne "\e]2;$@\a\e]1;$@\a"; 
}

# b) function cd_func
# This function defines a 'cd' replacement function capable of keeping, 
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
cd_func ()
{
  local x2 the_new_dir adir index
  local -i cnt

  if [[ $1 ==  "--" ]]; then
    dirs -v
    return 0
  fi

  the_new_dir=$1
  [[ -z $1 ]] && the_new_dir=$HOME

  if [[ ${the_new_dir:0:1} == '-' ]]; then
    #
    # Extract dir N from dirs
    index=${the_new_dir:1}
    [[ -z $index ]] && index=1
    adir=$(dirs +$index)
    [[ -z $adir ]] && return 1
    the_new_dir=$adir
  fi

  #
  # '~' has to be substituted by ${HOME}
  [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

  #
  # Now change to the new dir and add to the top of the stack
  pushd "${the_new_dir}" > /dev/null
  [[ $? -ne 0 ]] && return 1
  the_new_dir=$(pwd)

  #
  # Trim down everything beyond 11th entry
  popd -n +11 2>/dev/null 1>/dev/null

  #
  # Remove any other occurence of this dir, skipping the top of the stack
  for ((cnt=1; cnt <= 10; cnt++)); do
    x2=$(dirs +${cnt} 2>/dev/null)
    [[ $? -ne 0 ]] && return 0
    [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
    if [[ "${x2}" == "${the_new_dir}" ]]; then
      popd -n +$cnt 2>/dev/null 1>/dev/null
      cnt=cnt-1
    fi
  done

  return 0
}
alias dev=cd_browser

#进入Git BrowserShell 目录
function cd_browser(){
	case "$1" in  
	"git"	) cd "E:\Git\master\BrowserShell\BrowserShell";;  
	"3.3"   ) cd "E:\Workspace\Browser_Kernel\branches\3.3\BrowserShell";;  
    "3.4.1") cd "E:\Workspace\Browser_Kernel\branches\3.4.1\BrowserShell";; 
	"3.5"	) cd "E:\Git\V35\BrowserShell\BrowserShell";;  
	"2.4"   ) cd "E:\Workspace\Browser_OV\branches\V2.4";; 
	"3.7"	) cd "E:\Git\aplha\BrowserShell\BrowserShell";;   	
	esac
}

#adb 相关命名
alias adbs=function_adb
function function_adb(){
	case "$1" in
		"re" ) 
				adb kill-server
				adb start-server
				adb devices
		;;
		"ps" )
		 netstat -ano | findstr "5037"
		;;
	esac
}
#安装apk的命名
alias ins_apk=function_install
function function_install(){
	case "$1" in
		"3.3" )
			adb install -r "E:\Workspace\Browser_Kernel\branches\3.3\BrowserShell\bin\BrowserShell-prod-debug.apk"
		;;
		"3.4.1" )
			adb install -r "E:\Workspace\Browser_Kernel\branches\3.4.1\BrowserShell\bin\BrowserShell-prod-debug.apk"
		;;
		*	)			
			adb install -r "E:\Git\BrowserShell\BrowserShell\bin\BrowserShell-prod-debug.apk"
		;;
	esac
}

#
alias make_copy=cp_make
function cp_make(){
case "$1" in  
	"git"	) 
		cd "E:\Git\master\BrowserShell"
		make -f F:/leizhang/cygwin64/mysh/makefile
	;;  
	"3.3"   ) 
		cd "E:\Workspace\Browser_Kernel\branches\3.3"
		make -f F:/leizhang/cygwin64/mysh/makefile
	;;  
	"3.4") 
		cd "E:\Workspace\Browser_Kernel\branches\3.4"
		make -f F:/leizhang/cygwin64/mysh/makefile
	;; 
	"3.5") 
		cd "E:\Git\V35\BrowserShell"
		make -f F:/leizhang/cygwin64/mysh/makefile
	;;
    "3.4.1") 
		cd "E:\Workspace\Browser_Kernel\branches\3.4.1"
		make -f F:/leizhang/cygwin64/mysh/makefile
	;;  
	esac

}
#alias pwd=sed 's/\/cygdrive\/\(.\)\//\1:\\/g'
#alias pwd=function_pwd
# function function_pwd(){
	# echo  $(pwd);
# }


###########################################Android#######################################################
alias ls='ls --color --show-control-chars'
#保存配置文件
alias save_config='source ~/.bashrc ~/.bash_profile'
alias xpf=explorer
alias copy_config=copy_projects_file
#导出最近任务
alias dump_activity="adb shell dumpsys activity activities | sed -En -e '/Running activities/,/Run #0/p'"
#截屏
alias adb_capture="adb shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > screen.png"
alias adb_turn_off="adb shell input keyevent 26"
alias adb_turn_on="adb shell input keyevent 82"
alias log_stat="adb logcat | grep 'com.android.statistics\|eventID\|eventTag\|eventTime'"
alias start_test="adb shell am start  -n 'com.android.browser/com.oppo.browser.iflow.weather.WeatherActivity' -a android.intent.action.MAIN -c android.intent.category.LAUNCHER"
#禁用overDraw选项
alias disable_overdraw='adb shell setprop debug.hwui.overdraw false'
#开启overDraw的选项
alias enable_overdraw='adb shell setprop debug.hwui.overdraw true'
#导出当前正在前台运行的activity
alias adb_current_activity='adb shell dumpsys activity | grep mFocusedActivity'
#导出当前的内存使用情况
alias adb_dump_browser_memory='adb shell dumpsys meminfo com.android.browser'
#dump gfx信息
alias adb_dump_gfx_info='adb shell dumpsys gfxinfo com.android.browser'
alias adb_uninstall='adb shell pm uninstall $1'
#dump当前window的层次树
alias adb_dump_view_tree=dumpViewTree
alias adb_dump_activity=dumpActivity
alias findname=function_find

function function_find(){
	find $1 -name "$2"
}
#导出指定包名的AMS的信息，包括
#1.PENDING INTENTS：dumpsys activity intents
#2.BROADCAST STATE：dumpsys activity broadcasts
#3.CONTENT PROVIDERS：dumpsys activity providers
#4.SERVICES：dumpsys activity services
#5.RECENT TASKS (dumpsys activity recents)
#6.ACTIVITIES (dumpsys activity activities)
	#ViewRoot
	#Choreographer
	#View Hierarchy
	#Running activities (most recent first)
	#mFocusedActivity
#7.RUNNING PROCESSES (dumpsys activity processes)
function dumpActivity(){
	echo '####################dump begin###############'
	adb shell dumpsys activity -p $1 > dump_activity.txt
	echo '####################dump end###############'
}
function copy_projects_file(){
	originDir=/myconfig/Browser
	#echo $(pwd)/BrowserReader/
	echo "####copy BrowserReader##########"
	\cp -rf ${originDir}/BrowserReader/  ./
	echo "####copy BrowserShell##########"
	\cp -rf ${originDir}/BrowserShell/  ./
	echo "####copy Kernel##########"
	\cp -rf ${originDir}/Kernel/  ./
}

#导出当前window的view tree，然后copy 到当前目录
function dumpViewTree(){
	echo '##################dump start ############################'
	adb shell uiautomator dump /mnt/sdcard/window_dump.xml;
	adb pull /mnt/sdcard/window_dump.xml .;
	echo '##################dump end ##############################'
}
function copy_db(){
    #记住当前路径
    path=`pwd`

    cd ~/tmp/db
    case "$1" in
	"root") 
		adb pull /data/data/com.android.browser/databases/browser2.db ;
		adb pull /data/data/com.android.browser/databases/downloads.db ;
		adb pull /data/data/com.android.browser/databases/downloads.db-journal ;
		adb pull /data/data/com.android.browser/databases/browser_news.db ;
		adb pull /data/data/com.android.browser/databases/browser_news.db-journal;
		echo "存储路径是:~/tmp/db/";
	;;
	*	)			
		adb pull /data/data/com.android.browser/databases/browser2.db ;
		adb pull /data/data/com.android.browser/databases/downloads.db ;
		adb pull /data/data/com.android.browser/databases/downloads.db-journal ;
		adb pull /data/data/com.android.browser/databases/browser_news.db ;
		adb pull /data/data/com.android.browser/databases/browser_news.db-journal;
		echo "存储路径是:~/tmp/db/";
	;;
	esac

    #重新回到之前的路径
    cd $path
}

#安装apk文件
function make(){
	case "$1" in
	"master") 
		dev git
		gradle assembleProdDebug
		adb push build/outputs/apk/BrowserShell-prod-debug.apk /data/local/tmp/com.android.browser
		adb shell pm install -r "/data/local/tmp/com.android.browser"
		adb shell am start  -n "com.android.browser/com.android.browser.BrowserActivity" -a android.intent.action.MAIN -c android.intent.category.LAUNCHER
	;;
	"3.5") 
		dev 3.5
		gradle assembleDebug
		adb push build/outputs/apk/BrowserShell-prod-debug.apk /data/local/tmp/com.android.browser
		adb shell pm install -r "/data/local/tmp/com.android.browser"
		adb shell am start  -n "com.android.browser/com.android.browser.BrowserActivity" -a android.intent.action.MAIN -c android.intent.category.LAUNCHER
	;;
	"debug")
		adb shell am start -D com.android.browser
	;;
	"install")
		adb push build/outputs/apk/BrowserShell-prod-debug.apk /data/local/tmp/com.android.browser
		adb shell pm install -r "/data/local/tmp/com.android.browser"
		adb shell am start  -n "com.android.browser/com.android.browser.BrowserActivity" -a android.intent.action.MAIN -c android.intent.category.LAUNCHER
	;;
	"clear")
		 adb shell pm clear com.android.browser
	;;
	"start")
		 adb shell pm clear com.android.browser
		 adb shell am start  -n "com.android.browser/com.android.browser.BrowserActivity" -a android.intent.action.MAIN -c android.intent.category.LAUNCHER
	;;
	"cs")
		 adb shell pm clear com.android.browser
		 adb shell am start  -n "com.android.browser/com.android.browser.BrowserActivity" -a android.intent.action.MAIN -c android.intent.category.LAUNCHER
	;;
	##执行 安装 清除数据 启动
	"ics")
		 adb push build/outputs/apk/BrowserShell-debug.apk /data/local/tmp/com.android.browser
		 adb shell pm clear com.android.browser
		 adb shell am start  -n "com.android.browser/com.android.browser.BrowserActivity" -a android.intent.action.MAIN -c android.intent.category.LAUNCHER
	;;
	esac
}
###########################################Android#######################################################