#Sorts words alphabetically
#import re


text = "We hold these truths to be self-evident, that all men are created equal, that they are endowed by their Creator with certain unalienable rights, that among these are life, liberty and the pursuit of happiness. That to secure these rights, governments are instituted among men, deriving their just powers from the consent of the governed. That whenever any form of government becomes destructive to these ends, it is the right of the people to alter or to abolish it, and to institute new government, laying its foundation on such principles and organizing its powers in such form, as to them shall seem most likely to effect their safety and happiness. Prudence, indeed, will dictate that governments long established should not be changed for light and transient causes; and accordingly all experience hath shown that mankind are more disposed to suffer, while evils are sufferable, than to right themselves by abolishing the forms to which they are accustomed. But when a long train of abuses and usurpations, pursuing invariably the same object evinces a design to reduce them under absolute despotism, it is their right, it is their duty, to throw off such government, and to provide new guards for their future security."
sort_by_alphabet = ""
sort_by_freq = ""
sort_by_len = ""

words = text.lower().replace(';','').replace('.','').replace(',','').split()

words.sort()


#sort alphabetically
for word in words:
	sort_by_alphabet += word + " "


#sort by frequency
freq = dict()

for word in words:
	if word in freq:
		freq[word] += 1
	else:
		freq[word] = 1

freq = sorted(freq.items(), key = lambda tup : tup[::-1])

for word, frequency in freq:
	sort_by_freq += (word + ": " + str(frequency) + "\n")


#sort by length
lens = dict()

for word in words:
	lens[word] = len(word)

lens = sorted(lens.items(), key=lambda tup : tup[::-1])

for word, length in lens:
	sort_by_len += (word + ": " + str(length) + "\n")

print ("Sorted Alphabetically")
print (sort_by_alphabet + "\n")

print ("Sorted by Frequency ")
print (sort_by_freq + "\n")

print ("Sort by Length")
print (sort_by_len)