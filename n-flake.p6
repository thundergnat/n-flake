sub MAIN ( Int :$sides where * > 2 = 5, Int :$order = 5,
           Int :$radius = 300,          Str :$color = 'blue' ) {

    my $scale    = 1/2 / [+] (0, 1/$sides …^ * > 1/4).map: { cos(τ * $_) };
    my @orders   = (1 - $scale) * $radius «*» $scale «**» (^$order);
    my @vertices = (^$sides).map: { cis( τ * $_/$sides ) };

    say svg-header( $radius*2, $radius*2, :fill($color) );

    for slices( $order ) -> $slice {
        my $vector = [+] @vertices[|$slice] «*» @orders;
        say svg-polygon (($radius - @orders.sum) «*» @vertices «+» $vector)».reals».fmt("%.2f");
    };

    say svg-footer();

    multi slices ( 0      ) { 0 }
    multi slices ( 1      ) { ^$sides }
    multi slices ( $order ) { [X] ^$sides xx $order }
}

sub svg-polygon ( @points ) { qq|<polygon points="{@points}" />| }

sub svg-header ( $height, $width, :$transx = $height/2,
                 :$transy = $width/2, :$fill, :$rotate = -90 ) {
    qq:to/STOP/;
        <?xml version="1.0" standalone="no"?>
        <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN"
          "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
        <svg height="$height" width="$width" style="fill:$fill"
          transform="translate($transx,$transy) rotate($rotate)"
          version="1.1" xmlns="http://www.w3.org/2000/svg">
        STOP
}

sub svg-footer { '</svg>' };

sub USAGE {
    note qq:to/STOP/;
    Generate SVG n-flake to STDOUT. Takes 4 optional parameters
    [--sides=<Int>] [--order=<Int>] [--radius=<Int>] [--color=<Str>]

     --sides=n where <n> > 2. Default: 5.

     --order=k "levels of recursion" Default: 5.

     --radius=r n-flake will be inscribed in a circle with radius <r>,
                effectively 1/2 the height, width of the final image.
                Default: 300

     --color=string Any color string accepted by SVG. Default: blue
    STOP
}
