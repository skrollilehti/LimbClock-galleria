#!/bin/bash

# ${1} source file for primary input
# ${2} main stylesheet file
# ${3} output option, e.g. -Tout

export LD_LIBRARY_PATH=${PWD}/bin

${PWD}/bin/Transform \
  -s:${1} \
  -xsl:${2} \
  ${3}
