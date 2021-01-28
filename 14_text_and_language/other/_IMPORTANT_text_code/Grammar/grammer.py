import random

def get_occupation():
	path = 'occupations.txt'
	occupations = open(path,'r').read().split()
	length = len(occupations)
	occupation = occupations[random.randint(0,length-1)]
	if occupation[0] in ['a','e','i','o','u','A','E','I','O','U']:
		return 'an ' + occupation
	else:
		return 'a ' + occupation



def grammer():	
	output = "Dammit Jim, I'm a Doctor, not " + get_occupation()
	with open('output.txt', 'w') as output_file:
		output_file.write(output)


grammer()

