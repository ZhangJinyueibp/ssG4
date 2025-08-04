#!/usr/bin/perl
die "perl $0 result2.eQRT_around.Ref.fa\n" if(@ARGV != 1);
my $eQTL_stream_fasta=shift;

my $different_count=0;
my $same_count=0;
open(ESF,$eQTL_stream_fasta) || die;
while(my $line=<ESF>){
	chomp $line;
	my ($name,$ref_seq)=split/\s+/,$line;
	my ($eQTL_info,$loci)=split/::/,$name;
	my @eQTL_info_arr=split/#/,$eQTL_info;
	my $eQTL_type=$eQTL_info_arr[0];
	
	my $region_chr;
	my $region_start;
	my $region_end;
	if($loci=~/(chr.+):(\d+)-(\d+)/){
		$region_chr=$1;
		$region_start=$2;
		$region_end=$3;
	}
	else{
		die;	
	}

	my ($ref_allele,$mut_allele)=split/->/,$eQTL_info_arr[4];
	if($eQTL_type eq "ins"){
		if($mut_allele!~/^[ATCG]+$/){
			die;
		}
		my $relative_loci=$eQTL_info_arr[2]-$region_start;
		my $ref_allele_reGet=substr($ref_seq,$relative_loci,1);	
		substr($ref_seq,$relative_loci,1)=$ref_allele_reGet.$mut_allele;
		print $name,"\t",$ref_seq,"\n";
	}
	elsif($eQTL_type eq "del"){
		if($ref_allele!~/^[ATCG]+$/){
			die;
		}
		my $relative_loci=$eQTL_info_arr[2]-$region_start;
		if($relative_loci != 50){
			die;
		}
		my $ref_allele_reGet=substr($ref_seq,$relative_loci,length($ref_allele));
		if($ref_allele_reGet ne $ref_allele){
			die;
		}
		substr($ref_seq,$relative_loci,length($ref_allele))="";
		print $name,"\t",$ref_seq,"\n";
	}
	elsif($eQTL_type =~ /NV/){
		if($ref_allele!~/^[ATCG]+$/ or $mut_allele!~/^[ATCG]+$/){
			die;
		}
	
		my $relative_loci=$eQTL_info_arr[2]-$region_start;
		if($relative_loci != 50){
			die;
		}
		my $ref_allele_reGet=substr($ref_seq,$relative_loci,length($ref_allele));
	
		if($ref_allele_reGet ne $ref_allele){
			die;
		}
		#print $name,"\t",$ref_seq,"\n";
		substr($ref_seq,$relative_loci,length($ref_allele))=$mut_allele;
		print $name,"\t",$ref_seq,"\n";
	}
	else{
		die;
	}
}
warn $same_count,"\t",$different_count,"\n";
