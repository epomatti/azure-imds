# Credits: https://github.com/DonSchenck/path-to-kubernetes/tree/master

FROM python:3
ADD server.py /
RUN pip install flask
RUN pip install flask_restful
EXPOSE 8080
CMD [ "python", "./server.py"]