# runpod-dreambooth-easy

## Summary
This repository is intnded to streamiine the configuration of stable-diffusion-webui and sd_dreambooth_extension on a runpod environment based on the instructional videoby Furkan Gözükara at https://youtu.be/zA4LksIVas8. Configuring the two to work together in the runpod envionrment can be tricky as there a number of dependencies that must be resolved in order to have a fully working application.

## How to use it

1. Establish a running runpod instance using the runpod/stable-diffusion:web-automatic-5.0.0 image
2. Connect to the instance and open a terminal
3. Clone this repo to the /workspace directory
```shell
cd /workspace
git clone https://github.com/rogerb831/runpod-dreambooth-easy.git
```
4. Run the `runpod-dreambooth.sh` script contained
```shell
cd runpod-dreambooth-easy
/usr/bin/bash runpod-dreambooth.sh
```

The script will reconfigure Stable Diffusion WebUI, install the Dreambooth extension, and resolve and install dependencies.

Once complete, launch the webui.
```shell
cd /workspace/stable-diffusion-webui
python relauncher.py
```