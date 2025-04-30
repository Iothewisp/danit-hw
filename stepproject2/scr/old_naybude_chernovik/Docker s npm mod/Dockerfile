FROM node:14

WORKDIR /app

# Копируем package.json и package-lock.json
COPY package*.json /app/

# Устанавливаем зависимости
RUN npm install

# Копируем весь код
COPY . .

# Указываем порт
EXPOSE 3000

# Запускаем тесты перед стартом (если нужно)
CMD ["npm", "start"]
