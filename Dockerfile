FROM docker.io/python:3.7


WORKDIR /app
COPY . .
RUN git clone --depth 1 https://github.com/tabilab-dip/Turku-neural-parser-pipeline-BPARS.git

WORKDIR /app/Turku-neural-parser-pipeline-BPARS
RUN git submodule update --init --recursive

RUN apt-get update -y && apt-get install wget python3-dev -y

RUN pip3 install wheel
RUN wget --quiet https://download.pytorch.org/whl/cpu/torch-0.4.1-cp37-cp37m-linux_x86_64.whl && pip install torch-0.4.1-cp37-cp37m-linux_x86_64.whl
RUN pip3 install -r requirements-cpu.txt

RUN wget --quiet http://tabilab.cmpe.boun.edu.tr/BOUN-PARS/model_tr_imst_ruled_morphed_pipeline.tgz
RUN tar -xvf model_tr_imst_ruled_morphed_pipeline.tgz

RUN git clone --depth=1 --branch=master https://github.com/tabilab-dip/BOUN-PARS.git bpars
RUN rm -rf ./bpars/.git
RUN mv bpars/* .
RUN rm -rf ./bpars
EXPOSE 5000

# CMD tail -f /dev/null


ENTRYPOINT [ "python" ]
CMD [ "api.py","5000" ]
