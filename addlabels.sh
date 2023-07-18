ls
url_file_labels="https://raw.githubusercontent.com/bancolombia/action-innersource-toolkit/main/Configurations/labels.txt"
curl -s "$url_file_labels" | while IFS= read -r line;
do
   IFS_antiguo=$IFS
   IFS=";" 
   read -ra partes <<< "$line"
   IFS=$IFS_antiguo
   gh label create "${partes[0]}" --description "${partes[1]}" --color "${partes[2]}" -f
   echo "${partes[0]}"
done
