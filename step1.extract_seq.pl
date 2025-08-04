#!/usr/bin/perl
die "perl $0 zz.out1.ICGC.bed chrom_size GRCh37.p13.genome.clean.fa\n" if(@ARGV != 3);
my $ICGC_bed=shift;
my $chrom=shift;
my $genomeFa=shift;

my %chr_size;
open(CS,$chrom) || die;
while(my $line=<CS>){
        chomp $line;
        my @sub=split/\s+/,$line;
        $chr_size{$sub[0]}=$sub[1];
}

open(OUT,">result1.ICGC_around.bed") || die;
open(EB,$ICGC_bed) || die;
while(my $line=<EB>){
	chomp $line;
	my @sub=split/\s+/,$line;
	my $start=$sub[1]-50;
	my $end=$sub[2]+50;
	
	if($sub[5] =~ /ins/){
		$end=$end-1;
	}

	if($start < 0 or $end > $chr_size{$sub[0]}){
		next;
	}

	print OUT $sub[0],"\t",$start,"\t",$end,"\t",$sub[5],"#",$sub[3],"#",$sub[1],"#",$sub[2],"#",$sub[4],"\n";
}
close OUT;

`bedtools getfasta -fi $genomeFa -bed result1.ICGC_around.bed -fo result2.ICGC_around.Ref.fa -tab -name+`;
