# coding: utf-8
from http.server import SimpleHTTPRequestHandler, BaseHTTPRequestHandler, HTTPServer
from urllib.parse import urlparse
import hashlib
import os
import base64
import re
import json

class Image_handler(SimpleHTTPRequestHandler):
    def do_POST(self):
        
        #get data from the post
        content_length = int(self.headers['Content-Length'])   
        post_data = self.rfile.read(content_length)
        
        image_json = json.loads(post_data)
        image_data = image_json['image'].replace('\\\\','')
        
        print(image_data[-20:])
        #create a unique file_name
        m = hashlib.sha1(post_data)
        file_name = m.hexdigest()

        #convert text into an image and save it in ./images/
        path_name = "./images/{}.png".format(file_name)
        
        with open(path_name, "wb") as file:
            file.write(base64.decodestring(image_data))

        print("DONE")


def decode_base64(data, altchars=b'+/'):
    """Decode base64, padding being optional.

    :param data: Base64 data as an ASCII byte string
    :returns: The decoded byte string.

    """
    #data = re.sub(rb'[^a-zA-Z0-9%s]+' % altchars, b'', data)  # normalize
    missing_padding = len(data) % 4
    if missing_padding:
        data += b'='* (4 - missing_padding)
    return base64.b64decode(data)
