#!/usr/bin/perl
die "perl $0 input.bed\n" if(@ARGV != 1); 
my $sites_index;
open(IN,$ARGV[0]) || die;
while(my $line=<IN>){
	chomp $line;
	my @sub=split/\s+/,$line;
	my $new=join"\t",@sub[0..3];
	print $new,"\n";
}
