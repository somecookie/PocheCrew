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

        print("DONE")
