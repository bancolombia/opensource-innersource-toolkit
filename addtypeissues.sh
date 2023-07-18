mkdir -p .github/ISSUE_TEMPLATE/
wget -O .github/ISSUE_TEMPLATE/1-reportar-error.md https://raw.githubusercontent.com/bancolombia/action-innersource-toolkit/main/Templates/IssueTemplates/1-reportar-error.md
wget -O .github/ISSUE_TEMPLATE/2-solicitar-nueva-funcionalidad-o-mejora.md https://raw.githubusercontent.com/bancolombia/action-innersource-toolkit/main/Templates/IssueTemplates/2-solicitar-nueva-funcionalidad-o-mejora.md
wget -O .github/ISSUE_TEMPLATE/3-documentacion.md https://raw.githubusercontent.com/bancolombia/action-innersource-toolkit/main/Templates/IssueTemplates/3-documentacion.md
wget -O .github/ISSUE_TEMPLATE/config.yml https://raw.githubusercontent.com/bancolombia/action-innersource-toolkit/main/Templates/IssueTemplates/config.yml
git config user.name bot-bancolombia-toolkit
git config user.email oficina_open_source@bancolombia.com.co
git add .
git commit -m "Changues bot action toolkit innersource"
git push