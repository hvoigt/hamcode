Hamcode
=======

My tools/things for learning CW.

We use [ebook2cw][1] from Fabian Kurz to generate audio files that
contain a random collection of real words. Currently a german wordlist
(deutsch.txt) is used which we obtained from [netzmafia.de][2]. This
can be exchanged by any list which has its words seperated by a
newline.

The words can be limited to a certain set of characters. This is
helpful if you yet only know a limited amount of characters.

My plans are to extend this so this can generate real QSO like texts
so one can learn the typical patterns.

Usage
-----

There is a [demo page][3] with the output.

Here an example script I call every day using a cronjob:

```bash
#!/bin/bash
# Example: ./generate_all.sh "kmuresnaptlwi.jz=foy,vg5/q92h38b?47c1d60x+#" output
# + -> ^AR, # -> ^KA, < -> ^ERROR
/home/hvoigt/hamcode/generate_all.sh 'elv0' \
	"/var/www/cw.hvoigt.net/Lektion 1" >/dev/null
/home/hvoigt/hamcode/generate_all.sh 'elv0aqs' \
	"/var/www/cw.hvoigt.net/Lektion 2" >/dev/null
```

[1]: https://fkurz.net/ham/ebook2cw.html
[2]: http://www.netzmafia.de/software/wordlists/deutsch.txt
[3]: http://cw.hvoigt.net
