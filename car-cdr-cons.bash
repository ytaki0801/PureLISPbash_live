car () { echo ${1%% *}; }
cdr () { echo ${1#* }; }
cons () { echo "${1} ${2}"; }

L0="a 1 c"
L1="x y z"

R=$(eval echo \${L$(car "$(cdr "${L0}")")})

echo ${L0}
echo ${R}
echo $(cdr "${R}")

