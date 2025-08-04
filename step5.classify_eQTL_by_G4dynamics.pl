#!/usr/bin/perl
die "perl $0 result4.eQRT_around.ref_vs_mut.G4_bases.xls result0.ICGC.nonPCRNA.in_G4.bed\n" if(@ARGV != 2);
my $G4_dynamics_compare_table=shift;
my $ICGC_table=shift;

my %ICGC_enhance_G4;
my %ICGC_repress_G4;
open(GDCT,$G4_dynamics_compare_table) || die;
while(my $line=<GDCT>){
	chomp $line;
	my @sub=split/\s+/,$line;
	my $ref_to_mut=(split/#/,$sub[0])[4];
	if($sub[2]-$sub[1] >= 15){
		if($sub[4]-$sub[3] >= 0.5){
			$ICGC_enhance_G4_increase_SP1{$ref_to_mut}=$sub[1]."->".$sub[2]."\t".$sub[3]."->".$sub[4];
		}
		elsif($sub[4]-$sub[3] <= -0.5){
			$ICGC_enhance_G4_decrease_SP1{$ref_to_mut}=$sub[1]."->".$sub[2]."\t".$sub[3]."->".$sub[4];
		}
		else{
			$ICGC_enhance_G4_noChange_SP1{$ref_to_mut}=$sub[1]."->".$sub[2]."\t".$sub[3]."->".$sub[4];
		}
			
	}
	elsif($sub[2]-$sub[1] <= -15){
		if($sub[4]-$sub[3] >= 0.5){
			$ICGC_repress_G4_increase_SP1{$ref_to_mut}=$sub[1]."->".$sub[2]."\t".$sub[3]."->".$sub[4];
		}
		elsif($sub[4]-$sub[3] <= -0.5){
			$ICGC_repress_G4_decrease_SP1{$ref_to_mut}=$sub[1]."->".$sub[2]."\t".$sub[3]."->".$sub[4];
		}
		else{
			$ICGC_repress_G4_noChange_SP1{$ref_to_mut}=$sub[1]."->".$sub[2]."\t".$sub[3]."->".$sub[4];
		}
	}
	else{
		if($sub[4]-$sub[3] >= 0.5){
			$ICGC_noChange_G4_increase_SP1{$ref_to_mut}=$sub[1]."->".$sub[2]."\t".$sub[3]."->".$sub[4];
		}
		elsif($sub[4]-$sub[3] <= -0.5){
			$ICGC_noChange_G4_decrease_SP1{$ref_to_mut}=$sub[1]."->".$sub[2]."\t".$sub[3]."->".$sub[4];
		}	
		else{
			$ICGC_noChange_G4_noChange_SP1{$ref_to_mut}=$sub[1]."->".$sub[2]."\t".$sub[3]."->".$sub[4];
		}
			
	}
}

open(OUTA,">result5.ICGC.enhance_G4.increase_SP1.table") || die;
open(OUTB,">result5.ICGC.enhance_G4.decrease_SP1.table") || die;
open(OUTC,">result5.ICGC.enhance_G4.noChange_SP1.table") || die;

open(OUTD,">result5.ICGC.repress_G4.increase_SP1.table") || die;
open(OUTE,">result5.ICGC.repress_G4.decrease_SP1.table") || die;
open(OUTF,">result5.ICGC.repress_G4.noChange_SP1.table") || die;

open(OUTG,">result5.ICGC.noChange_G4.increase_SP1.table") || die;
open(OUTH,">result5.ICGC.noChange_G4.decrease_SP1.table") || die;
open(OUTI,">result5.ICGC.noChange_G4.noChange_SP1.table") || die;

open(ET,$ICGC_table) || die;
while(my $line=<ET>){
	chomp $line;
	my @sub=split/\s+/,$line;
	$sub[1]=$sub[1]-50;
	$sub[2]=$sub[2]+50;
	if($sub[5] eq "ins"){
		$sub[2]=$sub[2]-1;
	}
	my $ref_to_mut=$sub[4]."::".$sub[0].":".$sub[1]."-".$sub[2];
	if(exists $ICGC_enhance_G4_increase_SP1{$ref_to_mut}){
		print OUTA $line,"\t",$ICGC_enhance_G4_increase_SP1{$ref_to_mut},"\n";
		next;
	}
	if(exists $ICGC_enhance_G4_decrease_SP1{$ref_to_mut}){
		print OUTB $line,"\t",$ICGC_enhance_G4_decrease_SP1{$ref_to_mut},"\n";
		next;
	}
	if(exists $ICGC_enhance_G4_noChange_SP1{$ref_to_mut}){
		print OUTC $line,"\t",$ICGC_enhance_G4_noChange_SP1{$ref_to_mut},"\n";
		next;
	}
	if(exists $ICGC_repress_G4_increase_SP1{$ref_to_mut}){
		print OUTD $line,"\t",$ICGC_repress_G4_increase_SP1{$ref_to_mut},"\n";
		next;
	}
	if(exists $ICGC_repress_G4_decrease_SP1{$ref_to_mut}){
		print OUTE $line,"\t",$ICGC_repress_G4_decrease_SP1{$ref_to_mut},"\n";
		next;
	}
	if(exists $ICGC_repress_G4_noChange_SP1{$ref_to_mut}){
		print OUTF $line,"\t",$ICGC_repress_G4_noChange_SP1{$ref_to_mut},"\n";
		next;
	}
	if(exists $ICGC_noChange_G4_increase_SP1{$ref_to_mut}){
		print OUTG $line,"\t",$ICGC_noChange_G4_increase_SP1{$ref_to_mut},"\n";
		next;
	}
	if(exists $ICGC_noChange_G4_decrease_SP1{$ref_to_mut}){
		print OUTH $line,"\t",$ICGC_noChange_G4_decrease_SP1{$ref_to_mut},"\n";
		next;
	}
	if(exists $ICGC_noChange_G4_noChange_SP1{$ref_to_mut}){
		print OUTI $line,"\t",$ICGC_noChange_G4_noChange_SP1{$ref_to_mut},"\n";
		next;
	}
	die;
} 
	








