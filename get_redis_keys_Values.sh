SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
rediskeys_output_path="${SCRIPTPATH}/rediskeys_output"

if [[ $# != 1 ]]; then
#	echo "Please enter Redist key name. Example"
#	echo "$0 blm_header"
#	echo "$0 all"
#        exit 1
## default get all keys
	search_key='*'
elif [ {$1^^} == "ALL" ]
then
   search_key='*'
else
   search_key=$1
fi
#echo $search_key
if [ ! -d "$rediskeys_output_path" ]
then
    echo "Directory $rediskeys_output_path DOES NOT exists. creating one..."
    mkdir "$rediskeys_output_path"
#    exit 9999 # die with error code 9999
#else
	#rm -rf "$rediskeys_output_path"
fi
echo "Getting key=$search_key...."
echo "Preparing individual files and will be placed in $rediskeys_output_path ...."
for key in $(redis-cli -p 6379 keys "$search_key")   
	do echo "Key : '$key'" 
	redis-cli -p 6379 GET $key > "$rediskeys_output_path/$key.txt"
done
echo "Files are placed in $rediskeys_output_path folder"
