#!/usr/bin/bash


#Paths
WORKSPACE="/workspace"
SDPATH="$WORKSPACE/stable-diffusion-webui"
DBEPATH="$SDPATH/extensions/sd_dreambooth_extension"


#check to see if the script is running in bash
if [ -z "$BASH_VERSION" ]
then
    BASH=$(which bash)
    echo "Please run this script with bash"
    echo "Example: $BASH $0"
    exit 1
fi


######## FUNCTIONS ########

#Function to kill relauncher and children
kill_relauncher () {
    echo "Finding and killing relauncher.py and child processes"
    PROCS[0]=`ps -ef |grep relauncher.py | grep -v grep |awk '{ print $2}'`

    #while the PROCS array is not empty
    while [ ${#PROCS[@]} -gt 0 ]
    do
        #get the last element of the array
        PROC=${PROCS[${#PROCS[@]}-1]}

        #if PROC is empty, stop
        if [ -z "$PROC" ]
        then
            echo "relauncher.py not running"
            break
        fi


        #remove the last element of the array
        unset PROCS[${#PROCS[@]}-1]
        #get the child processes of the current process
        CHILDREN=$(ps -o pid --no-headers --ppid $PROC)
        #add the child processes to the PROCS array
        for CHILD in $CHILDREN
        do
            PROCS[${#PROCS[@]}]=$CHILD
        done
        #kill the current process
        echo "Killing process $PROC"
        kill $PROC
    done


}





######## Main ########



#if we get the --killonly or --kill argument, kill relauncher and children and exit
if [ "$1" == "--kill" ] || [ "$1" == "--killonly" ]
then
    kill_relauncher
    exit 0
fi

#Check if we are running the script from the directory in which it resides
if [ ! -f "runpod-dreambooth.sh" ]
then
    echo "Please run this script from the directory in which it resides."
    exit 1
else
    PATCHDIR=$(pwd)
fi







#kill old stable diffusion webui
kill_relauncher

#Get the latest SD
echo "Getting latest stable diffusion webui"
cd $WORKSPACE
#if stable diffusion webui directory exists, delete it
if [ -d "stable-diffusion-webui" ]
then
    cp stable-diffusion-webui/relauncher.py /tmp
    rm -rf stable-diffusion-webui
fi
#get the latest stable diffusion webui
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui
cp /tmp/relauncher.py $SDPATH


#Get the latest Dreambooth extension
echo "Installing latest Dreambooth extension"
cd $SDPATH/extensions
git clone https://github.com/d8ahazard/sd_dreambooth_extension.git


#Apply patches
cd $SDPATH
for f in $PATCHDIR/*.patch
do
    echo "Applying patch $f"
    patch -s -p0 < $f
done

#Install requirements
pip install --upgrade pip
cd $DBEPATH
pip install -r requirements.txt
cd $SDPATH
pip install -r requirements.txt

#install dotenv
 pip install python3-dotenv

#Revert torch
pip uninstall torch
pip3 install torch==1.13.1 torchvision torchaudio --index-url https://download.pytorch.org/whl/cu117
pip install https://huggingface.co/MonsterMMORPG/SECourses/resolve/main/xformers-0.0.19-cp310-cp310-manylinux2014_x86_64.whl


