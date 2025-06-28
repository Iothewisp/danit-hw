#!/bin/bash
# Обновление и установка зависимостей
apt update -y
apt install -y openjdk-11-jdk gnupg curl

# Добавление ключа и репозитория Jenkins
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Установка Jenkins
apt update -y
apt install -y jenkins

# Запуск и автозагрузка
systemctl enable jenkins
systemctl start jenkins
