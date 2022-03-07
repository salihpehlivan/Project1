FROM python:3.8-buster
COPY requirements.txt .
RUN pip install -r requirements.txt
ENV FLASK_APP=app
ENV PORT=5000
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_ENV=development
ENV PATH="/home/myuser/.local/bin:${PATH}"
RUN apt-get update &&\
    /usr/local/bin/python3 -m pip install --upgrade pip &&\
    /usr/local/bin/python3 -m pip install --upgrade setuptools &&\
    adduser myuser
WORKDIR /home/myuser
COPY --chown=myuser:myuser . .
CMD gunicorn -w 4 --bind 0.0.0.0:$PORT "app:create_app()"
