#!/usr/bin/perl
open(LST,"list.TF_peaks.txt") || die;
while(my $line=<LST>){
	chomp $line;
	my $protein=(split/_/,$line)[-3];

	my $total_info=`wc -l $line`;
	`bedtools intersect -a $line -b out3.ssG4_merge.flt.clean.rmDup_peaks.peak.anno.highconf.bed -u > tmp.overlap`;
	my $count_info=`wc -l tmp.overlap`;

	my $total_num=(split/\s+/,$total_info)[0];
1	my $overlap_num=(split/\s+/,$count_info)[0];
	print $protein,"\t",$total_num,"\t",$overlap_num,"\t";
	my $ratio=$overlap_num/$total_num;
	print $ratio,"\n";
	`rm -rf tmp.overlap`;
	#last;
}
