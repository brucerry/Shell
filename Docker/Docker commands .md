#### List images
```
docker images
```

#### List containers
```
docker ps -a
```

#### Pull image
```
docker pull brucerry/{image_name}
```

#### Push image
```
docker tag image_name brucerry/{image_name}
docker login
docker push brucerry/{image_name}
```

#### Commit existing container along with changes, and Run new container with new mount
```
docker commit {container_name} {new_image_name}
docker run -it --name {new_container_name} -v {local/path/}:{/home/example/path} {new_image_name}
```

#### Execute container bash
```
docker exec -it {container_name} bash
```

#### Example Commands
```
docker login
docker commit ubt14.04 ubt14.04
docker tag ubt14.04 brucerry/ubt14.04
docker push brucerry/ubt14.04
docker commit ubt16.04 ubt16.04
docker tag ubt16.04 brucerry/ubt16.04
docker push brucerry/ubt16.04
docker commit ubt18.04 ubt18.04
docker tag ubt18.04 brucerry/ubt18.04
docker push brucerry/ubt18.04
docker commit ubt22.04_airoha ubt22.04_airoha
docker tag ubt22.04_airoha brucerry/ubt22.04_airoha
docker push brucerry/ubt22.04_airoha
docker commit ubt22.04_qsdk ubt22.04_qsdk
docker tag ubt22.04_qsdk brucerry/ubt22.04_qsdk
docker push brucerry/ubt22.04_qsdk
docker commit ubt24.04_bpi ubt24.04_bpi
docker tag ubt24.04_bpi brucerry/ubt24.04_bpi
docker push brucerry/ubt24.04_bpi
```
