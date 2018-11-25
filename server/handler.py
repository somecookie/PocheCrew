# coding: utf-8
from http.server import SimpleHTTPRequestHandler
import hashlib
import base64
import json
import binascii

class Image_handler(SimpleHTTPRequestHandler):
    def do_POST(self):

        #get data from the post
        content_length = int(self.headers['Content-Length'])   
        post_data = self.rfile.read(content_length)
        
        image_json = json.loads(post_data)
        image_data = binascii.a2b_base64(image_json['image'])
        #create a unique file_name
        m = hashlib.sha1(post_data)
        file_name = m.hexdigest()

        #convert text into an image and save it in ./images/
        path_name = "./images/{}.png".format(file_name)
        
        with open(path_name, "wb") as file:
            file.write(image_data)

        print("Image correctly received")
        self.protocol_version = 'HTTP/1.1'
        self.send_response(200)
        self.send_header("Content-type", 'text/html')
        self.send_header("Content-length", 1)
        self.end_headers()
        recipe = [{"title":"Anton à l'orange", "ingredients":["Anton", "orange"]}]
        message = json.dumps(recipe) 
        self.wfile.write(bytes(message, 'utf-8'))
