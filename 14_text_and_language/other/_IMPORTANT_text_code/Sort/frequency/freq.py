from collections import OrderedDict

text = "We hold these truths to be self-evident, that all men are created equal, that they are endowed by their Creator with certain unalienable rights, that among these are life, liberty and the pursuit of happiness. That to secure these rights, governments are instituted among men, deriving their just powers from the consent of the governed. That whenever any form of government becomes destructive to these ends, it is the right of the people to alter or to abolish it, and to institute new government, laying its foundation on such principles and organizing its powers in such form, as to them shall seem most likely to effect their safety and happiness. Prudence, indeed, will dictate that governments long established should not be changed for light and transient causes; and accordingly all experience hath shown that mankind are more disposed to suffer, while evils are sufferable, than to right themselves by abolishing the forms to which they are accustomed. But when a long train of abuses and usurpations, pursuing invariably the same object evinces a design to reduce them under absolute despotism, it is their right, it is their duty, to throw off such government, and to provide new guards for their future security."

def clean_list(text):
	return text.lower().replace(',','').replace(".","").split()

def sort_by_freq(text):
	words = clean_list(text)
	words_and_freq = {}
	output = ''

	for word in words:
		if word in words_and_freq:
			words_and_freq[word] = words_and_freq[word]+1
		else:
			words_and_freq[word] = 1

	sorted_freq = OrderedDict(sorted(words_and_freq.items(), key=lambda t: t[1]))
	for word, freq in sorted_freq.items():
	    output = output + word + ' '

	with open('output.txt', 'w') as output_file:
		output_file.write(output.strip())

sort_by_freq(text)