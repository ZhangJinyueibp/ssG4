#!/usr/bin/perl
die "perl $0 input_seq.tab\n" if(@ARGV != 1);
my $input_seq_tab=shift;

#define elements for G4 prediction
my $L7 = ".{1,7}?";	#the symbol "?" indicates non-greedy match
my $G3 = "G{3,}";
my $bulgeG = "GG[^G]GG?|GG?[^G]GG";
my $longLP = "G{3,}.{8,15}?G{3,}";

my $GQ = "$G3($L7$G3){3,3}";	#revised by caochch

my $bulge_A=             "($bulgeG)($L7$G3){3,3}";
my $bulge_B="($G3$L7){1,1}($bulgeG)($L7$G3){2,2}";
my $bulge_C="($G3$L7){2,2}($bulgeG)($L7$G3){1,1}";
my $bulge_D="($G3$L7){3,3}($bulgeG)";

my $long_loop_A=             "($longLP)($L7$G3){2,2}";
my $long_loop_B="($G3$L7){1,1}($longLP)($L7$G3){1,1}";
my $long_loop_C="($G3$L7){2,2}($longLP)";

my $gvbq_A=             "G{2}($L7$G3){3,3}";
my $gvbq_B="($G3$L7){1,1}G{2}($L7$G3){2,2}";
my $gvbq_C="($G3$L7){2,2}G{2}($L7$G3){1,1}";
my $gvbq_D="($G3$L7){3,3}G{2}";

my $nGLX = "[^G].{0,6}?";
my $LXnG = ".{0,6}?[^G]";
my $gvbq = "(GG($nGLX$G3|G{4})($L7$G3|G{4}){2}|($G3$LXnG|G{4})GG($nGLX$G3|G{4})($L7$G3|G{4})|($G3$L7|G{4})($G3$LXnG|G{4})GG($nGLX$G3|G{4})|($G3$L7|G{4}){2}($G3$LXnG|G{4})GG)";

my %all_G4_types=(
"4G" => $GQ,
"BulgeA" => $bulge_A,
"BulgeB" => $bulge_B,
"BulgeC" => $bulge_C,
"BulgeD" => $bulge_D,
"4GL15A" => $long_loop_A,
"4GL15B" => $long_loop_B,
"4GL15C" => $long_loop_C,
"GVBQA" => $gvbq_A,
"GVBQB" => $gvbq_B,
"GVBQC" => $gvbq_C,
"GVBQD" => $gvbq_D,
);

my @G4_types_priority=("4G","BulgeA","BulgeB","BulgeC","BulgeD","GVBQA","GVBQB","GVBQC","GVBQD","4GL15A","4GL15B","4GL15C");
#define over

#my $test_seq="GGGGGGGGTTGGGGGGG";	#4G
#my $test_seq="GGGAGGGAGGGGAAGGGAAGAAAAGGGAAGAGAAGGG";	#6G
#my $test_seq="GGGTGGTAGGTGCAGAGACGGGAGGGG";	#bulge
#my $test_seq="GGGGGCTCAGGCATGGCAGGGCTGGG";
#my $test_seq="GGGGGGTTGGGTGGG";
#my $test_seq="GGGCTGGGGAGTGTCATGGGGGTGGGG";
#my $test_seq="GGGCTGGGGAGTGTCATGGGGGTGGGGACAGGG";
#my $test_seq="AAAAAACCCAACCTACCCACTCAACCC";
#my $test_seq="GGGTTGAGTGGGTAGGTTGGG";
#my $test_seq="ACCCTAACCCTAACCCTAACCCTAACCCTAACCCT";
#my $test_seq="AGGGGGGCCTGGGCCCAGGGCTGGG";
#predict_G4($test_seq);
#exit;

open(IST,$input_seq_tab) || die;
while(my $line=<IST>){
	chomp $line;
	predict_G4($line);
}

sub predict_G4{
	my $raw_seq_line=shift;
	my ($raw_name,$raw_given_seq)=split/\s+/,$raw_seq_line;
	my $raw_seq_len=length($raw_given_seq);
	my %G4_loci;

	foreach my $type (keys %all_G4_types){
		my $input_seq=$raw_given_seq;
		my $class=$all_G4_types{$type};
		my $total_trimmed_len=0;
		while($input_seq=~/$class/){
			my $before=$`;
			my $match=$&;
			my $len_before=length($before);

			my $loci=$total_trimmed_len+$len_before;
			$G4_loci{$loci}{$match}{$type}{"+"}=1;

			if($match=~/^G+/){
				my $G_tracts=$&;
				my $trim_len=$len_before+length($G_tracts);
				substr($input_seq,0,$trim_len)="";
				$total_trimmed_len+=$trim_len;
			}
			else{
				die;
			}
		}
	}

	#print $input_seq,"\taa\n";
	foreach my $type (keys %all_G4_types){
		my $input_seq=reverse $raw_given_seq;
		$input_seq=~tr/ATCG/TAGC/;
		my $class=$all_G4_types{$type};
		my $total_trimmed_len=0;
                while($input_seq=~/$class/){
                        my $before=$`;
                        my $match=$&;
                        my $len_before=length($before);
			
			my $loci=$raw_seq_len-$total_trimmed_len-$len_before-length($match);
			$G4_loci{$loci}{$match}{$type}{"-"}=1;

                        if($match=~/^G+/){
                                my $G_tracts=$&;
                                my $trim_len=$len_before+length($G_tracts);
                                substr($input_seq,0,$trim_len)="";
				$total_trimmed_len+=$trim_len;
                        }
			else{
				die;
			}
                }
	}
	
	foreach my $loci (keys %G4_loci){
		foreach my $motif (keys %{$G4_loci{$loci}}){
			foreach my $type (@G4_types_priority){
				if(exists $G4_loci{$loci}{$motif}{$type}{"+"}){
					print $raw_name,"\t",$raw_seq_len,"\t",$loci,"\t",$motif,"\t",$type,"\t+\n";
					last;
				}
			}
			foreach my $type (@G4_types_priority){
				if(exists $G4_loci{$loci}{$motif}{$type}{"-"}){
					print $raw_name,"\t",$raw_seq_len,"\t",$loci,"\t",$motif,"\t",$type,"\t-\n";
					last;
				}
			}
		}
	}
}
	







