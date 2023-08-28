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

# (define x '(a b c)) => x: (a b c)
cons "c" "NULL"
cons "b" "${CONSR}"
cons "a" "${CONSR}"
X="${CONSR}"
# (car x) => a
car "${X}"
echo "${CARR}"
# (car (cdr x)) => b
cdr "${X}"
car "${CDRR}"
echo "${CARR}"
# (define y '(d e f)) => y: (d e f)
cons "f" "NULL"
cons "e" "${CONSR}"
cons "d" "${CONSR}"
Y="${CONSR}"
# (define z (cons x y)) => z: ((a b c) d e f)
cons "${X}" "${Y}"
Z="${CONSR}"
# (car (cdr (car z))) => b
car "${Z}"
cdr "${CARR}"
car "${CDRR}"
echo "${CARR}"
# (car (cdr (cdr z))) => e
cdr "${Z}"
cdr "${CDRR}"
car "${CDRR}"
echo "${CARR}"
# (eq? (car (cdr (car z))) 'b) => true
car "${Z}"
cdr "${CARR}"
car "${CDRR}"
eq "${CARR}" "b"
echo "${EQR}"
# (eq? (car (cdr (car z))) 'a) => false
eq "${CARR}" "a"
echo "${EQR}"
# (pair? (car z)) => true
car "${Z}"
pair "${CARR}"
echo "${PAIRR}"
# (pair? (cdr (car z))) => true
cdr "${CARR}"
pair "${CDRR}"
echo "${PAIRR}"
# (pair? (car (cdr (car z)))) => false
car "${CDRR}"
pair "${CARR}"
echo "${PAIRR}"

