# DominoObjectDetection

To create my object detection model, i used following tutorials from Gilbert Tanner:

1. [https://gilberttanner.com/blog/installing-the-tensorflow-object-detection-api](Install)
2. [https://gilberttanner.com/blog/live-object-detection](Run object detector)
3. [https://gilberttanner.com/blog/creating-your-own-objectdetector](Creating your own object detector)

Thanks for the nice tutorials.

Firstly, I run in issues with running the training using Tensorflow 2 such

`AttributeError: module 'tensorflow' has no attribute 'contrib'`

Therefore I created a Dockerfile to install and run the training procedure.

First, create the dockerimage using:

`docker build -t tensorflow-git .`

Then run bash into docker using:

`docker run -it -v C:\Users\Viktor\Desktop\Domino_App\DeepLearning\DominoObjectDetection:/my_git_path tensorflow-git bash`

change directory:

`cd /my_git_path/`

run the training procedure:

`python model_main.py --logtostderr --model_dir=training/ --pipeline_config_path=training/faster_rcnn_inception_v2_pets.config`
