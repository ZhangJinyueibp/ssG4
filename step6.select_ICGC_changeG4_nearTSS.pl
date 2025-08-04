#!/usr/bin/perl
die "perl $0 result5.eQTL_enhance_G5.table out2.eQTL_TSS.overlap\n" if(@ARGV != 2);
my $eQTL_table=shift;
my $eQTL_gene_overlap=shift;

my %is_want_eQTL;
open(ET,$eQTL_table) || die;
while(my $line=<ET>){
	chomp $line;
	my @sub=split/\s+/,$line;
	if(exists $is_want_eQTL{$sub[3]}){
		die;
	}
	$is_want_eQTL{$sub[3]}=$sub[7]."\t".$sub[8];
}

open(EGO,$eQTL_gene_overlap) || die;
while(my $line=<EGO>){
	chomp $line;
	my @sub=split/\s+/,$line;
	if(exists $is_want_eQTL{$sub[3]}){
		print $line,"\t",$is_want_eQTL{$sub[3]},"\n";
	}
}

	
