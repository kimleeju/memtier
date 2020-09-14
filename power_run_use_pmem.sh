workload="sw sr"
cpupower="3400"
threads="1 5 10 15 20"
ops=100000
client=1
mport=7000
data=1024
RDIR="result_thread_200508"
mkdir $RDIR 
memory="dram nvm"
appendonly="on off"
num=0
max=1

for aof in $appendonly; do
	for me in $memory; do
		for cp in $cpupower; do
			cpupower frequency-set -u "$cp"MHz
			for th in $threads; do
    			num=0
    			while [[ $num -lt $max ]]; do
        			for wo in $workload; do
            		    fname=thread_"$th"_"$me"_"$wo"_"$cp"_"$num"_aof"$aof".txt

                		if [[ $wo == "sw" ]] ; then
							if [[ $me == "dram" ]] ; then
								if [[ $aof == "on" ]] ; then
									/home/oslab/pmem-redis-master/failover/no_slave_dram_aofon.sh
								else
									/home/oslab/pmem-redis-master/failover/no_slave_dram.sh
								fi
							else
								if [[ $aof == "on" ]] ; then
									/home/oslab/pmem-redis-master/failover/no_slave_nvm_aofon.sh
								else
									/home/oslab/pmem-redis-master/failover/no_slave_nvm.sh
								fi
             				fi
						fi
						sleep 10s 

                		echo "----------------doing $wo load----------------------------"
                		case $wo in
                    		sr) ./memtier_benchmark -p $mport -t $th --ratio=0:100 -d $data -c $client -n $ops > "$RDIR"/"$fname" ;;
                    		sw) ./memtier_benchmark -p $mport -t $th --ratio=100:0 -d $data -c $client -n $ops > "$RDIR"/"$fname" ;;
               	 		esac
                		echo "----------------doing $wo load----------------------------"
        			done
        		num=$((num+1))
    			done
			done
		done
	done
done


