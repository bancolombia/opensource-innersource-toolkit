# Toolkit InnerSource - OpenSource
project type Github Action that provides repositories with the necessary tools and documentation for an innersource work model

## Support 
This project is maintained by the Bancolombia organization and is free to use. You can contribute to this project by reporting issues, suggesting features.

We have communication channels enabled in the official github repository or write to our email oficina_open_source@bancolombia.com.co

## Use as a GitHub Action

1. Create a repository to host this GitHub Action or select an existing repository
1. Create the env values from the sample workflow below (GH_TOKEN, TYPE_REPOSITORY) with your information as repository secrets. More info on creating secrets can be found [here](https://docs.github.com/en/actions/security-guides/encrypted-secrets).
Note: Your GitHub token will need to have read/write access to the repository
1. Copy the below example workflow to your repository and put it in the `.github/workflows/` directory with the file extension `.yml` (ie. `.github/workflows/toolkit.yml`)

### Example workflow with personal token

```yaml
name: Toolkit InnerSource-OpenSource
on: workflow_dispatch
jobs:
  build-repo:
    runs-on: ubuntu-latest
    name: Download tools and templates Innersource-Opensource
    steps:
      - name: Checkout
        uses: actions/checkout@v3
        with:
          token: ${{ secrets.PERSONAL_GITHUB_TOKEN }}
      - id: testToolkit
        uses: bancolombia/opensource-innersource-toolkit@main
        with:
          GH_TOKEN: ${{ secrets.PERSONAL_GITHUB_TOKEN }}
          TYPE_REPOSITORY: 'innersource'
          USERS_REVIEWERS: '@user1 @user2'
          TEMPLATE_LANGUAGE: 'EN'
```
### Example workflow with GitHub App token

```yaml
name: Toolkit InnerSource-OpenSource
on: workflow_dispatch
jobs:
  build-repo:
    runs-on: ubuntu-latest
    name: Download tools and templates Innersource-Opensource
    steps:
      - name: Generate a token
        id: generate_token
        uses: tibdex/github-app-token@v1
        with:
          app_id: ${{ secrets.APP_ID_ADMIN_GITHUB }}
          private_key: ${{ secrets.APP_PRIVATE_KEY_ADMIN_GITHUB }}
      - name: Checkout
        uses: actions/checkout@v3
        with:
          token: ${{ steps.generate_token.outputs.token }}
      - id: testToolkit
        uses: bancolombia/opensource-innersource-toolkit@main
        with:
          GH_TOKEN: ${{ steps.generate_token.outputs.token }}
          TYPE_REPOSITORY: 'innersource'
          USERS_REVIEWERS: '@user1 @user2'
          TEMPLATE_LANGUAGE: 'EN'
```
