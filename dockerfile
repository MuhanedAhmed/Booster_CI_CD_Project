FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

RUN apt-get update && apt-get install -y build-essential libpq-dev curl

COPY requirements.txt /app/

RUN pip install --upgrade pip && \
pip install -r requirements.txt

COPY . /app/

RUN  python manage.py makemigrations && \
    python manage.py migrate

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]