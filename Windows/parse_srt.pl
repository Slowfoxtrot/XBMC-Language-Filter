#!/usr/bin/perl
#
#	parse_srt.pl
#	XBMC Language Filter
# 
#	Created by Brock Haymond 9/6/12.
#	Copyright (c) 2012 Brock Haymond <http://brockhaymond.com>.  All rights reserved.
#
# 	Perl script to search a subtitle.srt file for profanity and create an XBMC-compatible EDL file from the results found.
# 	You can call the perl script as follows:
#
#	perl parse_srt.pl "subtitle_file.srt"
#
#	The "subtitle_file.edl" file will be output into the same directory as the original subtitle.srt file.
#

$count = 0;

if($ARGV[$0] eq "") {
	print "\nXBMC Language Filter by Brock Haymond (v1.0)\n\nDrop subtitle.srt file or subtitles folder here.\n\n";

	$ARGV[$0] =  <STDIN>;
	chomp ($ARGV[$0]);
}

$ARGV[$0] =~ s/"//g;

print "\nCreating XBMC-compatible EDL file(s)\n";
print "-------------------------------------\n";

if(-d $ARGV[$0]) {
	opendir(DIR, $ARGV[$0]);
	@CONTENTS= readdir(DIR); 
	parse("$ARGV[$0]\\$_") foreach (@CONTENTS);
}
else {
	parse($ARGV[$0]);
}

sub parse {

$subtitle = shift;
$subtitle =~ s/\\\\/\\/g;

if (-f $subtitle)
{
  if($subtitle !~ /\.srt$/i) {
    return;	
  }
}
else {
  return;
}

my $verbose = 0;

@pmatch = (
"jesus",
"christ",
"christ's",
"hell",
"hell's",
"hellhole",
"hellholes",
"ass",
"ass's",
"asses",
"badass",
"badasses",
"jackass",
"jackasses",
"asshole",
"assholes",
"cock",
"cocks",
"cock's",
"piss",
"pissing",
"tit",
"tits",
"tit's",
"tities",
"boob",
"boobs",
"boob's",
"boobies"
);
our %pmatchhash = map { $_ => 1 } @pmatch;

@pcontains = (
"lord",
"god",
"shit",
"damn",
"bitch",
"biatch",
"fuck",
"bastard",
"genital",
"penis",
"vagina",
"pussy",
"cunt",
"twat",
"nutsack", 
"breast",
"scheiﬂe",
"whore",
"fondle",
"tryst"
);

$edl = $subtitle;
$edl =~ s/srt/edl/;

if(!open TXT, "$subtitle") {print "Couldn't open file '$subtitle'. $!.\n"; <STDIN>; exit 1;}
if(!open EDL, ">$edl") {print "$!\n"; exit 1;}

if($verbose) {print "Processing $subtitle\nWriting to $edl\n";}

$file = do {
	local $/;
	<TXT>;
};
$file =~ s/\r\n/\n/g;

my @block = split('\n\n', $file);
foreach $block (@block) {
  my @lines = split('\n', $block);
  $block =~ s/^(?:.*\n){1,2}//;
  $block =~ s/,|\.|\?|\!|"|#|:|\<.*?\>|\[(.*|.*\n.*)\]//g;
  $block =~ s/-/ /g;
  $block =~ s/  / /g;

  $found = 0;
  $found |= ($block =~ /.*$_.*/i) foreach (@pcontains);

  my @words = split(' ', $block);
  $found |= exists $pmatchhash{lc($_)} foreach (@words);
  
  if($found) {
	#print "$lines[1]\n$block\n\n";
	$lines[1] =~ s/,/\./g;
    	my @times = split(' --> ', $lines[1]);
	$start = parsetime($times[0]);
	$end = parsetime($times[1]);
	print EDL "$start     \t$end     \t1\n";
  }
}

if($verbose) {print "Finished parsing $subtitle\n";}

sub parsetime {
  my @time = split(':', $_[0]);
  $time = $time[0]*3600 + $time[1]*60 + $time[2];
  return sprintf "%.2f", $time;
}
	
close(TXT);
close(EDL);

if($verbose) {print "Closed $subtitle\nClosed $edl\n";}

print "Processing $subtitle...\n";

$count++;
}

print "-------------------------------------\n";
print "$count subtitle(s) successfully processed.\n";
if ($count>0) {
	print "An EDL file has been created in the same directory as the original SRT file.\n";
	print "Enjoy!\n\n";
}
print "Press enter to close.\n"; <STDIN>; exit 1;