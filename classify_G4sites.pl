#!/usr/bin/perl
die "perl $0 out1.fwd_on_sites.tab out1.rev_on_sites.tab input.sites\n" if(@ARGV != 3);
my $fwd_count_table=shift;
my $rev_count_table=shift;
my $input_sites_bed=shift;

my %coverage_fwd;
open(FCT,$fwd_count_table) || die;
while(my $line=<FCT>){
	chomp $line;
	my @sub=split/\s+/,$line;
	$coverage_fwd{$sub[0]}=$sub[4];
}

my %coverage_rev;
open(RCT,$rev_count_table) || die;
while(my $line=<RCT>){
	chomp $line;
	my @sub=split/\s+/,$line;
	$coverage_rev{$sub[0]}=$sub[4];
}

open(ISB,$input_sites_bed) || die;
while(my $line=<ISB>){
	chomp $line;
	my @sub=split/\s+/,$line;
	if(!exists $coverage_fwd{$sub[3]} or !exists $coverage_rev{$sub[3]}){
		die;
	}
	my $class;
	if($coverage_fwd{$sub[3]} > 2*$coverage_rev{$sub[3]}){
		print $line,"\t1\t+\t",$coverage_fwd{$sub[3]},",",$coverage_rev{$sub[3]},"\n";
	}
	elsif($coverage_fwd{$sub[3]} > $coverage_rev{$sub[3]}){
		print $line,"\t2\t+\t",$coverage_fwd{$sub[3]},",",$coverage_rev{$sub[3]},"\n";
	}
	elsif($coverage_fwd{$sub[3]} <= 0.5*$coverage_rev{$sub[3]}){
		print $line,"\t1\t-\t",$coverage_fwd{$sub[3]},",",$coverage_rev{$sub[3]},"\n";
	}
	else{
		print $line,"\t2\t-\t",$coverage_fwd{$sub[3]},",",$coverage_rev{$sub[3]},"\n";
	}
}

