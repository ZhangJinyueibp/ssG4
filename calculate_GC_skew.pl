#!/usr/bin/perl
die "perl $0 out2.potentialG4sites.classified.fa input.bed\n" if(@ARGV != 2);
my $input_fa=shift;
my $sites_bed=shift;

$/=">";
open(IF,$input_fa) || die;
<IF>;
while(my $block=<IF>){
	chomp $block;
	my @lines=split/\n/,$block;
	my $first=shift @lines;
	my $seq=join"",@lines;
	my $id;
	if($first=~/(.+)::chr/){
		$id=$1;
	}
	else{
		die;
	}
	my $gc_skew;
	$seq=uc($seq);
	my $gg+=($seq=~s/G/G/g);
	my $cc+=($seq=~s/C/C/g);
	if($gg+$cc < 10){
		next;
	}
	$gc_skew=($gg-$cc)/($gg+$cc);
	$site_gc_skew{$id}=$gc_skew;
}
$/="\n";

open(SB,$sites_bed) || die;
while(my $line=<SB>){
	chomp $line;
	my @sub=split/\s+/,$line;
	print $line,"\t";
	if(!exists $site_gc_skew{$sub[3]}){
		die;
	}
	my ($fwd,$rev)=split/,/,$sub[9];
	if($rev>0){
		my $ratio=$fwd/$rev;
		print $ratio,"\t";
	}
	else{
		print "Inf\t";
	}
	print $site_gc_skew{$sub[3]},"\n";
}
