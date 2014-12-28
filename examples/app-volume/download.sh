#!/bin/bash
[[ -z "${_FOLDER}" ]] && _FOLDER=webapps
[[ -z "${_SUFFIX}" ]] && _SUFFIX=war
while read LINE; do
  if [ -n "$LINE}" ]; then
    NAME=$(echo ${LINE} | awk '{ print $1}')
    URL=$(echo ${LINE} | awk '{print $2}')
    curl -fs ${URL} -o ${_FOLDER}/${NAME}.${_SUFFIX}
    if [ ! $? -eq 0 ]; then
      echo "ERROR: can't download ${URL}"
    fi
  fi
done
