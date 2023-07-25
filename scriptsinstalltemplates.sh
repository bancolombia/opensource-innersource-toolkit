#ls
if [[ ${VAR_TEMPLATE_LANGUAGE,,} == *"ES"* ]];
then
    echo "Templates in spanish"
    url_file_labels="https://raw.githubusercontent.com/bancolombia/action-innersource-toolkit/main/Templates/Configurations/labels-ES.txt"
else
    echo "Templates in english"
    url_file_labels="https://raw.githubusercontent.com/bancolombia/action-innersource-toolkit/main/Templates/Configurations/labels-EN.txt"
fi

echo "LA url que tome es $url_file_labels"
#Add labels
curl -s "$url_file_labels" | while IFS= read -r line;
do
   IFS_antiguo=$IFS
   IFS=";" 
   read -ra partes <<< "$line"
   IFS=$IFS_antiguo
   gh label create "${partes[0]}" --description "${partes[1]}" --color "${partes[2]}" -f
   echo "${partes[0]}"
done

#enable Discussions and Wiki
#gh repo edit --enable-discussions --enable-wiki

arrayIssueTemplates = ("1-report-issue","2-request-new-feature","3-documentation")
#Download template issues
for filetemplate in "${arrayIssueTemplates[@]}"
do
    if ! [[ -f ".github/ISSUE_TEMPLATE/$filetemplate.md"]]; then
        echo "El archivo $filetemplate.md existe"
    else
        echo "El archivo $filetemplate.md no existe"
        wget -O .github/ISSUE_TEMPLATE/$filetemplate.md https://raw.githubusercontent.com/bancolombia/action-innersource-toolkit/main/Templates/IssueTemplates/$filetemplate-$VAR_TEMPLATE_LANGUAGE.md
    fi
done

#push changues
git config user.name bot-bancolombia-toolkit
git config user.email oficina_open_source@bancolombia.com.co
git add .
git commit -m "Upload Changues bot action bancolombia toolkit innersource"
git push

#mkdir -p .github/ISSUE_TEMPLATE/
#wget -O .github/ISSUE_TEMPLATE/1-reportar-error.md https://raw.githubusercontent.com/bancolombia/action-innersource-toolkit/main/Templates/IssueTemplates/1-reportar-error.md
#wget -O .github/ISSUE_TEMPLATE/2-solicitar-nueva-funcionalidad-o-mejora.md https://raw.githubusercontent.com/bancolombia/action-innersource-toolkit/main/Templates/IssueTemplates/2-solicitar-nueva-funcionalidad-o-mejora.md
#wget -O .github/ISSUE_TEMPLATE/3-documentacion.md https://raw.githubusercontent.com/bancolombia/action-innersource-toolkit/main/Templates/IssueTemplates/3-documentacion.md
#wget -O .github/ISSUE_TEMPLATE/config.yml https://raw.githubusercontent.com/bancolombia/action-innersource-toolkit/main/Templates/IssueTemplates/config.yml

