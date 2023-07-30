car () {
  CARR=${1%% *};
  if [[ ${CARR} =~ ^[0-9]+$ ]]; then
    echo ${L[${CARR}]}
  else
    echo ${CARR}
  fi
}
cdr () { echo ${1#* }; }
cons () { echo "${1} ${2}"; }

# (a (x y z) c)
L[0]="a 1 c NULL"
L[1]="x y z NULL"

# (car (cdr (car (cdr '(a (x y z) c))))) => y
#R="${L[0]}"
#R="$(cdr "${R}")"
#R="$(car "${R}")"
#R="$(cdr "${R}")"
#R="$(car "${R}")"
#echo ${R}

# (cons 'h (car (cdr '(a (x y z) c))))
R="${L[0]}"
R="$(cdr "${R}")"
R="$(car "${R}")"
R="$(cons "h" "${R}")"
echo ${R}

