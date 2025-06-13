#!/bin/bash

usage() {
  cat << EOF >&2
Использование: $0 [ОПЦИИ] <ФАЙЛ>

Опции:
  -w    Вывод числа слов
  -l    Вывод числа строк
  -c    Вывод числа символов

Ввод без опций равен использования всех опций.
EOF
  exit 1
}

w_flag=0
l_flag=0
c_flag=0

while getopts ":wlc" opt; do
  case "$opt" in
    w) w_flag=1 ;;  
    l) l_flag=1 ;;  
    c) c_flag=1 ;;  
    \?) echo "Error: Неверная опция -$OPTARG" >&2; usage ;;  
  esac
done
shift $((OPTIND -1))

if [ $# -ne 1 ]; then
  echo "Error: Остсуствует файл." >&2
  usage
fi
file="$1"
if [ ! -r "$file" ]; then
  echo "Error: Файл '$file' не найден или нечитаем." >&2
  exit 1
fi

if [ $w_flag -eq 0 ] && [ $l_flag -eq 0 ] && [ $c_flag -eq 0 ]; then
  w_flag=1; l_flag=1; c_flag=1
fi

read -r lines words chars _ <<< "$(wc -l -w -m "$file")"

echo "Характеристика файла $file"
[ $l_flag -eq 1 ] && echo "строк: $lines"
[ $w_flag -eq 1 ] && echo "слов: $words"
[ $c_flag -eq 1 ] && echo "символов: $chars"
