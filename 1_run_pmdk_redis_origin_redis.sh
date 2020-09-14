workload="sw"

memory=origin
memory_p=pmdk

th="1 5 10 15 20"
num=0
max=1

ops=100000

client=50

data=1024
add="result_pmdk_origin_200318"

master=9100
master_p=9200

mkdir $add 

for me in $memory; do
	num=0
	while [[ $num -lt $max ]]; do
		for wo in $workload; do
				fname=no_slave_thread_"$th"_"$me"_"$wo"_"$num".txt

				if [[ $wo == "sw" ]] ; then
					../origin-redis/failover/"$me".sh
				fi
				sleep 10s

				echo "-------------------------------------doing $wk load------------------------------------------------"
				case $wo in
					sr) ./memtier_benchmark -p $master -t $th --ratio=0:100 -d $data -c $client -n $ops > "$add"/"$fname" ;;
					sw) ./memtier_benchmark -p $master -t $th --ratio=100:0 -d $data -c $client -n $ops > "$add"/"$fname" ;;
				esac
				echo "-------------------------------------doing $wk load------------------------------------------------"
		done
		num=$((num+1))
	done
done

for me in $memory_p; do
    num=0
    while [[ $num -lt $max ]]; do
        for wo in $workload; do
                fname=no_slave_thread_"$th"_"$me"_"$wo"_"$num".txt

                if [[ $wo == "sw" ]] ; then
                    ../pmdk-redis/failover/"$me".sh
                fi  
                sleep 10s 

                echo "-------------------------------------doing $wk load------------------------------------------------"
                case $wo in
                    sr) ./memtier_benchmark -p $master_p -t $th --ratio=0:100 -d $data -c $client -n $ops > "$add"/"$fname" ;;
                    sw) ./memtier_benchmark -p $master_p -t $th --ratio=100:0 -d $data -c $client -n $ops > "$add"/"$fname" ;;
                esac    
                echo "-------------------------------------doing $wk load------------------------------------------------"
        done        
        num=$((num+1))
    done    
done 
