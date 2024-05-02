#!/usr/bin/env bash
echo $(printf '%s\n' "$1" | sed -e 's/[\/&]/\\&/g')
