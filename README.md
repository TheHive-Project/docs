# docs

The documentation uses mkdocs to render the content.

```
# Install the requirements first
pip install -r requirements.txt

# Start the mkdocs server in development mode
mkdocs serve
```

Alternatively you can use a docker container:

```
docker build . -t thehive-docs
docker run -it --rm -p 8000:8000 -v $PWD:/docs thehive-docs
```
