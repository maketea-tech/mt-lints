# https://juejin.cn/post/6844903853775650830#heading-8
# https://github.com/hdw09/CIHexoBlog/blob/master/source/_posts/OClint%E5%AD%A6%E4%B9%A0%E7%AC%94%E8%AE%B0.md
# https://github.com/hdw09/CIHexoBlog/blob/master/source/_posts/OCLint-%E8%87%AA%E5%AE%9A%E4%B9%89%E8%A7%84%E5%88%99101.md

#!/bin/bash

# Global Vars
COLOR_ERR="\033[1;31m"    #出错提示
COLOR_SUCC="\033[0;32m"  #成功提示
COLOR_QS="\033[1;37m"  #问题颜色
COLOR_AW="\033[0;37m"  #答案提示
COLOR_END="\033[1;34m"     #颜色结束符

SCHEME="LLH"  # scheme名字
WORKSPACE="LLH.xcworkspace" # workspace名字
REPORT_HTML="oclint.html"
COMPILE_DATA="compile_commands.json"

function oclintForProject () {
    if which xcodebuild 2>/dev/null; then
        cd .
    else
        echo 'To install xcodebuild'
        return -1
    fi

    if which oclint 2>/dev/null; then
        cd .
    else
        brew tap oclint/formulae
        brew install oclint
    fi

    if which xcpretty 2>/dev/null; then
        cd .
    else
        sudo gem install xcpretty
    fi

    export LANG="zh_CN.UTF-8"
    export LC_COLLATE="zh_CN.UTF-8"
    export LC_CTYPE="zh_CN.UTF-8"
    export LC_MESSAGES="zh_CN.UTF-8"
    export LC_MONETARY="zh_CN.UTF-8"
    export LC_NUMERIC="zh_CN.UTF-8"
    export LC_TIME="zh_CN.UTF-8"
    export xcpretty=/usr/local/bin/xcpretty # xcpretty 的安装位置可以在终端用 which xcpretty找到

    # 清除上次编译数据
    if [ -d ./derivedData ]; then
        rm -rf ./derivedData
    fi

    # xcodebuild clean
    # xcodebuild -scheme $SCHEME -workspace $WORKSPACE clean
    xcodebuild -target $SCHEME -configuration clean

    # Generating Building Data
    # xcodebuild -scheme $SCHEME -workspace $WORKSPACE -configuration Debugc
    xcodebuild -target $SCHEME -configuration Debug | xcpretty -r json-compilation-database -o $COMPILE_DATA

    if [ -f ./$COMPILE_DATA ]; then
        cd .
    else
        echo -e $COLOR_ERR'Compile data failed'$COLOR_ERR
        return -1
    fi

    # Generating Html
    oclint-json-compilation-database -e Pods -- -report-type html -o $REPORT_HTML \
    -rc LONG_LINE=200 \
    -disable-rule ShortVariableName \
    -disable-rule ObjCAssignIvarOutsideAccessors \
    -disable-rule AssignIvarOutsideAccessors \
    -max-priority-1=100000 \
    -max-priority-2=100000 \
    -max-priority-3=100000

    if [ -f ./$REPORT_HTML ]; then
        rm $COMPILE_DATA
    else 
        echo -e $COLOR_ERR'Analyse failed'$COLOR_ERR
        return -1
    fi
  
    open $REPORT_HTML
}

cd sdk/LLHFramework
oclintForProject
