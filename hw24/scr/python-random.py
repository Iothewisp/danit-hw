#!/usr/bin/python3

from http.server import BaseHTTPRequestHandler, HTTPServer
import random

class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/':
            self.send_response(200)
            self.send_header('Content-Type', 'text/plain; charset=utf-8')
            self.end_headers()
            self.wfile.write(bytes(random_name, "UTF-8"))
        else:
            self.send_response(404)
            self.end_headers()

def run(server_class=HTTPServer, handler_class=SimpleHTTPRequestHandler, port=8082):
    server_address = ('0.0.0.0', port)
    httpd = server_class(server_address, handler_class)
    print(f'Starting httpd server on port {port}...')
    httpd.serve_forever()

if __name__ == '__main__':
    random_name = f"name-{random.randint(0, 255)}"
    run()