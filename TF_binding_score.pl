#!/usr/bin/perl
open(LST,"list.TF_peaks.txt") || die;
while(my $line=<LST>){
	chomp $line;
	my $protein=(split/_/,$line)[-3];
	
	my $total_info=`wc -l $line`;
	my $total_num=(split/\s+/,$total_info)[0];

	`bedtools intersect -b $line -a result1.strand_strong.bed -u > tmp.overlap`;
	my $count_info=`wc -l tmp.overlap`;
	my $overlap_num_strong=(split/\s+/,$count_info)[0];

	`bedtools intersect -b $line -a result1.strand_biased.bed -u > tmp.overlap`;
	my $count_info=`wc -l tmp.overlap`;
	my $overlap_num_biased=(split/\s+/,$count_info)[0];

	print $protein,"\t",$total_num,"\t",$overlap_num_strong,"\t",$overlap_num_biased,"\n";
	`rm -rf tmp.overlap`;
}
