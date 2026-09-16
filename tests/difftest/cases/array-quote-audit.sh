#!/usr/bin/env bash
x=($'a"b'); printf 'ansi-double=<%s>\n' "${x[0]}"
x=($'a\'b'); printf 'ansi-single=<%s>\n' "${x[0]}"
x=($'a\\b'); printf 'ansi-backslash=<%s>\n' "${x[0]}"
x=($'a"b c'); printf 'ansi-space=<%s> count=%s\n' "${x[0]}" "${#x[@]}"
x=(prefix$'a"b'suffix); printf 'ansi-mixed=<%s>\n' "${x[0]}"
x=([2]=$'a"b'); printf 'ansi-index=<%s>\n' "${x[2]}"
declare -a x=($'a"b'); printf 'ansi-declare=<%s>\n' "${x[0]}"
declare -A chaff=([one]=10 [zero]=5)
declare -p chaff
declare -i chaff
declare -p chaff
unset chaff
declare -A chaff=(["hello world"]=flip [one]=10 [zero]=5)
declare -p chaff
unset chaff
declare -ai chaff=([2]=10 [0]=5)
declare -p chaff
unset chaff
declare -A chaff
unset empty
chaff[$empty]=bad
printf 'bad-subscript-status=%s\n' "$?"
declare -p chaff
