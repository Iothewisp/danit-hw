FROM python:3.11-slim

WORKDIR /app

RUN ls -la /app

# Установка зависимостей
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем всё приложение
COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
