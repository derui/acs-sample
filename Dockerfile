FROM python:3.5.2-alpine

ARG project_dir=/web/hello/

ADD requirements.txt $project_dir
ADD hello.py $project_dir

WORKDIR $project_dir
RUN pip install -r requirements.txt

# Expose PORT 
EXPOSE     80

CMD python hello.py