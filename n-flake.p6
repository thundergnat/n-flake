use SVG;

sub MAIN ( Int :s(:$sides) where * > 2 = 5, Int :o(:$order) = 5,
           Int :r(:$radius) = 300,          Str :c(:$color) = 'blue',
           Str :f(:$fname)  = "{$order.&nth}-order-{$sides}-flake.svg" ) {

    my $scale    = 1/2 / sum (0, 1/$sides …^ * > 1/4).map: { cos(τ * $_) };
    my @orders   = (1 - $scale) * $radius «*» $scale «**» (^$order);
    my @vertices = (^$sides).map: { cis( τ * $_/$sides - π/2 ) };

    my @polygons =
    slices($order).race(:batch(($sides**$order / 4).ceiling max 64)).map: -> $slice {
        my $vector = sum @vertices[|$slice] «*» @orders;
        :polygon[ :points(flat (($radius - @orders.sum) «*»
          @vertices «+» $vector)».reals».round(.01).map: |* »+» $radius),
          :style("fill:$color") ]
    };

    multi slices ( 0      ) { [0] }
    multi slices ( 1      ) { ^$sides }
    multi slices ( $order ) { [X] ^$sides xx $order }

    my $fh = open($fname, :w) or die $fh;

    $fh.print: SVG.serialize(
        :svg[
            :width($radius * 2), :height($radius * 2),
            :rect[:width<100%>, :height<100%>, :fill<white>],
            |@polygons,
        ],
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

     --s=n or --sides=n where n > 2. Default: 5.

     --o=l or --order=l "levels of recursion" Default: 5.

     --r=r or --radius=r n-flake will be inscribed in a circle with radius <r>,
                         effectively 1/2 the height, width of the final image.
                         Default: 300

     --c=string or --color=string Any color string accepted by SVG. Default: blue

     --f=string or --fname=string File name to save SVG file.
                                  Default: sierpinski-n-flake.svg
                                  where n is the number of sides.
    STOP
}
