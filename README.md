
    cd base
    docker build --tag tsugi_base .

    docker run -p 8080:80 -e BOB=42 -dit d3e979c9935d

    docker attach 8466e6ed71a1

detatch CTRL-P CTRL-Q


