import markovify

def write_lines(amount):
	
	with open("transcript.txt") as f:
	    text = f.read()
	    text = (text.replace('Mike: ', '').replace('Lisa: ','').replace('Denny: ','').replace('Mark:','').replace('Florist:','').replace('Claudette:','').replace('Michelle:','').replace("Johnny:",'').replace("Steven:",'').replace("Patron 3:",'').replace("Peter:",''))

	# Build the model.
	text_model = markovify.Text(text)

	output = ''
	for i in range(amount):
		new_line = str(text_model.make_sentence())
		while new_line in "None":
			new_line = str(text_model.make_sentence())

		output = output + new_line + '\n'

	with open('markov_lines.txt', 'w') as output_file:
		output_file.write(output)

write_lines(30)