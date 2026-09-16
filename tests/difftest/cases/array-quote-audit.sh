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
unset chaff
declare -A chaff
declare -i chaff
chaff=([zero]=1+4 [one]=3+7 four)
declare -p chaff
declare +i chaff
chaff[hello world]=flip
declare -p chaff
unset chaff
declare -Ai chaff=([one]=3+7 [zero]=1+4)
declare -p chaff
x=(prefix$'a\\b'suffix); printf 'ansi-mixed-backslash=<%s>\n' "${x[0]}"
x=($'a\'b c'); printf 'ansi-single-space=<%s> count=%s\n' "${x[0]}" "${#x[@]}"
x=($'a$HOME`echo BAD`'); printf 'ansi-literal-expansion=<%s>\n' "${x[0]}"
x=($''); printf 'ansi-empty=<%s> count=%s\n' "${x[0]}" "${#x[@]}"
x=($'a\tb'); printf 'ansi-tab=<%s> count=%s\n' "${x[0]}" "${#x[@]}"
x=($'*.rs'); printf 'ansi-glob=<%s>\n' "${x[0]}"
x=($'\x11\x14\x17\x1a\x1f'); printf 'ansi-controls=%q\n' "${x[0]}"
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
