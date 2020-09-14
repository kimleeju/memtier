mem="dram nvm"
workloads="sr sw"
log="aofon aofoff"



n=1
th=1
while [[ $n -le 20 ]]; do
	echo $th
	
	## 
	for mm in $mem; do
		grep -rn "Set" *.txt | grep $mm | grep _"$th"_
	done

	th=$((n*5))
	n=$((n+1))
done
