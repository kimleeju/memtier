threads="1 5 10 15 20"
num="0 1 2 3 4"
unset GREP_OPTIONS
for th in $threads; do
	op=$th.txt
	for n in $num; do
			
			grep "SET" thread_"$th"_nvm_sw_"$n".txt | grep "99.99" | tail -n 1 | awk '{print $2}' > $op

	done

	cat $op | sort -nr | head -n 3 | tail -n 1 
done
