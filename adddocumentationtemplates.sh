mkdir -p .github/workflows/
wget -O .github/workflows/1-reportar-error.md https://raw.githubusercontent.com/bancolombia/action-innersource-toolkit/main/Templates/IssueTemplates/1-reportar-error.md
wget -O .github/workflows/2-solicitar-nueva-funcionalidad-o-mejora.md https://raw.githubusercontent.com/bancolombia/action-innersource-toolkit/main/Templates/IssueTemplates/2-solicitar-nueva-funcionalidad-o-mejora.md
git config user.name bot-bancolombia-toolkit
git config user.email oficina_open_source@bancolombia.com.co
git add .
git commit -m "Changues bot action toolkit innersource"
git push