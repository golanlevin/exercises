text1 = open("tomsawyer.txt").read()
text2 = open("huckfinn.txt").read()

def get_ngrams(n, words):
	ngrams = []
	for i in range(0, len(words)-n):
		current_ngram = ''
		for j in range(0,n):
			current_ngram = current_ngram + words[i+j] + ' '
		ngrams.append(current_ngram.split())
	return ngrams

def count_similarities(grams1, grams2):
	count = 0
	for ngram in grams1:
		if ngram in grams2:
			count += 1
	return count

def ngram_similarity(n, text1, text2):
	words1 = text1.split()
	words2 = text2.split()

	ngrams1 = get_ngrams(n, words1)
	ngrams2 = get_ngrams(n, words2)


	with open('similarity.txt', 'w') as output_file:
		output_file.write(str(count_similarities(ngrams1,ngrams2)))

ngram_similarity(2, text1, text2)