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

    $ docker run -p 8080:80 -p 3306:3306 -e TSUGI_SERVICENAME=TSFUN -dit tsugi_dev:latest
    73c3700527470dc10f58b3e6b2a8837b22d3d2b6790cb70346b02a8a64d3ce21

Navigate to http://localhost:8080/

To log in and look around, use:

    $ docker attach 73c3700527470dc10f58b3e6b2a8837b22d3d2b6790cb70346b02a8a64d3ce21
    (press Enter)
    root@73c370052747:/var/www/html/tsugi/admin# 

Make sure to detatch with `CTRL-P` `CTRL-Q` sequence rather than `CTRL-D`
since that shuts down the container sice `attach` connects to PID 1 (i.e.
not just any shell).  If you attach too quickly you will see the output 
of the ENTRYPOINT script - once it finishes you will get a command line
prompt.

Cleaning up

    docker stop 73c3700527470dc10f58b3e6b2a8837b22d3d2b6790cb70346b02a8a64d3ce21
    docker container prune
    docker image prune


