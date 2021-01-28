import random
import pronouncing

def get_sentences():
	#http://www.cs.cmu.edu/afs/cs.cmu.edu/project/fgdata/Recorder.app/utterances/Type1/harvsents.txt
	sentences = [sentence.strip() for sentence in open('sentences.txt').readlines()]
	return sentences

def get_sentence(sentences):
	length = len(sentences)
	return sentences[random.randint(0,length-1)]

def get_last_word(sentence):
	return sentence.split()[-1][0:-1]

def force_rhyme(sentence, sentences):
	last_word = get_last_word(sentence)
	rhyming_words = pronouncing.rhymes(last_word)
	if len(rhyming_words) == 0:
		rhyming_words = [last_word]
	rhyming_word = rhyming_words[random.randint(0,len(rhyming_words)-1)]

	new_sentence = get_sentence(sentences)
	new_last_word = get_last_word(new_sentence)
	return new_sentence.replace(new_last_word,rhyming_word)


def get_rhyming_sentence(sentence, sentences):
	last_word = get_last_word(sentence)
	has_rhyme = False
	num_tries = 1000
	#if it doesnt fine a rhyme within the given amount of tries, it will force a rhyme
	for i in range(0, num_tries):
		new_sentence = get_sentence(sentences)
		last_word = get_last_word(sentence)
		rhymes = pronouncing.rhymes(last_word)

		if get_last_word(new_sentence) in rhymes:
			return new_sentence
		has_rhyme = True
		num_tries -=1
	return False

def make_couplet():
	sentences = get_sentences()

	first_sentence = get_sentence(sentences)
	last_word = get_last_word(first_sentence)
	second_sentence = get_rhyming_sentence(first_sentence, sentences)
	if second_sentence == False:
		second_sentence = force_rhyme(first_sentence,sentences)

	return first_sentence + '\n' + second_sentence


def create_rhymes(amount):
	output = ''
	for i in range(0,amount):
		output = output + '\n\n' + make_couplet()

	with open('output.txt', 'w') as output_file:
		output_file.write(output.strip())


create_rhymes(10)
