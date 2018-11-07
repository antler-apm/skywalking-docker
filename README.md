# skywalking-docker
# https://getantler.io/


This is a short guidance on how we build Docker images for SkyWalking(http://skywalking.apache.org/)

Our images intended for Kubernetes, so they stripped off from all config files and contain only binaries.

You will need to change "build.sh" to suit your names and run ./build.sh in the current directory.
What it does:
- builds SkyWalking collector and web-ui from source
- packages both as separate Docker containers
- pushes both containers into Docker Hub



