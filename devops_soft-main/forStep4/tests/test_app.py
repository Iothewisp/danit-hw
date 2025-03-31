import unittest
from app import app

class FlaskAppTests(unittest.TestCase):
    def setUp(self):
        self.app = app.test_client()
        self.app.testing = True

    def test_home_page(self):
        response = self.app.get('/')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'Welcome to the Pet Shop', response.data)  # Adjust this according to your actual HTML content

    def test_add_item(self):
        response = self.app.post('/add_pet', data={
            'name': 'Mikky mouse',
            'price': '100'
        })
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'Pet added with ID(s):', response.data)  # Check for success message


    # To use test_delete DB must be clean, because it will look for id 1 and delete it if exists or error
    #def test_delete_item(self):
    #    # First, add an item to ensure there's something to delete
    #    self.app.post('/add_pet', data={
    #        'name': 'Mikky mouse',
    #        'price': '100'
    #    })
    #    # Now try to delete it
    #    response = self.app.post('/delete_pet', data={'id': '1'})  # Use the correct ID based on your setup
    #    self.assertEqual(response.status_code, 200)
    #    self.assertIn(b'Pet deleted successfully.', response.data)  # Check for success message

    def test_get_items(self):
        response = self.app.get('/list_pets')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'List of Pets', response.data)  # Adjust this according to your actual HTML content

if __name__ == '__main__':
    unittest.main()


