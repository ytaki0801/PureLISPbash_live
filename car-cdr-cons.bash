LNUM=0

car () {
  CARR=${1%% *}
  if [[ ${CARR} =~ ^[0-9]+$ ]]; then
    CARR="${L[${CARR}]}"
    CARR="${CARR%% *}"
  fi
}
cdr () {
  CDRR="${L[${1}]}"
  CDRR="${CDRR#* }"
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

# (cons 'z (cons 'y (cons 'x '()))) => (z y x)
cons "x" "NULL"
cons "y" "${CONSR}"
cons "z" "${CONSR}"
# (cons '(z y x) (cons 'a '())) => ((z y x) a)
R="${CONSR}"
cons "a" "NULL"
cons "$R" "${CONSR}"
# (car (cdr '((z y x) a))) => a
cdr "${CONSR}"
car "${CDRR}"
echo "${CARR}"

