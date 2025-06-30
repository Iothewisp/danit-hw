
# P.S. я ПОНЯЛ что так можно , я пока реализовал эту задачу 
# через null resource по другому в файле оутпутс 

# useradd -m -s /bin/bash webseeker

# mkdir -p /home/webseeker/.ssh

# # 🔐 Публичный ключ — для входа на мастер
# echo "ssh-rsa AAAAB3...webseeker@local" > /home/webseeker/.ssh/authorized_keys

# # 🔑 Приватный ключ — чтобы мастер подключался к воркеру
# echo "-----BEGIN OPENSSH PRIVATE KEY-----
# ...твоя приватная часть PEM-файла...
# -----END OPENSSH PRIVATE KEY-----" > /home/webseeker/.ssh/webseeker_key.pem

# chmod 700 /home/webseeker/.ssh
# chmod 600 /home/webseeker/.ssh/authorized_keys
# chmod 600 /home/webseeker/.ssh/webseeker_key.pem
# chown -R webseeker:webseeker /home/webseeker/.ssh