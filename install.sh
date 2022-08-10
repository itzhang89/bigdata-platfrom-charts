#!/usr/bin/env bash

# check helm is installed
if ! [ -x "$(command -v helm)" ]; then
  echo 'Error: helm is not installed.' >&2
  exit 1
fi

releaseName=${1:-'my-platform'}
variables="releaseName=$releaseName"
templ=$(cat ./values.yaml.template)
printf "$variables\ncat << EOF\n$templ\nEOF" | bash >./values.yaml

if [ -f ./overwrite-values.yaml ]; then
  helm upgrade --install $releaseName . --debug -f ./overwrite-values.yaml
else
  helm upgrade --install $releaseName . --debug
fi
