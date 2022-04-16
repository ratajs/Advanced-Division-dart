# Advanced-Division-dart
Divide two numbers using recurring decimals

You can use the `advdiv` function with this syntax:

<code>
advdiv(double n1, double, n2, int r, String rstr = "[", String rstr2 = "]")
</code>

This function relies on the `times10` function, which is eke in this file.

* n1 – first number
* n2 – second number
* r – recurring decimals of the first number (default 0)
* rstr1 – string to be inserted before recursive decimals (default "[")
* rstr2 – string to be inserted after recursive decimals (default "[")

You can also use it as a console application (download it from the “Releases” section), examples:

<pre>$ ./advdiv 1 6
0.1[6]</pre>

<pre>$ ./advdiv 1 7
0.[142857]</pre>

<pre>$ ./advdiv 123.1 7.54 24
16.[329475122578570854432923398440639819950164777750984647536371674302708785467406157061]</pre>

You can look at the [JavaScript](https://github.com/ratajs/Advanced-Division-js) and [Python](https://github.com/ratajs/Advanced-Division-py) versions as well.
