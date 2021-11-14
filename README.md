# gpgpusim

The image is created from nvidia/cuda:11.0.3-cudnn8-devel-ubuntu18.04

### software information

* Ubuntu 18.04
* cuda 11.0.3 

* cudnn 8

* gpgpusim
  * link: https://github.com/gpgpu-sim/gpgpu-sim_distribution
  * commit: 90ec3399763d7c8512cfe7dc193473086c38ca38
  * location: /opt/gpgpu-sim_distribution

## Usage 

1. pull the image to the local machine

   ```bash
   $ docker pull a1245967/gpgpusim
   $ docker tag a1245967/gpgpusim gpgpusim
   ```

   You can check the image information by the command  `docker images` after you pull the image.

   

2. create a container to run gpgpusim

   The following command is the simplest way to create the container.

   ```bash
   $ docker run -it --name container_name gpgpusim bash
   ```



3. put the cuda example into the container

   You can put the example code at the folder where you mount the container. For example, you can use git to pull your code at *$HOME* path.
   
   ```bash
   $ cd /root
   $ git clone https://github.com/A1245967/gpgpusim.git
   ```
   

4. compile the cuda code by **nvcc**

   ```bash
   $ cd cuda-example/
   $ nvcc --cudart shared -o vecadd vecadd.cu -gencode arch=compute_75,code=compute_75
   ```

   Note: You need to add flag ***--cudart shared***  if you use the gpgpusim as the simulator.  
   The number 75 refers to the SM version. You would need to set it based on the GPGPU-Sim config `-gpgpu-ptx-force-max-capability` you use.
   
5. move the execution file to the config folder and run the program

   ```bash
   $ mv vecadd ../gpu-configs/SM75_RTX2060
   $ cd ../gpu-configs/SM75_RTX2060
   $ ./vecadd
   ```

   
