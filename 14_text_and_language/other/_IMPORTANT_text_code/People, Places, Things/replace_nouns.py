import random
import numpy
from textblob import TextBlob

text1 = "Congress shall make no law respecting an establishment of religion, or prohibiting the free exercise thereof; or abridging the freedom of speech, or of the press; or the right of the people peaceably to assemble, and to petition the government for a redress of grievances. A well regulated militia, being necessary to the security of a free state, the right of the people to keep and bear arms, shall not be infringed. No soldier shall, in time of peace be quartered in any house, without the consent of the owner, nor in time of war, but in a manner to be prescribed by law. The right of the people to be secure in their persons, houses, papers, and effects, against unreasonable searches and seizures, shall not be violated, and no warrants shall issue, but upon probable cause, supported by oath or affirmation, and particularly describing the place to be searched, and the persons or things to be seized. No person shall be held to answer for a capital, or otherwise infamous crime, unless on a presentment or indictment of a grand jury, except in cases arising in the land or naval forces, or in the militia, when in actual service in time of war or public danger; nor shall any person be subject for the same offense to be twice put in jeopardy of life or limb; nor shall be compelled in any criminal case to be a witness against himself, nor be deprived of life, liberty, or property, without due process of law; nor shall private property be taken for public use, without just compensation. In all criminal prosecutions, the accused shall enjoy the right to a speedy and public trial, by an impartial jury of the state and district wherein the crime shall have been committed, which district shall have been previously ascertained by law, and to be informed of the nature and cause of the accusation; to be confronted with the witnesses against him; to have compulsory process for obtaining witnesses in his favor, and to have the assistance of counsel for his defense. In suits at common law, where the value in controversy shall exceed twenty dollars, the right of trial by jury shall be preserved, and no fact tried by a jury, shall be otherwise reexamined in any court of the United States, than according to the rules of the common law. Excessive bail shall not be required, nor excessive fines imposed, nor cruel and unusual punishments inflicted. The enumeration in the Constitution, of certain rights, shall not be construed to deny or disparage others retained by the people. The powers not delegated to the United States by the Constitution, nor prohibited by it to the states, are reserved to the states respectively, or to the people."
text2 = "The Mole had been working very hard all the morning, spring- cleaning his little home. First with brooms, then with dusters; then on ladders and steps and chairs, with a brush and a pail of whitewash; till he had dust in his throat and eyes, and splashes of whitewash all over his black fur, and an aching back and weary arms. Spring was moving in the air above and in the earth below and around him, penetrating even his dark and lowly little house with its spirit of divine discontent and longing. It was small wonder, then, that he suddenly flung down his brush on the floor, said 'Bother!' and 'O blow!' and also 'Hang spring-cleaning!' and bolted out of the house without even waiting to put on his coat. Something up above was calling him imperiously, and he made for the steep little tunnel which answered in his case to the gravelled carriage-drive owned by animals whose residences are nearer to the sun and air. So he scraped and scratched and scrabbled and scrooged and then he scrooged again and scrabbled and scratched and scraped, working busily with his little paws and muttering to himself, 'Up we go! Up we go!' till at last, pop! his snout came out into the sunlight, and he found himself rolling in the warm grass of a great meadow."

#checks if a string is a noun
def is_noun(word):
 	noun_tags = ['PP', 'PRP', 'NN','NNS','NNP']
 	wordTags = TextBlob(word).tags
 	if wordTags != []:
 		return wordTags[0][1] in noun_tags
 	return False;

#checks if the word ends in a comma, period, etc.
def end_punctuation(word):
	if word[-1] in ",?!.":
		return word[-1]
	return ''

#changes list of words into sentence
def make_string(word_list):
	sentence = ''
	for word in word_list:
		sentence = sentence + ' ' + word
	return sentence[0:-1].strip()

#makes a list of all the nouns in a given string
def noun_list(text):
	word_list = text.split()
	noun_list = []
	for word in word_list:
		if is_noun(word):
			noun_list.append(word.replace(',',''))
	return noun_list

#returns a random noun from a list of nouns
def random_noun(list_of_nouns):
	length = len(list_of_nouns)
	index = random.randint(0,length-1)
	return list_of_nouns[index]


#replaces the nouns in text1 for nouns in text2, saves in text file
def replace_nouns(text1, text2):
	nouns = noun_list(text2)
	original_sentence = text1.split();
	replaced_sentence = []
	for word in original_sentence:
		if is_noun(word) == False:
			replaced_sentence.append(word)
		else:
			new_noun = random_noun(nouns)
			replaced_sentence.append(new_noun + end_punctuation(word))
	output = make_string(replaced_sentence)
	with open('output.txt', 'w') as output_file:
		output_file.write(output)


replace_nouns(text1,text2)
