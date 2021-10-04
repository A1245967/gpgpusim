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
   ```

   You can check the image information by the command  `docker images` after you pull the image.

   

2. create a container to run gpgpusim

   The following command is the simplest way to create the container.

   ```bash
   $ docker run -it --name container_name gpgpusim bash
   ```

   Note: The container will record each command and the changes of the environment. Therefore, the container size will become larger. We recommend to mount a folder to host and remove the container while exiting the container.

   ```bash
   $ docker run -it --name container_name --rm -v your_folder_in_host:/root gpgpusim bash
   ```

   This command will let your host folder become the *$HOME* for root in the container. You can put your project in there for easier access between host and container.

   

3. put the cuda example into the container

   You can put the example code at the folder where you mount the container. Besides, you can push/pull your code by git.

   

4. compile the cuda code by **nvcc**

   ```bash
   $ cd cuda-example/
   $ nvcc --cudart shared -o vecadd vecadd.cu
   ```

   Note: You need to add flag ***--cudart shared***  if you use the gpgpusim as the simulator.  

5. move the execution file to the config folder and run the program

   ```bash
   $ mv vecadd tested-cfgs/SM7_TITANV
   $ cd tested-cfgs/SM7_TITANV
   $ ./vecadd
   ```

   
