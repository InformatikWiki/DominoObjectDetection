FROM "ubuntu:bionic"

RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip
RUN apt-get update && yes | apt-get upgrade

RUN mkdir -p /tensorflow/models

RUN apt-get install -y git python-pip
RUN pip install --upgrade pip

RUN pip install tensorflow==1.14
RUN pip install numpy==1.16.4
RUN pip install --user gast==0.2.2
RUN pip install tensorflow-gpu==1.14

RUN apt-get install -y protobuf-compiler python-pil python-lxml

RUN pip install cython
RUN pip install contextlib2
RUN pip install pillow
RUN pip install lxml
RUN pip install jupyter
RUN pip install matplotlib

RUN git clone https://github.com/tensorflow/models.git /tensorflow/models

WORKDIR /tensorflow/models/research

RUN git clone https://github.com/cocodataset/cocoapi.git
RUN cd cocoapi/PythonAPI && make

RUN protoc object_detection/protos/*.proto --python_out=.

ENV PYTHONPATH=$PYTHONPATH:/tensorflow/models/research
ENV PYTHONPATH=$PYTHONPATH:/tensorflow/models/research/object_detection
ENV PYTHONPATH=$PYTHONPATH:/tensorflow/models/research/slim

RUN python setup.py build
RUN python setup.py install

RUN pip install pathlib
RUN pip install pycocotools
#RUN pip install python-tk

RUN jupyter notebook --generate-config --allow-root
RUN echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /root/.jupyter/jupyter_notebook_config.py

EXPOSE 8888

CMD ["jupyter", "notebook", "--allow-root", "--notebook-dir=/tensorflow/models/research/object_detection", "--ip=0.0.0.0", "--port=8888", "--no-browser"]