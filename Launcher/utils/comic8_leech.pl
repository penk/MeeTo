#!/usr/bin/env perl

use File::Basename;

if ( ! $ARGV[0] ) { 
    print "Usage: $0 <URL> [<VOL>]\n";
} else {

    $filename = "log/".basename($ARGV[0]);
    if (! -e $filename) {
        mkdir 'log';
        system "wget $ARGV[0] -P log";
        system "piconv -f big5 -t utf8 < $filename > $filename.utf8";
    }

open(F, "$filename".'.utf8') or die "$!\n";

while(<F>) {
    $itemid = $1 if /var itemid=(\d+);/;
    $codes = $1 if /var codes="(.*)"/;
    $name = $1 if /:\[ (.*?) <font/;
}

for (split(/\|/, $codes)) {
    $codes{$1} = $2 if /(\d+?) (.*)/;
    $last = $1;
}

($ARGV[1]) ? &grab_vol($ARGV[1]) : &grab_vol($last);

}

sub grab_vol() {
    my $vol_input = $_[0];
    my $dest = "$name/$vol_input";
    system "mkdir -p $dest" if ! -e $dest;

    # "codes" pattern:
    # num sid did page_number random_word
    # example: 
    # 582 2 3 19 kccmrn2qhcnt7x8w76ncwbap939vg72a24ywwnmc

    if ($vol_input =~ /-/) { ($a, $b) = (split/-/,$vol_input); } # download series
    else { $a = $b = $vol_input; } # download single volume 
    for ($a..$b) {
        $vol = $_;
        if ($codes{$vol}) {
            print "Grab $name volume number: $vol\n";
            ($sid, $did, $page, $code) = (split/ /, $codes{$vol});

    # URL pattern:
    # "http://img"+sid+".8comic.com/"+did+"/"+itemid+"/"+num+"/"+img+".jpg"
    # example: 
    # http://img2.8comic.com/3/103/582/001_kcc.jpg

        for (1..$page) {
            $img = sprintf("%.3d", $_);
            $n = (($_-1)/10)%10+((($_-1)%10)*3);
            $rand = substr($code, $n, 3); 
            $url = "http://img".$sid.".8comic.com/$did/$itemid/$vol/$img".'_'.$rand.".jpg";
            $saved_name = sprintf("$dest/%.3d-$img.jpg", $vol);
            system "wget $url --refer $ARGV[0] -O $saved_name";
        }   

    } else { print "No such volume\n"; } 

    }

    system "zip -j $name/$name-$vol_input.zip $name/$vol_input/*; rm -rf $name/$vol_input"

}
