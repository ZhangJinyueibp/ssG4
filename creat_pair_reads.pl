#!/usr/bin/perl
die "perl $0 read_1.fq read_2.fq read_1.non_rRNA.fq read_2.non_rRNA.fq\n" if(@ARGV != 4);
my $in_read1=shift;
my $in_read2=shift;
my $nonrRNA_read1=shift;
my $nonrRNA_read2=shift;

my %good_read1;
open(NRA,$nonrRNA_read1) || die;
while(my $id=<NRA>){
	<NRA>;<NRA>;<NRA>;
	chomp $id;
	my $name=(split/\s+/,$id)[0];
	$good_read1{$name}=1;
}

my %good_read2;
open(NRB,$nonrRNA_read2) || die;
while(my $id=<NRB>){
	<NRB>;<NRB>;<NRB>;
	chomp $id;
	my $name=(split/\s+/,$id)[0];
	$good_read2{$name}=1;
}

my $out_read1_pair=$in_read1;
my $out_read1_unpair=$in_read1;
my $out_read2_pair=$in_read2;
my $out_read2_unpair=$in_read2;

$out_read1_pair=~s/fq$/pair.fq/;
$out_read1_unpair=~s/fq$/unpair.fq/;
$out_read2_pair=~s/fq$/pair.fq/;
$out_read2_unpair=~s/fq$/unpair.fq/;

open(OUTAP,">$out_read1_pair") || die;
open(OUTAU,">$out_read1_unpair") || die;
open(OUTBP,">$out_read2_pair") || die;
open(OUTBU,">$out_read2_unpair") || die;

open(INA,$in_read1) || die;
while(my $ida=<INA>){
	my $seqa=<INA>;
	my $symbola=<INA>;
	my $quala=<INA>;
	chomp $ida;
	my $namea=(split/\s+/,$ida)[0];
	#print $ida,"\t",$good_read1{$ida},"\t",$good_read2{$idb},"\taa\n";
	if($good_read1{$namea} and $good_read2{$namea}){
		print OUTAP $ida,"\n",$seqa,$symbola,$quala;
	}
	elsif($good_read1{$namea} and !$good_read2{$namea}){
		print OUTAU $ida,"\n",$seqa,$symbola,$quala;
	}
	else{
		next;
	}
}
open(INB,$in_read2) || die;
while(my $idb=<INB>){
	my $seqb=<INB>;
	my $symbolb=<INB>;
	my $qualb=<INB>;
	chomp $idb;
	my $nameb=(split/\s+/,$idb)[0];
	if($good_read1{$nameb} and $good_read2{$nameb}){
		print OUTBP $idb,"\n",$seqb,$symbolb,$qualb;
	}
	elsif(!$good_read1{$nameb} and $good_read2{$nameb}){
		print OUTBU $idb,"\n",$seqb,$symbolb,$qualb;
	}
	else{
		next;
	}
}



close OUTAP;
close OUTAU;
close OUTBP;
close OUTBU;
