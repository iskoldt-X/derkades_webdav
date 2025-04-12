# derkades_webdav
A minimal Dockerized WebDAV server using Nginx. Recreatation derkades webdav image.


## Build

```bash
docker build -t my-webdav .
```

## Run
    
```bash
docker run -d -p 8899:8899 -v /your/data:/data \
  -e USERNAME=youruser -e PASSWORD=yourpassword my-webdav
```

