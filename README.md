This is a very simple personal website with hand-rolled HTML and CSS. It is hosted on a raspberry pi with Portainer and served using Nginx.

To build the Docker container:
```bash
docker build -t personal-site .
```

To run the Docker container on port 3000:
```bash
docker run -d -p 3000:80 personal-site
```
