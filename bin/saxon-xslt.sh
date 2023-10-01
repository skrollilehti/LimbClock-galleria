#!/bin/bash

# ${1} source file for primary input
# ${2} main stylesheet file
# ${3} output option, e.g. -Tout

# Saxon 11 requires XmlResolver

declare -r SAXON=${PWD}/bin/Saxon-HE-11.4.jar
declare -r XMLRESOLVER=${PWD}/bin/xmlresolver-4.5.0.jar

java --class-path "${SAXON}:${XMLRESOLVER}" \
  net.sf.saxon.Transform \
  -s:${1} \
  -xsl:${2} \
  ${3}
