This is a very simple personal website with hand-rolled HTML and CSS. It is hosted on a raspberry pi with Portainer and served using Nginx.

To build the Docker container:
```bash
docker build -t personal-site .
```

Development:
To run the Docker container on port 3030:
```bash
docker run -p 80:80 -v "$(pwd)/site:/usr/share/nginx/html" --name personal-site personal-site
```

Production:
To run the Docker container on port 3030:
```bash
docker run -d -p 3030:80 personal-site
```
