# Run project
`make init`

### Prepare to production
```steps
# Set login and password
make password

# build images
make build

# change data to correct
HOST=0.0.0.0 PORT=0 HTPASSWD_FILE=htpasswd BUILD_NUMBER=1 make deploy
```

## Check repository data:
[Docker docs API v2 docs](https://docs.docker.com/registry/spec/api/)

### Local develop login data:
```login
repository  # login
password    # password
```

###### Local links:
[/v2](http://localhost:5000/v2) \
[/v2/_catalog](http://localhost:5000/v2/_catalog) images catalog. \
[/v2/image_name/tags/list](http://localhost:5000/v2/auction-gateway/tags/list) tags.
