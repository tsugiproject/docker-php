A Set of Docker Images for Tsugi
--------------------------------

These are some docker images for Tsugi.  They live in a hierarchy so you can make
everything from a developer environment on localhost all the way up to an AWS image
that uses Aurora, DynamoDB, and EFS.  Or the nightly servers somewhere in-between.


For now we build three images - the `tsugi_dev:latest` image is a developer instance
with all of the pieces running on one server.

    $ bash build.sh    (Will take some time)

    $ docker images    (make sure they all build)

    REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
    tsugi_dev           latest              116d2bf50c4e        2 minutes ago       674MB
    tsugi_mysql         latest              90f8d82f7070        2 minutes ago       674MB
    tsugi_base          latest              b7199f92080c        3 minutes ago       585MB
    ubuntu              14.04               a35e70164dfb        13 days ago         222MB

    $ docker run -p 8080:80 -e TSUGI_SERVICENAME=TSFUN -e MYSQL_ROOT_PASSWORD=secret -dit tsugi_dev:latest
    73c3700527470dc10f58b3e6b2a8837b22d3d2b6790cb70346b02a8a64d3ce21

Navigate to http://localhost:8080/

To log in and look around, use:

    $ docker exec -it 73c...e21 bash
    root@73c370052747:/var/www/html/tsugi/admin# 

To attach and watch the tail logs:

    $ docker attach 73c...e21
    root@73c370052747:/var/www/html/tsugi/admin# 

To detatch press CTRL-p and CRTL-q

Cleaning up

    docker stop 73c3700527470dc10f58b3e6b2a8837b22d3d2b6790cb70346b02a8a64d3ce21
    docker container prune
    docker image prune

To built one image

    docker build --tag tsugi_base .
