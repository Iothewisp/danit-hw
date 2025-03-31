# app.py

import socket  # Make sure to import socket for resolve ip

from flask import Flask, render_template, request, redirect, url_for
from shop import PetShop
import os


app = Flask(__name__)


# Get database configurations from environment variables  
host = os.getenv('DB_HOST', 'mysql-service.dev-ns.svc.cluster.local')
user = os.getenv('DB_USER', 'petshop')
password = os.getenv('DB_PASSWORD', '12345qaz')
db_name = os.getenv('DB_NAME', 'shop')



#host = "mysql-service.dev-ns.svc.cluster.local"  # Default host #This is the mane of mysql-service in yaml for kubernetis cluster
##host = "localhost"
#user = "petshop"
#password = "12345qazwsxed"

# Initialize PetShop
petshop = PetShop(host, user, password)
petshop.create_shop()


# Function to get the local IP address of the host
def get_host_ip():
    try:
        # Get the local machine's hostname
        hostname = socket.gethostname()
        # Retrieve the local IP address associated with the hostname
        local_ip = socket.gethostbyname(hostname)
        return local_ip
    except Exception as e:
        return f"Unable to retrieve Host IP: {str(e)}"

# Home page
@app.route('/')
def index():
    host_ip = get_host_ip()  # Get the local host IP
    return render_template('index.html', host_ip=host_ip)

# Add pet - show form and handle submission
@app.route('/add_pet', methods=['GET', 'POST'])
def add_pet():
    if request.method == 'POST':
        name = request.form['name']
        price = request.form['price']

        if not name or not price:
            return render_template('add_pet.html', error="Please provide both name and price.")
        
        ids = petshop.add_item(name, price)
        return render_template('add_pet.html', success=f"Pet added with ID(s): {ids}")

    return render_template('add_pet.html')

# Delete pet by ID - show form and handle submission
@app.route('/delete_pet', methods=['GET', 'POST'])
def delete_pet():
    if request.method == 'POST':
        id = request.form['id']

        if not id:
            return render_template('delete_pet.html', error="Please provide an ID.")

        pet = petshop.delete_item_by_id(id)
        if not pet:
            return render_template('delete_pet.html', error="Pet not found!.")

        # If the pet exists, delete it
        res = petshop.delete_item_by_id(id)
        return render_template('delete_pet.html', success="Pet deleted successfully." if res else "Pet deleted successfully.")


 
    return render_template('delete_pet.html')

# Show list of pets
@app.route('/list_pets')
def list_pets():
        
    #query = "SELECT * FROM pets"
    pets = petshop.get_all_items()
    return render_template('list_pets.html', pets=pets)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)


