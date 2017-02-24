#!/bin/bash

condition="${1}"
run="${2}"
action="${3:-focus}"

echo condition="${condition}"
echo run="${run}"
echo action=${action}

if [[ ! $(i3-msg "${condition}" "${action}") = '[{"success":true}]' ]]; then
    if [[ ${run} != "" ]]; then
        i3-msg "exec ${run}"
    fi
fi
