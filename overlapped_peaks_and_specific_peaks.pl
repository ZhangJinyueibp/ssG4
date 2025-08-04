#!/usr/bin/perl
my %bigwig_files=(
"ssG4" => "out1.ssG4_merge.flt.clean.rmDup.nonStrand.bigwig",
"BG4" => "out1.BG4_merge.flt.clean.rmDup.bigwig"
);

my @region_files=(
"result1.BG4_shared.peak.bed",
"result1.BG4_unique.peak.bed",
"result1.ssG4_unique.peak.bed",
"result1.shuffle.peak.bed"
);

foreach my $s (keys %bigwig_files){
	my $bw=$bigwig_files{$s};
	foreach my $f (@region_files){
		my $g=$f;
		$g=~s/result1.//;
		$g=~s/result1.//;
		$g=~s/.peak.bed//;
		my $genomeSize="hg19.chrom.sizes";
		`perl creat_tss_bed.pl $f $genomeSize 1000 20 > gene_around.bed`;
		`bigWigAverageOverBed $bw gene_around.bed out2.$s.over.$g.tab`;
		`perl stat_ChIP_around_gene.pl out2.$s.over.$g.tab > out2.$s.over.$g.xls`;
		`perl tab_file_sum.pl out2.$s.over.$g.xls 0.05 > out2.$s.over.$g.avg.xls`;
	}
}
