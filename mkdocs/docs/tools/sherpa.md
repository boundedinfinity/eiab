List containers

```
http $SHERPA_ADDR/containers/json
```

List container names

```
http $SHERPA_ADDR/containers/json | jq '.[].Names[0]'
```

Get ID from image name

```
http $SHERPA_ADDR/containers/json | jq -r '.[] | select(.Image | contains("image-name")) | .Id'
```
