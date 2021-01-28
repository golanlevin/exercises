from lxml import html
from nltk import tokenize
import requests
import random

def get_recipe(directions):
	recipe = []
	for i in range(0, 5):
		index = random.randint(0,len(directions))
		recipe.append(directions[index])
	return recipe

def cleanup_recipe_source(directions):
	cleaned_directions = []
	for i in directions:
		for j in i:
			for sentence in tokenize.sent_tokenize(j):
				cleaned_directions.append(sentence)
	return cleaned_directions

def write_recipe(recipe):
	result = ''
	for direction in recipe:
		result = result + '\n' + direction
	with open('recipe.txt', 'w') as output_file:
		output_file.write(result.strip())

def get_urls():
	urls = []
	for i in range(0,1):
		page=requests.get('http://www.cookincanuck.com/2016/09/')
		tree = html.fromstring(page.content)
		site_name = (tree.xpath('//span[@class="from"]/text()'))
		urls.append((tree.xpath('//a/@href')))
	clean_urls = []
	for url in urls[0]:
		if ('20' in url) &  (('#comment' in url) == False):
			clean_urls.append(url)
	clean_list = list(set(clean_urls))
	return clean_list

def make_recipe():
	urls=get_urls()
	directions = []
	for url in urls:
		page=requests.get(url)
		tree = html.fromstring(page.content)
		directions.append(tree.xpath('//li[@class="instruction"]/text()'))
		
	directions = cleanup_recipe_source(directions)
	recipe = get_recipe(directions)
	write_recipe(recipe)

make_recipe()


