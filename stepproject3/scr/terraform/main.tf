# ansible-playbook -i inventory.ini playbook.yml     (команда на мастере чтоб запустить плейбук Ansible)



#  sudo cat /var/lib/jenkins/secrets/initialAdminPassword    (суперпароль дженкинса при входе в веб интерфейс)

#sudo apt update
#sudo apt install openjdk-17-jdk -y       на воркере  доустанвоить  надо джаву 

# ----------------------------------------------------------------------------------------------------------------------


# Старому Пайплайну дженкинс оказался нужен докер ок добью ручками

# sudo apt update
# sudo apt install -y docker.io
# sudo usermod -aG docker $USER
# sudo systemctl enable docker
# sudo systemctl start docker


# ubuntu@ip-10-0-2-173:~$ sudo usermod -aG docker ubuntu                           (добавление юзера в группу докер для запуска докера без sudo)
#  ---------------------------------------------------------------------------------------------------------------------------                                                                                  
# ubuntu@ip-10-0-2-173:~$ exit
# logout
# Connection to 10.0.2.173 closed.
# ubuntu@ip-10-0-1-186:~$ ssh -i ~/.ssh/webseeker_key.pem ubuntu@10.0.2.173
# Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 6.8.0-1030-aws x86_64) 

# єто и все что руками надо сделать для запуска пайплайна на воркере в моем случае

# ssh -i ~/.ssh/webseeker_key.pem ubuntu@3.79.239.149          (сначало надо зайти на мастер дженикинса)
# ssh -i ~/.ssh/webseeker_key.pem ubuntu@10.0.2.173            (а потом на воркер дженикинса с мастера)  так как он закрыт от внешнего мира

