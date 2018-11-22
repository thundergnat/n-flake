use SVG;

sub MAIN ( Int :s(:$sides) where * > 2 = 5,     Int :o(:$order) where * >= 0 = 5,
           Int :r(:$radius) where * > 24 = 300, Str :c(:$color) = 'blue',
           Str :f(:$fname)  = "{$order.&nth}-order-{$sides}-flake.svg" ) {

    my $scale    = 1/2 / sum (0, 1/$sides …^ * > 1/4).map: { cos(τ * $_) };
    my @orders   = (1 - $scale) * $radius «*» $scale «**» (^$order);
    my @vertices = (^$sides).map: { cis( τ * $_/$sides - π/2 ) };

    my @polygons =
    slices($order).race(:batch(($sides**$order / 4).ceiling min 64)).map: -> $slice {
        my $vector = sum @vertices[|$slice] «*» @orders;
        :polygon[ :points(flat (($radius - @orders.sum) «*»
          @vertices «+» $vector)».reals».round(.01).map: |* »+» $radius) ]
    };

    multi slices ( 0      ) { [0] }
    multi slices ( 1      ) { ^$sides }
    multi slices ( $order ) { [X] ^$sides xx $order }

    my $fh = open($fname, :w) or die $fh;

    $fh.print: SVG.serialize(
        :svg[
            :width($radius * 2), :height($radius * 2), :style("fill:$color")
            :rect[:width<100%>, :height<100%>, :fill<white>], |@polygons,
        ]
    )
}

sub nth ($n) {
    my %irr = <1 st 2 nd 3 rd 11 th 12 th 13 th>;
    $n ~ (%irr{$n % 100} // %irr{$n % 10} // 'th')
}

sub USAGE {
note qq:to/STOP/;
Generate SVG n-flake to STDOUT. Takes 5 optional parameters
[--sides=<Int>] [--order=<Int>] [--radius=<Int>] [--color=<Str>] [--fname=<Str>]

Int --s=n or       # of sides. Minium 3. Default 5.
--sides=n

Int --o=l or       "Levels of recursion" Minimum 0. Default 5.
--order=l

Int --r=r or       n-flake will be inscribed in a circle with radius <r>,
--radius=r         effectively 1/2 the height, width of the final image.
                   Minimum 25 (pixels). Default 300.

Str --c=string or  Any SVG accepted color string. Default: blue
--color=string

Str --f=string or  File name to save SVG file.
--fname=string     Default: {o}th-order-{n}-flake.svg where o is the order
                   and n is the number of sides.
STOP
}
