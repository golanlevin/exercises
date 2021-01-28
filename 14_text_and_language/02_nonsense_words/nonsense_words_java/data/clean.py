def clean(input_path, output_path):
	f = open(input_path, "r")
	f_r = open(output_path, "w")
	result = []
	for line in f:
		l = line.split("\t");
		r = l[0]
		if "," in r:
			result.extend(r.split(", "))
		else:
			result.append(r)

	result_cleaned = []
	for r in result:
		if " " in r:
			r = r.split(" ")[0]
		if "(" in r:
			start = r.index("(")
			end = r.index(")")
			optional = r[start+1:end]
			r1 = r[:start] + r[end+1:]
			r2 = r[:start] + optional + r[end+1:]
			result_cleaned.append(r1.replace("-", ""))
			result_cleaned.append(r2.replace("-", ""))
		else:
			result_cleaned.append(r.replace("-", ""))

	f_r.write("\n".join(result_cleaned))

def clean2(input_path, output_path):
	f = open(input_path, "r")
	f_r = open(output_path, "w")
	result = []
	for line in f:
		line_l = line.split()
		r = line_l[0]
		result.extend(r.split("/"))
	result_cleaned = []

	for r in result:
		result_cleaned.append(r.replace("-", ""))

	f_r.write("\n".join(result_cleaned))



clean2("suffixes_dict.txt", "suffixes.txt")
