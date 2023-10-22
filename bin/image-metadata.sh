#!/bin/bash

set -e
# set -x

# ------------------------------------------------------------------------------

function html_filename {
    local name=${1%.*}.html
    echo "${name#*/}"
}

function first_link {
    echo "<first><a href=\"$(html_filename $1)\">Ensimmäinen</a></first>"
}

function prev_link {
    echo "<prev><a href=\"$(html_filename $1)\">Edellinen</a></prev>"
}

function next_link {
    echo "<next><a href=\"$(html_filename $1)\">Seuraava</a></next>"
}

function last_link {
    echo "<last><a href=\"$(html_filename $1)\">Viimeinen</a></last>"
}

function navigation {
    local -r first=$1
    local -r prev=$2
    local -r curr=$3
    local -r next=$4
    local -r last=$5

    echo "  <navigation>"
    echo "    $(first_link $first)"
    if [[ $prev != "NULL" ]]
    then
        echo "    $(prev_link $prev)"
    fi
    if [[ $next != "NULL" ]]
    then
        echo "    $(next_link $next)"
    fi
    echo "    $(last_link $last)"
    echo "  </navigation>"
}

# ------------------------------------------------------------------------------

function description {
    local -r description_file=${1%.*}.txt
    if [[ -f ${description_file} ]]
    then
        echo "  <description><![CDATA["
        cat ${description_file}
        echo "]]>"
        echo "  </description>"
    fi
}

# ------------------------------------------------------------------------------

function image {
    echo "  <img src=\"$1\"/>"
}

# ------------------------------------------------------------------------------

function meta {
    local -r first=$1
    local -r prev=$2
    local -r curr=$3
    local -r next=$4
    local -r last=$5

    echo "<meta>"
    image $curr
    description $curr
    navigation $first $prev $curr $next $last
    echo "</meta>"
}

# ------------------------------------------------------------------------------

declare -r input_file=$1; shift

declare first=$1
declare last=${@:(-1)}

declare prev="NULL"
declare curr=$1; shift
declare next=$1; shift

for file in $@
do
    if [[ $curr == $input_file ]]
    then
        meta $first $prev $curr $next $last
        exit 0
    fi

    prev=$curr
    curr=$next
    next=$file
done

if [[ $curr == $input_file ]]
then
    meta $first $prev $curr $next $last
    exit 0
fi

prev=$curr
curr=$next
next="NULL"

if [[ $curr == $input_file ]]
then
    meta $first $prev $curr $next $last
    exit 0
fi
