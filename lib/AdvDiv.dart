String times10(String nstring) {
	if(nstring.contains(".") && nstring.indexOf(".")==nstring.length - 2)
		return nstring.replaceFirst(".", "");
	if(nstring.contains("."))
		return nstring.split(".")[0]+nstring.split(".")[1][0]+"."+nstring.split(".")[1].substring(1);
	return nstring+"0";
}

String? advdiv(String n1, String n2, [final String minstr = "-", final String decstr = ".", final String rstr1 = "[", final String rstr2 = "]"]) {
	bool neg = false, over = false;
	int carry = 0, newcarry = 0, rcount = -1, x, y, d;
	String r1, r2, res = "", result;
	List<int> carries = [];
	List<String> n1s;
	late final int n2i, n1mc, n2mc, m1, m2;
	late final String sign, n1m, n2m;
	late final List<String> n1s1;
  late final RegExp nre;

	if(n1.length==0 || n2.length==0 || RegExp(r'^\d*$').hasMatch(minstr) || RegExp(r'^\d*$').hasMatch(decstr) || RegExp(r'^\d*$').hasMatch(rstr1) || RegExp(r'^\d+$').hasMatch(rstr2))
		return null;

	nre = RegExp(r'^('+RegExp.escape(minstr)+r')?\d*('+RegExp.escape(decstr)+r'\d*('+RegExp.escape(rstr1)+r'\d*'+RegExp.escape(rstr2)+r')?)?$');

	if(!nre.hasMatch(n1) || !nre.hasMatch(n2))
		return null;

	if(n1.startsWith(minstr)) {
		n1 = n1.replaceFirst(minstr, "");
		neg = true;
	};
	if(n2.startsWith(minstr)) {
		n2 = n2.replaceFirst(minstr, "");
		neg = !neg;
	};

	sign = neg ? minstr : "";

	n1 = n1.replaceAll(decstr, ".");
	n2 = n2.replaceAll(decstr, ".");

	if(n1[0]==".")
		n1 = "0"+n1;

	if(n2[0]==".")
		n2 = "0"+n2;

	r1 = RegExp(RegExp.escape(rstr1)+r'(.+)'+RegExp.escape(rstr2)).firstMatch(n1)?[1] ?? "0";
	n1 = n1.split(rstr1)[0].replaceFirst(RegExp(r'^0+'), "0").replaceFirst(RegExp(r1=="0" ? r'\.0*$' : r'\.$'), "");
	r2 = RegExp(RegExp.escape(rstr1)+r'(.+)'+RegExp.escape(rstr2)).firstMatch(n2)?[1] ?? "0";
	n2 = n2.split(rstr1)[0].replaceFirst(RegExp(r'^0+'), "0").replaceFirst(RegExp(r2=="0" ? r'\.0*$' : r'\.$'), "");


	if(RegExp(r'^[0\.]+$').hasMatch(n2+r2))
		return null;

	if(RegExp(r'^[0\.]+$').hasMatch(n1+r1))
		return "0";

	if(r2!="0") {
		n1m = n1.replaceFirst(".", "");
		n2m = n2.replaceFirst(".", "");

		n1mc = int.parse(n1m+r1) - int.parse(n1m);
		n2mc = int.parse(n2m+r2) - int.parse(n2m);

		if(n1.contains("."))
			m1 = int.parse("1"+List.filled(n1.length - n1.indexOf(".") - 1 + r1.length, "0").join("")) - int.parse("1"+List.filled(n1.length - n1.indexOf(".") - 1, "0").join(""));
		else
			m1 = int.parse("1"+List.filled(r1.length, "0").join("")) - 1;

		if(n2.contains("."))
			m2 = int.parse("1"+List.filled(n2.length - n2.indexOf(".") - 1 + r2.length, "0").join("")) - int.parse("1"+List.filled(n2.length - n2.indexOf(".") - 1, "0").join(""));
		else
			m2 = int.parse("1"+List.filled(r2.length, "0").join("")) - 1;

		return sign+advdiv((n1mc * m2).toString(), (m1 * n2mc).toString(), minstr, decstr, rstr1, rstr2)!;
	};

	while(n2.contains(".")) {
		if(!n1.contains(".")) {
			n1+= r1[0];
			if(r1.length > 1)
				r1 = r1.substring(1)+r1[0];
		}
		else {
			n1 = times10(n1);
		};
		n2 = times10(n2);
		if(n1.endsWith(".0") && r1=="0")
			n1 = n1.replaceFirst(".0", "");
		if(n2.endsWith(".0"))
			n2 = n2.replaceFirst(".0", "");
	};

	n2i = int.parse(n2);
	n1s = n1.split("");
	n1s1 = n1.split(".")[0].split("");

	for(x = 0; x < n1s1.length; x++) {
		d = (int.parse(times10(carry.toString())) + int.parse(n1s1[x])) ~/ n2i;
		res+= d.toString();
		carry = int.parse(times10(carry.toString())) + int.parse(n1s1[x]) - n2i * d;
	};

	if(res.length==0) {
		res = "0";
		x++;
	};

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
			n1s.add(r1[rcount % r1.length]);
		};

		newcarry = (int.parse(times10(carry.toString())) + int.parse(n1s[x])) - n2i * ((int.parse(times10(carry.toString())) + int.parse(n1s[x])) ~/ n2i);

		if(over) {
			if(newcarry==0 && r1=="0") {
				res+= ((int.parse(times10(carry.toString())) + int.parse(n1s[x])) ~/ n2i).toString();
				return sign+res.replaceAll(RegExp(r'^0+|0$'), "").replaceFirst(RegExp(r'^\.'), "0.").replaceFirst(RegExp(r'\.$'), "").replaceFirst(".", decstr);
			};
			for(y = 0; y < carries.length; y++) {
				if(carries[y]==newcarry && (y % r1.length)==((rcount + 1) % r1.length)) {
					res+= ((int.parse(times10(carry.toString())) + int.parse(n1s[x])) ~/ n2i).toString();
					result = sign+(res.substring(0, x - rcount + y)+"["+res.substring(x - rcount + y)+"]").replaceFirst(RegExp(r'^0+'), "").replaceFirst(RegExp(r'^\.'), "0.");
					if(result[result.indexOf("[") - 1]==result[result.indexOf("]") - 1])
						result = result.substring(0, result.indexOf("[") - 1)+"["+result[result.indexOf("[") - 1]+result.substring(result.indexOf("[") + 1, result.indexOf("]") - 1)+"]";
					if(result.indexOf("]")==result.indexOf("[") + 3 && result[result.indexOf("[") + 1]==result[result.indexOf("[") + 2])
						result = result.substring(0, result.indexOf("[") + 2)+"]";
					return result.replaceFirst(".", decstr).replaceFirst("[", rstr1).replaceFirst("]", rstr2);
				};
			};
		};

		res+= ((int.parse(times10(carry.toString())) + int.parse(n1s[x])) ~/ n2i).toString();
		if(over)
			carries.add(carry);
		carry = newcarry;
	};
}

void main(List<String> args) {
	String n1, n2;

	if(args.length < 2) {
		print("Usage: advdiv n1 n2");
		return;
	};

	n1 = args[0];
	n2 = args[1];

	print(advdiv(n1, n2) ?? "Error");
}
