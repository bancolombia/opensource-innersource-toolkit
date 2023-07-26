ESvar='ES'
if [[ ${VAR_TEMPLATE_LANGUAGE} == *"$ESvar"* ]];
then
    echo "list labels in spanish"
    url_file_labels="https://raw.githubusercontent.com/bancolombia/action-innersource-toolkit/main/Templates/Configurations/labels-ES.txt"
else
    echo "list labels in english"
    url_file_labels="https://raw.githubusercontent.com/bancolombia/action-innersource-toolkit/main/Templates/Configurations/labels-EN.txt"
fi
#Add labels
curl -s "$url_file_labels" | while IFS= read -r line;
do
   if [[ $line != "" ]];
   then
    IFS_antiguo=$IFS
    IFS=";" 
    read -ra partes <<< "$line"
    IFS=$IFS_antiguo
    gh label create "${partes[0]}" --description "${partes[1]}" --color "${partes[2]}" -f
    echo "${partes[0]}"
   fi
done

#enable Discussions and Wiki
gh repo edit --enable-discussions --enable-wiki --enable-projects=true

#Create project to reviews
REPO_NAME=$(gh repo view $VAR_NAME_REPOSITORY --json name --jq '.name')

PROJECT_NAME=$(gh repo view Backlog/Reviews-$REPO_NAME --json name --jq '.name')

projects=$(gh project list -R $VAR_NAME_REPOSITORY_OWNER)
echo $projects
#gh project create --owner $VAR_NAME_REPOSITORY_OWNER --title "Backlog/Reviews-$REPO_NAME" 
#gh project create --owner $VAR_NAME_REPOSITORY_OWNER --title "Backlog/ToWork-$REPO_NAME" 

gh variable set VAR_PROJECT_NAME_REVIEWERS_ISSUES --body "Backlog/Reviews-$REPO_NAME"
gh variable set VAR_PROJECT_NAME_TO_WORK --body "Backlog/ToWork-$REPO_NAME"
#Download template issues
arrayIssueTemplates=("1-report-issue" "2-request-new-feature" "3-documentation")
mkdir -p .github/ISSUE_TEMPLATE/
for filetemplate in "${arrayIssueTemplates[@]}"
do
    wget -O .github/ISSUE_TEMPLATE/$filetemplate.md https://raw.githubusercontent.com/bancolombia/action-innersource-toolkit/main/Templates/IssueTemplates/$filetemplate-$VAR_TEMPLATE_LANGUAGE.md
done

wget -O .github/ISSUE_TEMPLATE/config.yml https://raw.githubusercontent.com/bancolombia/action-innersource-toolkit/main/Templates/IssueTemplates/config-$VAR_TEMPLATE_LANGUAGE.yml

awk -v texttoreplace="@RepositoryName" -v textnew="$VAR_NAME_REPOSITORY" '{gsub(texttoreplace,textnew)} 1' ".github/ISSUE_TEMPLATE/config.yml" > tempfile && mv tempfile ".github/ISSUE_TEMPLATE/config.yml"

#Download documentation
arrayDocumentationTemplates=("CONTRIBUTING" "README" "GOVERNANCE")
for filetemplate in "${arrayDocumentationTemplates[@]}"
do
    if [[ -f "$filetemplate.md" ]];
    then
        echo "the file $filetemplate.md exist"
    else
        echo "the file $filetemplate.md not exist"
        wget -O $filetemplate.md https://raw.githubusercontent.com/bancolombia/opensource-innersource-toolkit/main/Templates/Documentation/$filetemplate-$VAR_TEMPLATE_LANGUAGE.md
    fi
done

wget -O Roles-$VAR_TEMPLATE_LANGUAGE.png https://raw.githubusercontent.com/bancolombia/opensource-innersource-toolkit/main/Templates/Documentation/Roles-$VAR_TEMPLATE_LANGUAGE.png

#download automations workflow
mkdir -p .github/workflows/
wget -O .github/workflows/Handler-Comment-Issues.yml https://raw.githubusercontent.com/bancolombia/action-innersource-toolkit/main/Templates/WorkflowTemplates/Handler-Comment-Issues-$VAR_TEMPLATE_LANGUAGE.yml
wget -O .github/workflows/Handler-Issue-Creation.yml https://raw.githubusercontent.com/bancolombia/action-innersource-toolkit/main/Templates/WorkflowTemplates/Handler-Issue-Creation-$VAR_TEMPLATE_LANGUAGE.yml



gh variable set VAR_USERS_REVIEWERS_ISSUES --body "$VAR_USERS_REVIEWERS"

#push changues
git config user.name bot-bancolombia-toolkit
git config user.email oficina_open_source@bancolombia.com.co
git add .
git commit -m "Upload Changues bot action bancolombia toolkit innersource"
git push

