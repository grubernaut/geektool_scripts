inactivemem=$(top -l 1 | awk '/PhysMem/ {print $6}')
freemem=$(top -l 1 | awk '/PhysMem/ {print $10}')

if [ "$(echo ${inactivemem} | egrep '.*G$')" ]; then
	inactivemem=$(echo ${inactivemem} | cut -d 'G' -f 1)
   let inactivemem=${inactivemem}*1024
else
   inactivemem=$(echo ${inactivemem} | cut -d 'M' -f 1)
fi

if [ "$(echo ${freemem} | egrep '.*G$')" ]; then
	freemem=$(echo ${freemem} | cut -d 'G' -f 1)
   let freemem=${freemem}*1024
else
   freemem=$(echo ${freemem} | cut -d 'M' -f 1)
fi

let freemem=${freemem}+${inactivemem}

freemem=$(echo "scale=2; ${freemem} / 1024" | bc)
uptime=$(uptime | awk '{print $3 " " $4 " " $5 }' | sed -e 's/.$//g')
echo "Uptime: ${uptime}"
echo "RAM Free: ${freemem}G"
