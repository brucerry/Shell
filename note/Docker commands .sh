#
# List images
#
docker images

#
# List containers
#
docker ps -a

#
# Pull image
#
docker pull brucerry/image_name

#
# Push image
#
docker tag image_name brucerry/image_name
docker login
docker push brucerry/image_name

#
# Commit existing container along with changes, and Run new container with new mount
#
docker commit container_name new_image_name
docker run -it -v local/path/:/home/example/path new_image_name

#
# Execute container bash
#
docker exec -it container_name bash
