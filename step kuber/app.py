import socket
import logging
from flask import Flask, render_template, request, redirect, url_for, jsonify
from shop import PetShop
import os

# ✅ Настройка логирования
logging.basicConfig(
    level=logging.DEBUG,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[logging.StreamHandler()]
)

app = Flask(__name__)

# Получение конфигурации БД из переменных окружения
host = os.getenv('DB_HOST', 'mysql-service.dev-ns.svc.cluster.local')
user = os.getenv('DB_USER', 'petshop')
password = os.getenv('DB_PASSWORD', '12345qaz')
db_name = os.getenv('DB_NAME', 'shop')

logging.info(f"Connecting to DB at {host} with user '{user}'")

# Инициализация PetShop
petshop = PetShop(host, user, password)
petshop.query(f"USE {db_name};")  # ✅ Явно переключаемся на базу
petshop.create_shop()
logging.info("PetShop initialized and shop created")

# Получение IP хоста
def get_host_ip():
    try:
        hostname = socket.gethostname()
        local_ip = socket.gethostbyname(hostname)
        logging.debug(f"Resolved local IP: {local_ip}")
        return local_ip
    except Exception as e:
        logging.error(f"Unable to retrieve Host IP: {str(e)}")
        return f"Unable to retrieve Host IP: {str(e)}"

@app.route('/')
def index():
    host_ip = get_host_ip()
    return render_template('index.html', host_ip=host_ip)

@app.route('/add_pet', methods=['GET', 'POST'])
def add_pet():
    if request.method == 'POST':
        name = request.form['name']
        price = request.form['price']
        logging.debug(f"Received add_pet request: name={name}, price={price}")

        if not name or not price:
            logging.warning("Missing name or price in add_pet form")
            return render_template('add_pet.html', error="Please provide both name and price.")
        
        ids = petshop.add_item(name, price)
        logging.info(f"Pet added with ID(s): {ids}")
        return render_template('add_pet.html', success=f"Pet added with ID(s): {ids}")

    return render_template('add_pet.html')

@app.route('/delete_pet', methods=['GET', 'POST'])
def delete_pet():
    if request.method == 'POST':
        id = request.form['id']
        logging.debug(f"Received delete_pet request for ID: {id}")

        if not id:
            logging.warning("Missing ID in delete_pet form")
            return render_template('delete_pet.html', error="Please provide an ID.")

        pet = petshop.delete_item_by_id(id)
        if not pet:
            logging.warning(f"Pet with ID {id} not found")
            return render_template('delete_pet.html', error="Pet not found!.")

        res = petshop.delete_item_by_id(id)
        logging.info(f"Pet with ID {id} deleted: {res}")
        return render_template('delete_pet.html', success="Pet deleted successfully." if res else "Pet deleted successfully.")

    return render_template('delete_pet.html')

@app.route('/list_pets')
def list_pets():
    logging.debug("Fetching list of pets")
    pets = petshop.get_all_items()
    logging.info(f"Retrieved pets: {pets}")  # ✅ Логируем содержимое
    return render_template('list_pets.html', pets=pets)

# ✅ JSON endpoint для отладки
@app.route('/api/pets')
def api_pets():
    pets = petshop.get_all_items()
    return jsonify(pets)

if __name__ == '__main__':
    logging.info("Starting Flask app on 0.0.0.0:5000")
    app.run(host='0.0.0.0', port=5000)
