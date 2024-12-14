FROM python:3.10-slim AS build

WORKDIR /app

COPY requirements.txt .

RUN pip3 install -r requirements.txt --no-cache-dir

COPY . .

FROM python:3.10-alpine

WORKDIR /app

COPY --from=build /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages

ENV PYTHONPATH=/usr/local/lib/python3.10/site-packages

COPY --from=build /app .

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]