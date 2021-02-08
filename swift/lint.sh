#!/bin/bash

# Usage

# ./lint-swift.sh

# Global Vars
SWIFT_LINT=./Pods/SwiftLint/swiftlint
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG_PATH="$CURRENT_DIR/swiftlint.yml"
GIT_ROOT=$(git rev-parse --show-toplevel)
REPORT_HTML="swiftlint.html"

ARG_1=$1

lintDirectory() {
    cd $1
    count=0

    if [ -e "$1/.gitignore" ]; then
        FILE_PATHS=($(git ls-files -m --full-name --exclude-from=.gitignore | grep ".swift$"))
        DELETED_FILE_PATHS=($(git ls-files -d --full-name --exclude-from=.gitignore | grep ".swift$"))
    else 
        FILE_PATHS=($(git ls-files -m --full-name | grep ".swift$"))
        DELETED_FILE_PATHS=($(git ls-files -d --full-name | grep ".swift$"))
    fi

    # Remove deleted files
    for i in "${DELETED_FILE_PATHS[@]}"; do
        FILE_PATHS=(${FILE_PATHS[@]//*$i*})
    done

##### Check for modified files in unstaged/Staged area #####
    for file_path in $(git diff --name-only --cached --diff-filter=AM | grep ".swift$"); do
        FILE_PATHS=("${FILE_PATHS[@]}" $file_path)
    done

    # Remove files not in Podspec
    if [[ $(pwd) != $GIT_ROOT ]]; then
        for i in "${FILE_PATHS[@]}"; do
            if [[ ! " ${SOURCE_FILES[@]} " =~ " $1/$i " ]]; then
                FILE_PATHS=(${FILE_PATHS[@]//*$i*})
            fi
        done
    fi

    for file_path in "${FILE_PATHS[@]}"; do
        export SCRIPT_INPUT_FILE_$count="$1/$file_path"
        count=$((count + 1))
    done    

    export SCRIPT_INPUT_FILE_COUNT=$count

    if [ "$ARG_1" == "autocorrect" ]; then
        $SWIFT_LINT autocorrect --use-script-input-files --config $CONFIG_PATH  #autocorrects before commit.
    fi
    
    # $SWIFT_LINT lint --use-script-input-files --config $CONFIG_PATH | swizzy
    $SWIFT_LINT lint --use-script-input-files --config $CONFIG_PATH --reporter html > ${REPORT_HTML}
    open ${REPORT_HTML}
}

lintDirectory $GIT_ROOT