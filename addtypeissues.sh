mkdir -p .github/ISSUE_TEMPLATE/
wget -O .github/ISSUE_TEMPLATE/1-reportar-error.md https://raw.githubusercontent.com/bancolombia/action-innersource-toolkit/main/Templates/IssueTemplates/1-reportar-error.md
git add .
git commit -m "Changues bot action toolkit innersource"
git push