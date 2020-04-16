
if [ ! -f "ami-env.sh" ] ;
then
    echo "Missing ami-env.sh - copy and edit"
    echo "cp ami-env-dist.sh ami-env.sh"
    exit
fi

bash ami/startup.sh base
bash ami/startup.sh mysql
bash ami/startup.sh dev
