#Before running, pip install PyDictionary

import random
from PyDictionary import PyDictionary
dictionary = PyDictionary()

file = open('noun-definition.txt','w')

#random nouns generated from https://randomwordgenerator.com/noun.php
noun_list = "scene union computer conclusion university penalty instance leader church affair shirt revolution hat quantity efficiency candidate media restaurant intention customer perspective son village engine departure society idea knowledge manufacturer philosophy hospital news assistance communication person breath moment audience supermarket entry literature mood replacement ad statement thing meat song environment child expression procedure dirt lab inspection menu currency delivery personality effort reaction family farmer republic baseball nation explanation hearing independence wife vehicle estate police quality contribution photo profession road finding description gene stranger city president importance series basis shopping development criticism country advertising passenger alcohol teaching appearance tale negotiation fortune childhood appointment apple tooth satisfaction complaint assignment ratio phone income recipe population tradition cancer poet operation library recording sample gate agency orange dealer competition difficulty television sir wedding technology awareness heart love payment transportation drawer food singer camera argument worker truth".split()

def get_definitions(nouns):

	for name in nouns:
		#makes sure the name is capitalized
		name = name[0].upper() + name[1:]

		#finds out definition
		result = dictionary.meaning(name)['Noun']

		#puts only the first definition into one string
		answer = result[0]
		answer = answer[0].upper() + answer[1:]
		# for definition in result:
		# 	answer = answer + definition +". "

		file.write(name + ":" + answer+"\n")

#runs script 10 times
get_definitions(noun_list)

#closes the output file
file.close()
