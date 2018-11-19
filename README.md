## NAME

n-flake.p6

## USAGE

Generate SVG n-flake to STDOUT. Takes 5 optional parameters.

[--sides=<Int>] [--order=<Int>] [--radius=<Int>] [--color=<Str>] [--fname=<Str>]

 --s=n or --sides=n where n > 2. Default: 5.

 --o=l or --order=l "levels of recursion" Default: 5.

 --r=r or --radius=r n-flake will be inscribed in a circle with radius <r>,
                     effectively 1/2 the height, width of the final image.
                     Default: 300

 --c=string or --color=string Any color string accepted by SVG. Default: blue

 --f=string or --fname=string File name to save SVG file.
                              Default: sierpinski-n-flake.svg
                              where n is the number of sides.

At a command prompt enter:

    perl6 n-flake.p6

The defaults produce a 600 x 600 pixel blue 5th order pentaflake.
(A Sierpinski pentagon)

Open with an image viewer or most modern web browsers.

You can specify various parameters too:

    perl6 n-flake.p6 --sides=6 --order=4 --color='red' --radius=400

will result in a 800 x 800 red fourth order hexaflake.

    perl6 n-flake.p6 --s=3 --o=0  --f=3flake0.svg
    perl6 n-flake.p6 --s=3 --o=1  --f=3flake1.svg
    perl6 n-flake.p6 --s=3 --o=2  --f=3flake2.svg
    perl6 n-flake.p6 --s=3 --o=3  --f=3flake3.svg
    perl6 n-flake.p6 --s=3 --o=4  --f=3flake4.svg
    perl6 n-flake.p6 --s=3 --o=5  --f=3flake5.svg
    perl6 n-flake.p6 --s=3 --o=6  --f=3flake6.svg
    perl6 n-flake.p6 --s=3 --o=7  --f=3flake7.svg

to get a progression of Sierpinski triangles.

## A little exposition

Since SVG files are theoretically infinitely scalable, you could pick any
radius. It doesn't pay to choose one too small though. It will have minimal
effect on the size of the generated file, a few bytes at most, and could
negatively affect the display accuracy since the node definitions are limited to
2 decimal place precision. Practically, most image viewing programs seem to be
limited to 400%-1000% scaling so 600 x 600 is a good compromise allowing
reasonable up and down resizing.

There are 147 predefined text SVG color names you can use, or, you can just
supply a color in #xRGB format. E.G. red or #FF0000 are equivalent, as are gold
and #FFD700.

See http://www.december.com/html/spec/colorsvghex.html for predefined colors.

You can't really make n-flakes with 1 or 2 sides. Those would be a point or a
line respectively and the SVG routines used here won't support those without
special casing.

A 4 sided n-flake generated using this algorithm is kind of a degenerate form.
It is essentially just a solid filled square.

n-flakes with sides 3, 5 and 6 are known as Sierpinski triangles, pentagons and
hexagons respectively. The discerning factor is that the center space is the
same size as one of the 1st order leaf nodes.

Higher side count n-flakes have a center space larger than than their 1st order
leaf nodes.

You probable want to avoid generating n-flakes where $sides ** $order is greater
than 1000. The files will get quite large and the details will be difficult to
see anyway.

That being said, if you want to make a fifth order 64 sided n-flake, knock
yourself out. Hope you have plenty of time, a large hard drive and a very robust
viewing program.

## AUTHOR

Stephen Schulze (occasionally seen lurking on perlmonks.org, rosettacode.org and
 #perl6 IRC as thundergnat)

## LICENSE

Licensed under The Artistic 2.0; see LICENSE.
