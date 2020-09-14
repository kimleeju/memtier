unset GREP_OPTIONS
ops="Sets Gets"
mem="dram nvm"
appendof="aofoff aofon"
threads="10 "
for op in $ops; do
	for th in $threads; do
		for aof in $appendof; do
			for mm in $mem; do
				iops=`grep "$op" *"$th"*"$mm"*"$aof"* | awk '{print $2}' | grep -v "0.0" | sort -n | head -n 5 | tail -n 1`
		
				echo $th $op $mm $aof $iops $ratio
			done
		done
	done

#	echo "hello" | awk '{print("%s %s %f %f\n", '"'$mm'"', '"'$op'"', '"'$iops'"', '"'$iops_bak'"'/'"'$iops'"'}'
	
#grep "$op" *dram*sw* | awk '{print $2}' | sort -n | head -n 5 | tail -n 1
done
