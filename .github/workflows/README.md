# GITHUB ACTIONS WORKFLOWS

## PULL REQUEST -> Linting (flake8 + pyllint) / Unittests (pytest) / Notify.
`pr_test_and_notify.yml` is automatically triggered whenever a `pull request`
against the `master branch` is in one of the following states:
- `opened`
- `synchronize`
- `reopened`
- `ready_for_review`

## CREATE RELEASE (auto)
`release.yml` is automatically triggered whenver a `pull request` is `merged`. This process parses all commits and uses them to determine whether the release is a major, mimor or patch.  It appends all commits to CHANGELOG.md creates a new release tag then pushes the new release and CHANGELOG to the pjPyTools Github repository.

### DEPENDENCIES
- Semantic Versioning methodology
    -> https://semver.org/
- python-semantic-release
    -> https://python-semantic-release.readthedocs.io/
- Conventional Commits
    -> https://www.conventionalcommits.org

### REQUIREMENTS
#### Commit Messages
Utilizes Conventional Commit specification to determine the next release tag.

Therefore the commit message should be structured as follows:
```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]

```

##### Patch Tags (subject)
 - `build`
 - `chore`
 - `ci`
 - `docs`
 - `fix`
 - `perf`
 - `style`

##### Minor Tags (subject)
- `feat`
- `refactor`

##### Major (body/footer)
- `BREAKING CHANGE`

#### Github - Personal Access Token (PAT)
Ref. https://stackoverflow.com/a/75116350

Create a Fine-grained personal access token (aka «PAT») with the least
necessary privileges to commit changes to your repo:
- Create a fine grained PAT with these steps
    -> https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token#creating-a-fine-grained-personal-access-token
- Under Repository Access select Only select repositories and select the repo
that you want to work with (authenticated pulls, commits, pushes etc.)
- Under Permissions choose Repository permissions and set only Contents to
Access level -> Read and write.
- Finally, add the PAT with context secrets to your GitHub
workflow/action e.g.:
```
runs-on: ubuntu-latest
steps:
  - uses: actions/checkout@v3
    with:
      token: ${{ secrets.NAME_OF_YOUR_PAT }}
```

### CONFIGURATION
`release.yml` configuration is set via the `pyproject.toml` in the root
directory of this project.

### ADDITIONAL INFO
- https://www.youtube.com/watch?v=41WWOaaXW1M
- https://www.youtube.com/watch?v=mxPfbwJ0FiU
