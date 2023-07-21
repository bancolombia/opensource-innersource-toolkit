mkdir -p .github/workflows/
wget -O .github/workflows/Handler-Comment-Issues.yml https://raw.githubusercontent.com/bancolombia/action-innersource-toolkit/main/Templates/WorkflowTemplates/Handler-Comment-Issues.yml
wget -O .github/workflows/Handler-Issue-Creation.yml https://raw.githubusercontent.com/bancolombia/action-innersource-toolkit/main/Templates/WorkflowTemplates/Handler-Issue-Creation.yml

gh variable set VAR_USERS_REVIEWERS_ISSUES --body "$USERS_REVIEWERS"