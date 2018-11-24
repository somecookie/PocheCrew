import json
import numpy as np

def find_ingredients(ingredients):
    with open('recipes.json') as json_file:  
    data = json.load(json_file)
    
    threshold = 0.9
    matches = []
    for key, value in data.items():
        num_ingr_in_recipe = len(value)
        if num_ingr_in_recipe > 1:
            matching_ingredient = 0.0
            for ingr in value:
                for ingr_disp in ingredients:
                    if ingr == ingr_disp:
                        matching_ingredient += 1
            if matching_ingredient / num_ingr_in_recipe >= threshold:
                matches.append(key)
    return matches