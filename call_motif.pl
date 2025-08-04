#!/usr/bin/perl
my @bed_files=(
"out3.ssG4_merge.flt.clean.rmDup.fwd_peaks.peak.anno.highconf.bed",
"out3.ssG4_merge.flt.clean.rmDup_peaks.peak.anno.highconf.bed",
"out3.ssG4_merge.flt.clean.rmDup.rev_peaks.peak.anno.highconf.bed"
);

foreach my $bed (@bed_files){
	my $prefix=$bed;
	$prefix=~s/out3.ssG4_merge.flt.clean.//;
	$prefix=~s/.anno.highconf.bed//;
	print "bedtools getfasta -fi GRCh37.p13.genome.fa -bed $bed -s -name+ -fo result2.$prefix.fa\n";
	`mkdir ./by_meme_$prefix`;
	#-revcomp is only set for unstrand
	print "meme result2.$prefix.fa -oc ./by_meme_$prefix -revcomp -dna -nmotifs 10 -evt 0.01 -minw 3 -maxw 12 -p 10\n";
}
