LNUM=0

car () {
  if [[ "${1}" =~ ^[0-9]+$ ]]; then
    CARR="${L[${1}]}"
    CARR="${CARR%% *}"
  else
    CARR="${1%% *}"
  fi
}
cdr () {
  if [[ "${1}" =~ ^[0-9]+$ ]]; then
    CDRR="${L[${1}]}"
    CDRR="${CDRR#* }"
  else
    CDRR="${1#* }"
  fi
}
cons () {
  if [ "${2}" = "NULL" ]; then
    L[${LNUM}]="${1} NULL"
    CONSR="${LNUM}"
    LNUM="$((LNUM+1))"
  else
    L[${2}]="${1} ${L[${2}]}"
    CONSR="${2}"
  fi
}
eq () {
  if [ "${1}" = "${2}" ]; then
    EQR="true"
  else
    EQR="false"
  fi
}
pair () {
  if   [[ "${1}" =~ ^[0-9]+$ ]]; then
    PAIRR="true"
  elif [ "${1#* }" = "${1}" ]; then
    PAIRR="false"
  else
    PAIRR="true"
  fi
}

wrls () {
  car "${1}"
  write "${CARR}"
  cdr "${1}"
  if [ "${CDRR}" = "NULL" ]; then
      printf ""
  else
      printf " "
      wrls "${CDRR}"
  fi
}
write () {
  pair "${1}"
  if [ "${PAIRR}" = "false" ]; then
    printf "${1}"
  else
    printf "("
    wrls "${1}"
    printf ")"
  fi
}

# (define x '((a b) c (d e)))
#   (define x1 (cons a (cons b NULL)))
cons "b" "NULL"
cons "a" "${CONSR}"
X1="${CONSR}"
#   (define x2 (cons d (cons e NULL)))
cons "e" "NULL"
cons "d" "${CONSR}"
X2="${CONSR}"
#   (define x (cons x1 (cons 'c (cons x2 NULL))))
cons "${X2}" "NULL"
cons "c" "${CONSR}"
cons "${X1}" "${CONSR}"
X="${CONSR}"
# (write x) => "((a b) c (d e))"
write "${X}"
echo
# (write (car x)) => "(a b)"
car "${X}"
write "${CARR}"
echo
# (write (cdr x)) => "(c (d e))"
cdr "${X}"
write "${CDRR}"
echo

