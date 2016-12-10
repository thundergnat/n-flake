## NAME

n-flake.p6

## USAGE

Generate an SVG n-flake to STDOUT.

Takes 4 optional parameters:

    [--sides=<Int>] [--order=<Int>] [--radius=<Int>] [--color=<Str>]

     --sides=n where <n> > 2. Default: 5.

     --order=k "levels of recursion" Default: 5.

     --radius=r n-flake will be inscribed in a circle with radius <r>,
                effectively 1/2 the height, width of the final image.

     --color=string Any color string accepted by SVG. Default: blue


At a command prompt enter:

    perl6 n-flake.p6 > n-flake.svg

The defaults produce a 600 x 600 pixel blue 5th order pentaflake.
(A Sierpinski pentagon)

Open with an image viewer or most modern web browsers.

You can specify various parameters too:

    perl6 n-flake.p6 --sides=6 --order=4 --color='red' --radius=500 > 6flake4.svg

will result in a 1000 x 1000 red fourth order hexaflake.

    perl6 n-flake.p6 --sides=3 --order=0  > 3flake0.svg
    perl6 n-flake.p6 --sides=3 --order=1  > 3flake1.svg
    perl6 n-flake.p6 --sides=3 --order=2  > 3flake2.svg
    perl6 n-flake.p6 --sides=3 --order=3  > 3flake3.svg
    perl6 n-flake.p6 --sides=3 --order=4  > 3flake4.svg
    perl6 n-flake.p6 --sides=3 --order=5  > 3flake5.svg
    perl6 n-flake.p6 --sides=3 --order=6  > 3flake6.svg
    perl6 n-flake.p6 --sides=3 --order=7  > 3flake7.svg

to get a progression of Sierpinski triangles.

## A little exposition

Since SVG files are theoretically infinitely scalable, you could pick any
radius. It doesn't pay to choose one too small though. It will have minimal
effect on the size of the generated file, a few bytes at most. Practically, most
image viewing programs seem to be limited to 400%-1000% scaling so 600 x 600 is
a good compromise allowing reasonable up and down resizing.

You can't really make n-flakes with 1 or 2 sides. Those would be a point or a
line and the SVG routines I use here won't support those without special casing.

A 4 sided n-flake is kind of a degenerate form. It is essentially just a solid
filled square.

n-flakes with sides 3, 5 and 6 are known as Sierpinski triangles, pentagons and
hexagons respectively. The discerning factor is that the center space is the
same size as one of the 1st order leaf nodes.

Higher side count n-flakes have center spaces larger than than their 1st order
leaf nodes.

You probable want to avoid generating n-flakes where $sides ** $order is greater
that 1000. The files will get quite large and the details will be difficult to
see anyway.

That being said, if you want to make a fifth order 64 sided n-flake, knock
yourself out. Hope you have plenty of time, a large hard drive and a very robust
viewing program.

## AUTHOR

Stephen Schulze (occasionally seen lurking on perlmonks.org, rosettacode.org and
 #perl6 IRC as thundergnat)

## LICENSE

Licensed under The Artistic 2.0; see LICENSE.
