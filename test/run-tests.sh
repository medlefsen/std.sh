cd "$(dirname "$0")"
for t in test-*.sh
do
    echo "$t"
    ./$t
    echo
done
