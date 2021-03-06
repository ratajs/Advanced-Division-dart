String times10(String nstring) {
	if(nstring.contains(".") && nstring.indexOf(".")==nstring.length - 2)
		return nstring.replaceFirst(".", "");
	if(nstring.contains("."))
		return nstring.split(".")[0]+nstring.split(".")[1][0]+"."+nstring.split(".")[1].substring(1);
	return nstring+"0";
}
String? advdiv(double n1, double n2d, [int ri = 0, final String rstr1 = "[", final String rstr2 = "]"]) {
	bool over = false;
	int carry = 0, newcarry = 0, rcount = -1, x, y, d;
	String n1string, n2string, r, res = "", result;
	List<int> carries = [];
	List<String> n1s;
	late final int n2, dotx;
	late final String sign;
	late final List<String> n1s1;

	if(n2d==0)
		return null;
	sign = (n1 < 0 ? n2d >= 0 : n2d < 0) ? "-" : "";
	n1 = n1.abs();
	n2d = n2d.abs();
	ri = ri.abs();
	r = ri.toString();
	n1string = n1.toString();
	n2string = n2d.toString();
	if(n1string.endsWith(".0"))
		n1string = n1string.replaceFirst(".0", "");
	if(n2string.endsWith(".0"))
		n2string = n2string.replaceFirst(".0", "");

	while(n2string.contains(".")) {
		if(!n1string.contains(".")) {
			n1string+= r[0];
			if(r.length > 1)
				r = r.substring(1)+r[0];
		}
		else {
			n1string = times10(n1string);
		};
		n2string = times10(n2string);
		if(n1string.endsWith(".0"))
			n1string = n1string.replaceAll(".0", "");
		if(n2string.endsWith(".0"))
			n2string = n2string.replaceAll(".0", "");
	};

	n1 = double.parse(n1string);
	n2 = int.parse(n2string);
	n1s = n1string.split("");
	n1s1 = n1string.split(".")[0].split("");

	for(x = 0; x < n1s1.length; x++) {
		d = (int.parse(times10(carry.toString())) + int.parse(n1s1[x])) ~/ n2;
		res+= d.toString();
		carry = int.parse(times10(carry.toString())) + int.parse(n1s1[x]) - n2 * d;
	};

	if(res.length==0) {
		res = "0";
		x++;
	};

	dotx = x;
	res+= ".";
	if(!n1s.contains("."))
		n1s.add(".");

	while(n1s.length <= x)
		n1s.add("");

	while(true) {
		x++;
		if(x >= n1s.length) {
			rcount++;
			over = true;
			n1s.add(r[rcount % r.length]);
		};

		newcarry = (int.parse(times10(carry.toString())) + int.parse(n1s[x])) - n2 * ((int.parse(times10(carry.toString())) + int.parse(n1s[x])) ~/ n2);

		if(over) {
			if(newcarry==0 && r=="0") {
				res+= ((int.parse(times10(carry.toString())) + int.parse(n1s[x])) ~/ n2).toString();
				return sign+res.replaceAll(RegExp(r'^0+|0$'), "").replaceFirst(RegExp(r'^\.'), "0.").replaceFirst(RegExp(r'\.$'), "");
			};
			for(y = 0; y < carries.length; y++) {
				if(carries[y]==newcarry && (y % r.length)==((rcount + 1) % r.length)) {
					res+= ((int.parse(times10(carry.toString())) + int.parse(n1s[x])) ~/ n2).toString();
					result = sign+(res.substring(0, x - rcount + y)+"["+res.substring(x - rcount + y)+"]").replaceFirst(RegExp(r'^0+'), "").replaceFirst(RegExp(r'^\.'), "0.");
					if(result[result.indexOf("[") - 1]==result[result.indexOf("]") - 1])
						result = result.substring(0, result.indexOf("[") - 1)+"["+result[result.indexOf("[") - 1]+result.substring(result.indexOf("[") + 1, result.indexOf("]") - 1)+"]";
					if(result.indexOf("]")==result.indexOf("[") + 3 && result[result.indexOf("[") + 1]==result[result.indexOf("[") + 2])
						result = result.substring(0, result.indexOf("[") + 2)+"]";
					return result.replaceFirst("[", rstr1).replaceFirst("]", rstr2);
				};
			};
		};

		res+= ((int.parse(times10(carry.toString())) + int.parse(n1s[x])) ~/ n2).toString();
		if(over)
			carries.add(carry);
		carry = newcarry;
	};
}

void main(List<String> args) {
	int r;
	double n1, n2;

	if(args.length < 2 || !RegExp(r'^\d*\.?\d+$').hasMatch(args[0]) || !RegExp(r'^\d*\.?\d+$').hasMatch(args[1]) || (args.length > 2 && !RegExp(r'^\d+$').hasMatch(args[2]))) {
		print("Usage: advdiv n1 n2[ r]");
		return;
	};

	n1 = double.parse(args[0]);
	n2 = double.parse(args[1]);
	r = args.length < 3 ? 0 : int.parse(args[2]);

	print(advdiv(n1, n2, r) ?? "Error");
}
