# Credits: https://github.com/DonSchenck/path-to-kubernetes/tree/master

FROM python:3
ADD server.py /
ADD requirements.txt /
RUN python -m pip install --upgrade pip
RUN pip install -r requirements.txt
EXPOSE 8080
CMD [ "python", "./server.py"]