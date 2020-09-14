prev=$1
after=$2
find . -name "*$prev*" | sed -e 'p' -e "s/$prev/$after/g" | xargs -n 2 mv 
