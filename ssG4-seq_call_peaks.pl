#!/usr/bin/perl
my @samples=(
"1.ssG4_rep1",
"2.ssG4_rep2",
"3.ssG4_rep3",
);

open(TSH,">run.sh") || die;
foreach my $d (@samples){
	print TSH "macs2 callpeak -t $d.flt.clean.rmDup.bam -c Input.flt.clean.rmDup.bam -f BAMPE -n $d.flt.clean.rmDup -g hs --nomodel --keep-dup all -p 0.00001\n";
}
