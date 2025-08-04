#!/usr/bin/perl
die "perl $0 result3.eQRT_around.Ref.G4_loci.list result3.eQRT_around.mut.G4_loci.list\n" if(@ARGV != 4);
my $ref_G4_loci=shift;
my $mut_G4_loci=shift;
my $ref_SP1_binding=shift;
my $mut_SP1_binding=shift;

my %all_eQTL;
my %G4_span_bases_ref=sum_G4_span_len($ref_G4_loci);
my %G4_span_bases_mut=sum_G4_span_len($mut_G4_loci);
my %SP1_binding_ref=sum_SP1_binding_score($ref_SP1_binding);
my %SP1_binding_mut=sum_SP1_binding_score($mut_SP1_binding);

my %uniq_mutant;
foreach (sort keys %all_eQTL){
	my $ref_to_mut=(split/#/,$_)[4];
	if(exists $uniq{$ref_to_mut}){
		next;
	}
	$uniq{$ref_to_mut}=1;

	#print $_,"\t",$numG4_span_mutLoci_ref{$_}+0,"\t",$numG4_span_mutLoci_mut{$_}+0,"\n";
	my @spaned_bases_ref=keys %{$G4_span_bases_ref{$_}};
	my @spaned_bases_mut=keys %{$G4_span_bases_mut{$_}};
	print $_,"\t",$#spaned_bases_ref+1,"\t",$#spaned_bases_mut+1,"\t";
	print $SP1_binding_ref{$_},"\t",$SP1_binding_mut{$_},"\n";

}

sub sum_SP1_binding_score{
	my $file=shift;
	my %hash;
	open(IN,$file) || die;
	while(my $line=<IN>){
		chomp $line;
		my @sub=split/\s+/,$line;
		$all_eQTL{$sub[0]}=1;
		$hash{$sub[0]}=$sub[3];
	}
	close IN;
	return %hash;
}

sub sum_G4_span_len{
	my $file=shift;
	my %hash;
	open(IN,$file) || die;
	while(my $line=<IN>){
		chomp $line;
		my @sub=split/\s+/,$line;
		$all_eQTL{$sub[0]}=1;
		foreach ($sub[2]+1..$sub[2]+length($sub[3])){
			$hash{$sub[0]}{$_}=1;
		}
	}
	close IN;
	return %hash;
}
			


sub count_G4_span_mutLoci{
	my $file=shift;
	my %hash;
	open(IN,$file) || die;
	while(my $line=<IN>){
		chomp $line;
		my @sub=split/\s+/,$line;
		$all_eQTL{$sub[0]}=1;
		if($sub[2] >= $sub[1]-50){
			next;
		}
		if($sub[2]+length($sub[3]) <= 50){
			next;
		}
		$hash{$sub[0]}++;
	}
	close IN;
	return %hash;
}
