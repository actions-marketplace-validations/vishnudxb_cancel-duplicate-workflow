# cancel-duplicate-workflow
Cancel a duplicate workflow

## Use-case:

If you are using a single environment for your staging and testing and sometimes you may need to avoid a duplicate deployment of an endpoint, then you can use this action to cancel either the staging or testing build. 

# Usage

See [action.yml](action.yml)

Basic:
```yaml
steps:
- uses: vishnudxb/cancel-duplicate-workflow@v1.0
  with:
    repo: octocat/hello-world
    workflow_id: ${{ github.run_id }}
    access_token: ${{ github.token }}
    branch_name: staging  # The branch which you want to check if any jobs are running!
```

Sample usage in github action job:

For eg: your `test.yaml` is triggered. Before deploy, you want to check if any staging deployment jobs are running. If do, cancel the test build.

```yaml
jobs:
  deploy:
    name: Run deployment for testing
    runs-on: ubuntu-latest
    steps:
    - name: Checkout
      uses: actions/checkout@v2
      with:
        token: ${{ secrets.GITHUB_TOKEN }}

    - uses: vishnudxb/cancel-duplicate-workflow@v1.0
      with:
        repo: octocat/hello-world
        workflow_id: ${{ github.run_id }}
        access_token: ${{ secrets.GITHUB_TOKEN }}
        branch_name: staging

    - run: echo "This is testing deployment"

```

