#!/usr/bin/env perl

$selector = shift @ARGV or die "need selector";
$directory = shift @ARGV or die "need directory";
$directory =~s /\/$//;

while(<>){
	chomp;
	push @url, $_;
}

system("mkdir -p '$directory'");

open FRAME,">",$directory."/index.html";
print FRAME <<FRAME;
<frameset cols="5%,95%">
	<frame src="left.html" name="left">
	<frame src="about:blank" name="right">
</frameset>
FRAME
close FRAME;

open LEFT,">",$directory."/left.html";
for(1..scalar(@url)){
	print LEFT <<LINK;
<a href="$_/index.html" target="right">[&nbsp;$_&nbsp;]<br>
LINK
}
close LEFT;

$c = 1;
for(@url){
	$command = "rip-block.pl '$_' '$selector' '$directory/$c'";
	print $command."\n";
	system($command);
	$c++;
}
