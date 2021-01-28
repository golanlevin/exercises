def clean(input_path, output_path):
	f = open(input_path, "r")
	f_r = open(output_path, "w")
	result = []

	for line in f:
		if "(" in line:
			line = line[:line.index("(")]
		if "," not in line:
			line = line.strip()
			if (line[-1] == "s"):
				line = line[:-1]
			result.append(line.lower())


	f_r.write("\n".join(result))

clean("jobs_raw.txt", "jobs.txt");