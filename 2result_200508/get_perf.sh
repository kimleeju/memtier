unset GREP_OPTIONS
ops="Sets Gets"
mem="dram nvm"
threads="10 "
append="on off"
for aof in $append; do
	for op in $ops; do
		for th in $threads; do
		iops=0
			for mm in $mem; do
				iops_bak=$iops
				iops=`grep -rn "$op"  thread_"$th"*"$mm"*"$aof"* | awk '{print $2}' | grep -v "0.0" | sort -n | head -n 3 | tail -n 1`
		
				ratio=`echo $iops $iops_bak | awk '{printf("%f\n", $1/$2)}'`
				echo $th $op $mm "aof" $aof $iops $ratio
			done
		done
	done
#	echo "hello" | awk '{print("%s %s %f %f\n", '"'$mm'"', '"'$op'"', '"'$iops'"', '"'$iops_bak'"'/'"'$iops'"'}'
	
#grep "$op" *dram*sw* | awk '{print $2}' | sort -n | head -n 5 | tail -n 1
done
