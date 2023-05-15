
  

# runpod-dreambooth-easy

  
  ## Versions

| Branch | Video | Video Title|
|--|--|--|
| [Main](https://github.com/rogerb831/runpod-dreambooth-easy) | N/A | This is the latest versions of all components (may not work)
|[A4LksIVas8](https://github.com/rogerb831/runpod-dreambooth-easy/tree/A4LksIVas8) |https://youtu.be/zA4LksIVas8 |RunPod Fix For DreamBooth & xFormers - How To Use Automatic1111 Web UI Stable Diffusion on RunPod |
  

## Summary
This repository is intended to streamline the configuration of stable-diffusion-webui and sd_dreambooth_extension on a runpod environment. These tools are evolving quite quickly, and as a result:
1. The GUI changes frequently. The location of options, and the interfaces change frequently.
2. Versioning changes rapidly, making it easy to have broken requirements and dependancies, and leaving a non-functional environment

This tool is designed to enable you to quickly reproduce the exact versions use in the instructional videos provided by Furkan Gözükara on his [SECourses YouTube channel](https://www.youtube.com/@SECourses).

Different branches of this repository are targeted at different video. Below is the latest index of branches and their related videos.  
  
## How to use it

1. Establish a running runpod instance using the latest runpod/stable-diffusion:web-automatic-* image
2. Connect to the instance and open a terminal
3. Clone this repo to the /workspace directory
```shell
cd  /workspace
git clone --branch A4LksIVas8 https://github.com/rogerb831/runpod-dreambooth-easy.git
```
4. Run the `runpod-dreambooth.sh` script contained
```shell
cd  runpod-dreambooth-easy
/usr/bin/bash runpod-dreambooth.sh
```

The script will reconfigure Stable Diffusion WebUI, install the Dreambooth extension, and resolve and install dependencies.
Once complete, launch the webui.
```shell
cd  /workspace/stable-diffusion-webui
python relauncher.py
```