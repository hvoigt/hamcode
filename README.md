Hamcode
=======

My tools/things for learning CW.

We use [ebook2cw][1] from Fabian Kurz which is also used to generate
audio on the wonderful CW training site [lcwo.net][5].
ebook2cw is used to generate audio files that contain a random
collection of real words. Currently a german wordlist (deutsch.txt)
can be used which we obtained from [netzmafia.de][2] and a QSO
wordlist (see below) can be used. This can be exchanged by any list
which has its words seperated by a newline or space.

The QSO wordlist is used to generate texts with abbreviations and
callsigns which should be typical on the air. The sample morse files
(folder 300USAqso) are courtesy of Jim Weir via G4FON's excellent CW
trainer site [http://www.g4fon.net/CW Trainer.htm][4].

The words can be limited to a certain set of characters. This is
helpful if you yet only know a limited amount of characters.

My longterm goal would be to extend this so this can generate real QSO
like texts so one can learn the typical patterns off the air. With QSO
wordlists we are quite close to that but real QSO are still quite
different.

Usage
-----

There is a [demo page][3] with the output.

Here an example script I call every day using a cronjob:

```bash
#!/bin/bash
# Example: ./generate_all.sh "kmuresnaptlwi.jz=foy,vg5/q92h38b?47c1d60x+#" output
# + -> ^AR, # -> ^KA, < -> ^ERROR
/home/hvoigt/hamcode/generate_all.sh -i 4 'elv0' \
	"/var/www/cw.hvoigt.net/Lektion 1" >/dev/null
/home/hvoigt/hamcode/generate_all.sh -i 3 'elv0aqs' \
	"/var/www/cw.hvoigt.net/Lektion 2" >/dev/null
/home/hvoigt/hamcode/generate_all.sh -i 2 'elv0aqst2' \
	"/var/www/cw.hvoigt.net/Lektion 3" >/dev/null
/home/hvoigt/hamcode/generate_all.sh -i 2 'elv0aqst2co' \
	"/var/www/cw.hvoigt.net/Lektion 4" >/dev/null
/home/hvoigt/hamcode/generate_all.sh -f -e 'elv0aqst2co' \
	"/var/www/cw.hvoigt.net/Lektion 5" >/dev/null
/home/hvoigt/hamcode/generate_all.sh -i 3 'elv0aqst2cod5/' \
	"/var/www/cw.hvoigt.net/Lektion 6" >/dev/null
/home/hvoigt/hamcode/generate_all.sh -i 3 'elv0aqst2cod5/ir9' \
	"/var/www/cw.hvoigt.net/Lektion 7" >/dev/null
```

Building
--------

You need to have the following prerequisites installed:

 * perl
 * gcc
 * make
 * git
 * bash
 * libmp3lame, libvorbis, libvorbisenc, libogg

On Ubuntu 16.04 the line for installing the needed libs is:

```
sudo apt-get install -y build-essential git libmp3lame-dev libvorbis-dev
```

To clone and build the repository:

```
git clone https://github.com/hvoigt/hamcode.git
cd hamcode
git submodule update --init
make
```

Now you should be able to execute the scripts as described above.

[1]: https://fkurz.net/ham/ebook2cw.html
[2]: http://www.netzmafia.de/software/wordlists/deutsch.txt
[3]: http://cw.hvoigt.net
[4]: http://www.g4fon.net/CW%20Trainer.htm
