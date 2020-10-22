## DockerFile for nekoserver

Simple yet functional dockerfile file to create nekoserver image with pre-configured apache so you can test your application / web page quickly.

- You can configure an external volume, which will be used for your application / web page or
- Copy the files into the container

## What is this image for?

- To test applications, websites or the like and related, using the neko server as a backend;
- If you have installation restrictions for a server of this type;
- If you don't want to install neko or hash on your machine, but still have applications that use neko and need to perform tests


### How to use
1. clone or download the dockerfile file
2. Access the folder or location where this file is located
3. on the command line do:
`sudo docker build -t [image name] .`
4. The image will be built. Next to create the container, do:
 + with access to a volume on the host:
 `sudo docker run -it -p [desirable port on host]:80 --name [name of container] -v [location for your application contained on host]:/var/www/html/[image created above]`
 + no volume on the host:
 `sudo docker run -it -p [desirable port on host]:80 --name [name of container] [image created above]`

 > You should copy your installation files to the /var/www/html/ folder if you are not using a volume on the host

In a few minutes the container will be initialized and you can test your neko application

### Comments
 - You can change the contents of the dockerfile. For example in HAXE_VERSION or NEKO_VERSION you can choose a previous version number
