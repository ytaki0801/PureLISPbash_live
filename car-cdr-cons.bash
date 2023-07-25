car () { echo ${1%% *}; }
cdr () { echo ${1#* }; }
cons () { echo "${1} ${2}"; }

# (a (x y z) c)
L[0]="a 1 c"
L[1]="x y z"

R="$(cdr "${L[$(car "$(cdr "${L[0]}")")]}")"

echo ${R}

