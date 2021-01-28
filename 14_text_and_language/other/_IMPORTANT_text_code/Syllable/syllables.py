import random

def count_vowels(string):
	count = 0
	for i in range(0,len(string)):
		if string[i] in ['a','e','i','o','u','y']:
			count+=1
	return count

def count_silent_vowels(string):
	count = 0
	# for i in range(0,len(string)-3):
	# 	if (string[i] in ['a','i','o']) & (string[i+2] in ['e']):
	# 		count+=1
	if string[-1] is 'e':
		count+=1
	return count

def count_diphthongs(string):
	diphthongs = ['ea','ai','au','ou','oi','oy','oo','ie','ay','io']
	count = 0
	for i in range(0,len(string)-1):
		if string[i:i+2] in diphthongs:
			count+=1
	return count
	
def count_syllables(string):
	#counting syllables using rules from http://www.phonicsontheweb.com/syllables.php
	vowels = count_vowels(string)
	diphthongs = count_diphthongs(string)
	silent_vowels = count_silent_vowels(string)
	if vowels == 0:
		#if this is the case, assume it is an acronym that is spelled out lound
		return len(string)
	else:
		return vowels - diphthongs - silent_vowels

def get_word_list():
	#list of computer related words from http://www.enchantedlearning.com/wordlist/computer.shtml
	path = 'word.txt'
	words = open(path,'r').read().split()
	return words

def get_word(word_list):
	length = len(word_list)
	return word_list[random.randint(0,length-1)]

def make_line(syllable_length, word_list):
	line = ''
	syllable_count = 0
	while syllable_count < syllable_length:
		new_word = get_word(word_list)
		new_word_syllables = count_syllables(new_word)
		if syllable_count + new_word_syllables <= syllable_length:
			line = line + ' ' + new_word
			syllable_count += new_word_syllables
	return line

def make_haikus(amount):
	words = get_word_list()

	for i in range(1,amount+1):
		with open('haiku' + str(i) + '.txt', 'w') as output_file:
			haiku = (make_line(5,words) + 
			 '\n' + make_line(7,words) + 
			 '\n' + make_line(5,words))
		
			output_file.write(haiku)



make_haikus(7)
