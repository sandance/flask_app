FROM python:2.7.10
MAINTAINER Nazmul Islam mislam72@gatech.edu
RUN pip install flask
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . .
ENTRYPOINT ["python"]
CMD ["run.py"]

