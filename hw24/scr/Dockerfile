FROM python:3.11-slim
RUN apt-get update && apt-get install -y curl
WORKDIR /app
COPY python-random.py .
####RUN pip install flask (ne treba)
#requerment file
EXPOSE 8082
CMD ["python3", "python-random.py"]
