ARG FROM_IMAGE_NAME=nvcr.io/nvidia/pytorch:19.09-py3
FROM ${FROM_IMAGE_NAME}

# Set working directory
WORKDIR /workspace

ENV PYTHONPATH "${PYTHONPATH}:/workspace"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y python3-tk python-pip git tmux htop tree

# install apex
RUN git clone https://github.com/NVIDIA/apex.git \
 && cd apex \
 && python setup.py install --cuda_ext --cpp_ext


# Install Python dependencies
RUN pip install --upgrade --no-cache-dir pip \
 && pip install --no-cache-dir \
      mlperf-compliance==0.0.10 \
      opencv-python==3.4.1.15 \
      yacs

RUN python3 -m pip install --no-cache-dir \
	Cython==0.28.4 \
 	scikit-image==0.15.0 \
	pycocotools==2.0.0

# install pycocotools
#RUN git clone https://github.com/cocodataset/cocoapi.git \
# && cd cocoapi/PythonAPI \
# && python setup.py build_ext install


