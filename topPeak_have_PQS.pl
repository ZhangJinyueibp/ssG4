#!/usr/bin/perl
my $signal_to_input_table="result2.to_input.ratio.xls";
my $peak_bed="out3.ssG4_merge.flt.clean.rmDup_peaks.peak.anno.highconf.bed";
my $pqs_bed="GSE133379_PQS-hg19.bed";

my %peak_value;
my $max_value;

open(SIT,$signal_to_input_table) || die;
while(my $line=<SIT>){
	chomp $line;
	my @sub=split/\s+/,$line;
	if($sub[2] > $max_value){
		$max_value=$sub[2];
	}
	$peak_value{$sub[0]}=$sub[2];
}

foreach (keys %peak_value){
	if($peak_value{$_} eq "Inf"){
		$peak_value{$_}=$max_value;
	}
}

my %peak_loci;
open(PB,$peak_bed) || die;
while(my $line=<PB>){
	chomp $line;
	my @sub=split/\s+/,$line;
	$peak_loci{$sub[3]}=$line;
}

my @get_num=(1000,2000,3000,4000,5000,6000,7000,8000,9000,10000,11000,12000,13000);
foreach my $n (@get_num){
	open(TMP,">tmp.peak.bed") || die;
	my $tmp_count;
	foreach (sort{$peak_value{$b} <=>$peak_value{$a}} keys %peak_value){
		print TMP $peak_loci{$_},"\n";
		$tmp_count++;
		if($tmp_count >= $n){
			last;
		}
	}
	close TMP;
	my $res=`bedtools intersect -a tmp.peak.bed -b GSE133379_PQS-hg19.bed -u | wc -l`;
	print $n,"\t",$res;
}

	
