unset GREP_OPTIONS
ops="Sets Gets"
mem="dram nvm"
aof="aofoff aofon"
threads="10 "
for op in $ops; do
	for th in $threads; do
		for mm in $mem; do
			
		done
	done

#	echo "hello" | awk '{print("%s %s %f %f\n", '"'$mm'"', '"'$op'"', '"'$iops'"', '"'$iops_bak'"'/'"'$iops'"'}'
	
#grep "$op" *dram*sw* | awk '{print $2}' | sort -n | head -n 5 | tail -n 1
done
