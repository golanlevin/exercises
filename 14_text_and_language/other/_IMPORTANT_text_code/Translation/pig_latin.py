text = "Once upon a midnight dreary, while I pondered, weak and weary, Over many a quaint and curious volume of forgotten lore, While I nodded, nearly napping, suddenly there came a tapping, As of some one gently rapping, rapping at my chamber door. 'Tis some visitor,' I muttered, 'tapping at my chamber door - Only this, and nothing more.'"


#https://stackoverflow.com/questions/5214578/python-print-string-to-text-file
def write_file(data):
	with open('output.txt', 'w') as output_file:
		output_file.write(data)

	# file_name = r'output.txt'
	# with open(file_name, 'wb') as x_file:
	# 	x_file.write('{} total amount'.format(data))



def translate(word):
	if len(word) != 1:
		if word[0] in "aeiou" and len(word) != 1:
			word = word + "way"
		elif word[0:2] in "sm sh ch fl gr ph str th dr wh qu":
			word = word[2:] + word[:2] + "ay"
		else:
			word = word[1:] + word[0] + "ay"
	return word

def translate_to_pig_latin(text):
	pig_latin = text.lower()

	clean_word_list = text.lower().replace("'", "").replace(';','').replace('.','').replace(',','').split()

	for word in clean_word_list:
		new_word = translate(word)
		pig_latin = pig_latin.replace(word, new_word)

	output = text + "\n\n" + pig_latin
	write_file(output)

translate_to_pig_latin(text)
