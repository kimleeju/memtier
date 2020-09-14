workload="sw sr"
#workload="sr"
memory="dram hybrid nvm"
thread="1 5 10 15 20"
#thread="1"
num=0
max=1
ops=100000
data=1024
client=1

#maxkey=256
#minkey=256

add="result_get_memtier_200320"

master=7000
cluster_master=7100

mkdir $add 

for me in $memory; do
	for th in $thread; do
		num=0
		while [[ $num -lt $max ]]; do
			for wo in $workload; do
				fname=thread_"$th"_"$me"_"$wo"_"$num".txt
				if [[ $wo == "sw" ]] ; then
					/home/oslab/pmem-redis-master/failover/$me.sh
				fi
				sleep 10s	

				echo "-------------------------------------doing $wk load------------------------------------------------"
				case $wo in
					sr) ./memtier_benchmark -p $master -t $th --ratio=0:100 -d $data -c $client -n $ops > "$add"/"$fname" ;;
					sw) ./memtier_benchmark -p $master -t $th --ratio=100:0 -d $data -c $client -n $ops > "$add"/"$fname" ;;
				esac
				echo "-------------------------------------doing $wk load------------------------------------------------"
#sleep 1s
			done
			num=$((num+1))
		done
	done
done

for me in $memory; do
	for th in $thread; do
    	num=0
		while [[ $num -lt $max ]]; do
        	for wo in $workload; do
                fname=cluster_mode_thread_"$th"_"$me"_"$wo"_"$num".txt
                if [[ $wo == "sw" ]] ; then
					/home/oslab/pmem-redis-master/cluster/$me/0_run.sh
				fi
				sleep 10s   

                echo "-------------------------------------doing $wk load------------------------------------------------"
                case $wo in
                    sr) ./memtier_benchmark -p $cluster_master -t $th --ratio=0:100 --cluster-mode -c $client -d $data -n $ops > "$add"/"$fname" ;;
                    sw) ./memtier_benchmark -p $cluster_master -t $th --ratio=100:0 --cluster-mode -c $client -d $data -n $ops > "$add"/"$fname" ;;
                esac
                echo "-------------------------------------doing $wk load------------------------------------------------"
        	done
        num=$((num+1))
    	done
	done
done	



#smix) ./memtier_benchmark -p $master -t $th --randomize -d $data -n $ops --key-minimum=$minkey --key-maximum=$maxkey > "$add"/"$fname" ;;
#rmix) ./memtier_benchmark -p $master -t $th  -n $ops -d $data --key-minimum=$minkey --key-maximum=$maxkey > "$add"/"$fname" ;;
