# Docker

## List installed images:

```bash
docker ps -a
```

## Running a container

```bash
docker run -it <container>
```

## Running from another terminal

```bash
docker ps -l
docker exec -it <container/name> bash
```

## Copying file from docker to host

```bash
docker cp foo.txt mycontainer:/foo.txt
docker cp mycontainer:/foo.txt foo.txt
```

## Creating a connection between two docker

it is automatically created. So they can ping each other.
If `ifconfig` is not installed, check `/etc/hosts`

## Stop a running docker

```bash
docker stop <container/name>
```

## Delete a docker image

```bash
# check if any instance of the container is here
docker ps -a
# rm any instance by the name (-f to force)
docker rm <container/name>
# then you can delete the image
docker rmi <imageID>
```

## Run a docker container with a mounted/shared folder from host

```bash
docker run -v /Users/ejalaa/Development/ros_ws:/home/documents -it ros
```

# Interesting docker containers

## ROS

http://wiki.ros.org/docker/Tutorials/Docker

## Morse

https://github.com/giodegas/docker-morse
