#!/bin/bash
if [ "$1" = "" ]; then
    XPATH=. # ȱʡ�ǵ�ǰĿ¼
else
    XPATH=$1
    if $cygwin; then
        XPATH="$(cygpath -C ANSI -w "$XPATH")";
    fi
fi

explorer $XPATH