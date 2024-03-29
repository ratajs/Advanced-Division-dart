![](https://raw.githubusercontent.com/ratajs/Advanced-Division/master/imgs/icon.svg)

# Advanced-Division-dart
Divide two numbers using recurring decimals

Import code:
<code>
  import 'AdvDiv.dart';
</code>


You can use the `advdiv` function with this syntax:

<code>
  advdiv(String n1, String n2, String minstr = "-", String decstr = ".", String rstr = "[", String rstr2 = "]")
</code>

* n1 – first number
* n2 – second number
* minstr – string representing the minus sign (default "-")
* decstr – string separating the decimal digits (default ".")
* rstr1 – string to be inserted before recursive decimals (default "[")
* rstr2 – string to be inserted after recursive decimals (default "]")

You can also use it as a console application (download it from the “Releases” section), examples:

<pre>$ ./advdiv 1 6
0.1[6]</pre>

<pre>$ ./advdiv 1 7
0.[142857]</pre>

<pre>$ ./advdiv "123.1[24]" 7.54
16.[329475122578570854432923398440639819950164777750984647536371674302708785467406157061]</pre>

Learn more: <https://advdiv.ratajs.cz>
