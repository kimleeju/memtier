memory="dram daof nvm"
workload="sw sr"
client="1 50"

dir=$1

cd $dir

unset GREP_OPTIONS
for cli in $client; do
	for me in $memory; do
		for wo in $workload; do
			echo "$me"_"$wo"_client_"$cli"
			grep "Throughput" *"$me"_* | grep "client_$cli" | grep "$wo" | awk '{print $4}'| sort -rn | head -n 2 | tail -n 1
			echo "  "
		done
	done
done
