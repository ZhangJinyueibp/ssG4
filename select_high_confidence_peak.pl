#!/usr/bin/perl
die "perl $0 tmp.rep1_have.list tmp.rep2_have.list tmp.rep3_have.list fwd/rev\n" if(@ARGV != 4);
my $peak_count_rep1=shift;
my $peak_count_rep2=shift;
my $peak_count_rep3=shift;
my $strand=shift;

my %all_peak;
my %rep1_peak_count=read_peak_count_table($peak_count_rep1);
my %rep2_peak_count=read_peak_count_table($peak_count_rep2);
my %rep3_peak_count=read_peak_count_table($peak_count_rep3);

my $peak_index;
foreach (sort keys %all_peak){
	if(!exists $rep1_peak_count{$_} or !exists $rep2_peak_count{$_} or !exists $rep3_peak_count{$_}){
		warn $_,"\taa\n";
		die;
	}
	my $repeated_times;
	if($rep1_peak_count{$_} > 0){
		$repeated_times++;
	}
	if($rep2_peak_count{$_} > 0){
		$repeated_times++;
	}
	if($rep3_peak_count{$_} > 0){
		$repeated_times++;
	}
	$peak_index++;
	print $_,"\t";
	print $strand,$peak_index,"\t";
	print $repeated_times,"\t";
	if($strand eq "fwd"){
		print "+\t";
	}
	elsif($strand eq "rev"){
		print "-\t";
	}
	else{
		die;
	}
	print $rep1_peak_count{$_},",",$rep2_peak_count{$_},",",$rep3_peak_count{$_},"\n";
}



sub read_peak_count_table{
	my $file=shift;
	my %hash;
	open(IN,$file) || die;
	while(my $line=<IN>){
		chomp $line;
		my @sub=split/\s+/,$line;
		my $peak=join"\t",@sub[0..2];
		$hash{$peak}=$sub[3];
		$all_peak{$peak}=1;
	}
	return %hash;
}
