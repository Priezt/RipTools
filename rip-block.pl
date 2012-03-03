#!/usr/bin/env perl

$url = shift @ARGV or die "need url";
$selector = shift @ARGV or die "need selector";
$directory = shift @ARGV or die "need directory";
$directory =~s /\/$//;

$title = `rip-title.py '$url' | cat`;
$text = `rip-text.py '$url' '$selector' | cat`;
$img_str = `rip-img.py '$url' '$selector img'`;
chomp($img_str);
@img = split /[\n\r]+/, $img_str;

system("mkdir -p '$directory'");

@new_img = ();
$c = 1;
for(@img){
	next unless /\.(\w+)$/;
	$ext = $1;
	$cmd = "wget -q -O '$directory'/$c.$ext '$_'";
	#print $cmd."\n";
	system($cmd);
	push @new_img, "$c.$ext";
	$c++;
}

$html = "<html>\n";
$html .= "<head><meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\"></head>\n";
$html .= "<body>\n";
$html .= "<a href=\"$url\" target=\"_blank\">".$title."</a><hr>\n";
$html .= $text."<hr>\n";
$c = 0;
for(@new_img){
	$html .= "<a href=\"".$img[$c]."\" target=\"_blank\"><img src=\"$_\"></a><br>\n";
	$c++;
}
$html .= "</body></html>";

open HTML,">",$directory."/index.html";
print HTML $html;
close HTML;

