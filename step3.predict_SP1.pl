#!/usr/bin/perl
die "perl $0 input_seq.tab SELEX_SP1_table\n" if(@ARGV != 2);
my $input_seq_tab=shift;
my $SELEX_SP1_table=shift;

my %SP1_kmer_score;
my $max_kmer_score;
open(SST,$SELEX_SP1_table) || die;
while(my $line=<SST>){
	chomp $line;
	my @sub=split/\s+/,$line;
	$SP1_kmer_score{$sub[0]}=$sub[1];
	if($sub[1] > $max_kmer_score){
		$max_kmer_score=$sub[1];
	}
}

foreach (keys %SP1_kmer_score){
	$SP1_kmer_score{$_}=$SP1_kmer_score{$_}/$max_kmer_score;
}

open(IST,$input_seq_tab) || die;
while(my $line=<IST>){
        chomp $line;
	my $total_kmer_score;
	my ($raw_name,$raw_given_seq)=split/\s+/,$line;
	my $raw_seq_len=length($raw_given_seq);
	$raw_given_seq=uc($raw_given_seq);

	my $input_seq=$raw_given_seq;
	foreach (0..length($input_seq)-10){
		my $kmer=substr($input_seq,$_,10);
		#warn $kmer,"\t",$SP1_kmer_score{$kmer},"\n";
		$total_kmer_score+=$SP1_kmer_score{$kmer};
	}

	my $input_seq=reverse $raw_given_seq;
        $input_seq=~tr/ATCG/TAGC/;
	foreach (0..length($input_seq)-10){
		my $kmer=substr($input_seq,$_,10);
		#warn $kmer,"\t",$SP1_kmer_score{$kmer},"\n";
		$total_kmer_score+=$SP1_kmer_score{$kmer};
	}
	print $raw_name,"\t",$raw_given_seq,"\t",$raw_seq_len,"\t",$total_kmer_score,"\n";
}






