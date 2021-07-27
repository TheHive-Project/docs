# docs

The documentation uses mkdocs to render the content.

## Test changes

```bash
# Install the requirements first
pip install -r requirements.txt

# Start the mkdocs server in development mode
mkdocs serve
```

Alternatively you can use a docker container:

```bash
docker build . -t thehive-docs
docker run -it --rm -p 8000:8000 -v $PWD:/docs thehive-docs
```

## Deploy

After commiting changes in `main`branch, deploy the documentation by running this command: 

```bash
mkdocs gh-deploy --remote-branch gh-pages
```
