import json
import bisect


def find_ingredient(input):
    list = []
    candidates = []
    with open('ingredients_count.json') as count:
        count_ingredient = json.load(count)
        count_ingredient = count_ingredient['count']
    with open(input) as json_data:
        d = json.load(json_data)
    with open('ingredients.json') as ingredients:
        ing = json.load(ingredients)

    im = d['images'][0]
    classifier = im['classifiers'][0]
    classes = classifier['classes']
    for item in classes:
        list.append([item['score'], item['class']])
    list.sort(reverse=True)

    for ingredient in list[::-1]:
        if ingredient[1] in ing and ingredient[0] >= 0.8:
            candidates.append([ingredient[1], count_ingredient[ingredient[1]]])

    candidates.sort()

    if len(candidates) == 0:
        return None
    else :
        return candidates[0]


find_ingredient()