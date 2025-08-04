#!/usr/bin/perl
die "perl $0 <some_gene.bed> <hg19.chrom.sizes> <stream_len> <stream_bin_len>\n" if(@ARGV != 4);
my $peak_bed=shift;
my $chrom=shift;
my $stream_len=shift;
my $stream_bin_len=shift;
my $stream_bin_num=int($stream_len/$stream_bin_len);

my %chr_size;
open(CS,$chrom) || die;
while(my $line=<CS>){
	chomp $line;
	my @sub=split/\s+/,$line;
	$chr_size{$sub[0]}=$sub[1];
}

my $peak_id;
open(PB,$peak_bed) || die;
while(my $line=<PB>){
	chomp $line;
	my ($chr,$tmp_start,$tmp_end,$type,$name,$strand)=split/\s+/,$line;
	my $start=int(($tmp_start+$tmp_end)/2);
	my $end=$start;
	if($start < $stream_len or $start > $chr_size{$chr}-$stream_len){
		next;
	}
	else{
		$peak_id++;
		if($strand eq "+"){
			my $tab_id;
			foreach (1..$stream_bin_num){
				$tab_id++;
				my $tab_start=$start-($stream_bin_num-$_+1)*$stream_bin_len;
				my $tab_end=$tab_start+$stream_bin_len-1;
				$tab_start--;
				print $chr,"\t",$tab_start,"\t",$tab_end,"\t",$peak_id,"_",$tab_id,"_",$strand,"\n";
			}
			foreach (1..$stream_bin_num){
				$tab_id++;
				my $tab_start=$start+($_-1)*$stream_bin_len;
				my $tab_end=$tab_start+$stream_bin_len-1;
				$tab_start--;
				print $chr,"\t",$tab_start,"\t",$tab_end,"\t",$peak_id,"_",$tab_id,"_",$strand,"\n";
			}
		}
		else{
	                my $tab_id;
	                foreach (1..$stream_bin_num){
	                        $tab_id++;
	                        my $tab_start=$end-($stream_bin_num-$_+1)*$stream_bin_len;
	                        my $tab_end=$tab_start+$stream_bin_len-1;
	                        $tab_start--;
	                        print $chr,"\t",$tab_start,"\t",$tab_end,"\t",$peak_id,"_",$tab_id,"_",$strand,"\n";
	                }
	                foreach (1..$stream_bin_num){
	                        $tab_id++;
	                        my $tab_start=$end+1+($_-1)*$stream_bin_len;
	                        my $tab_end=$tab_start+$stream_bin_len-1;
	                        $tab_start--;
	                        print $chr,"\t",$tab_start,"\t",$tab_end,"\t",$peak_id,"_",$tab_id,"_",$strand,"\n";
			}
                }

	
	}
}
