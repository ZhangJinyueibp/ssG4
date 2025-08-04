#!/usr/bin/perl
my @samples=(
"1.ssG4_rep1",
"2.ssG4_rep2",
"3.ssG4_rep3",
"4.Input_rep1",
);

open(TSH,">run.sh") || die;
foreach my $d (@samples){
	`mkdir $d`;
	my $tmp_raw_list=`ls ../1.rawdata/$d/*gz`;
	chomp $tmp_raw_list;
	my @tmp_raw_files=split/\n/,$tmp_raw_list;
	foreach (@tmp_raw_files){
		`ln -s ../$_ ./$d`;
	}
    my $file_list=`ls ./$d/*gz`;
    my @files=split/\n/,$file_list;
	my %command;
    foreach my $p (@files){
		my $f=(split/\//,$p)[-1];
        if($f=~/.*_1.fq/){
			$command{1}="gzip -d -c ./$d/$f > ./$d/read_1.fq &\n";
        }
        elsif($f=~/.*_2.fq/){
			$command{3}="gzip -d -c ./$d/$f > ./$d/read_2.fq\n";
		}
        else{
             die;
        }
    }

	foreach (sort {$a <=> $b} keys %command){
		print TSH $command{$_};
	}
    print TSH "fastqc ./$d/read_1.fq -o ./$d &\n";
    print TSH "fastqc ./$d/read_2.fq -o ./$d &\n";
    print TSH "java -jar /media/ibm_disk/work/caochch/Software/Trimmomatic-0.36/trimmomatic-0.36.jar  PE -phred33 -threads 20 -quiet ./$d/read_1.fq ./$d/read_2.fq ./$d/read_1.clean.pair.fq ./$d/read_1.clean.unpair.fq ./$d/read_2.clean.pair.fq ./$d/read_2.clean.unpair.fq ILLUMINACLIP:/media/ibm_disk/work/zhangjy/Software/Trimmomatic-0.36/adapters/TruSeq3-PE-2.fa:2:30:10:8:true LEADING:15 TRAILING:10 SLIDINGWINDOW:4:15 MINLEN:30\n";

	print TSH "cutadapt -j 10 -g G{150} -e 0.15 -n 3 -m 30 -o ./$d/read_2.clean.pair.rmPoly.fq ./$d/read_2.clean.pair.fq\n";
	print TSH "cutadapt -j 10 -u 10 -m 30 -o ./$d/read_2.clean.pair.rmPoly.trim.fq ./$d/read_2.clean.pair.rmPoly.fq\n";
	print TSH "cutadapt -j 10 -a C{150} -e 0.15 -n 3 -m 30 -o ./$d/read_1.clean.pair.rmPoly.fq ./$d/read_1.clean.pair.fq\n";
	print TSH "cutadapt -j 10 -u -10 -m 30 -o ./$d/read_1.clean.pair.rmPoly.trim.fq ./$d/read_1.clean.pair.rmPoly.fq \n";

	print TSH "perl creat_pair_reads.pl ./$d/read_1.clean.pair.rmPoly.trim.fq ./$d/read_2.clean.pair.rmPoly.trim.fq ./$d/read_1.clean.pair.rmPoly.trim.fq ./$d/read_2.clean.pair.rmPoly.trim.fq\n";

	print TSH "fastqc -t 2 ./$d/read_1.clean.pair.rmPoly.trim.pair.fq ./$d/read_2.clean.pair.rmPoly.trim.pair.fq &\n";

	print TSH "bwa mem -t 16 GRCh37.p13.genome.fa ./$d/read_1.clean.pair.rmPoly.trim.pair.fq ./$d/read_2.clean.pair.rmPoly.trim.pair.fq > ./$d/$d.sam\n";
	print TSH "samtools view -bSo ./$d/$d.bam ./$d/$d.sam\n";
	print TSH "samtools sort ./$d/$d.bam ./$d/$d.sort\n";
	print TSH "samtools view -h -q 10 -b ./$d/$d.sort.bam > ./$d/$d.flt.bam\n";
	print TSH "java -jar picard.jar CleanSam I=./$d/$d.flt.bam O=./$d/$d.flt.clean.bam\n";
	print TSH "java -jar picard.jar MarkDuplicates I=./$d/$d.flt.clean.bam O=./$d/$d.flt.clean.rmDup.bam M=./$d/$d.rmDup.metrics.txt REMOVE_DUPLICATES=true\n";
	print TSH "samtools index ./$d/$d.flt.clean.rmDup.bam\n";
	
	

	print TSH "bedtools genomecov -scale 1 -bg -split -ibam ./$d/$d.flt.clean.rmDup.bam -g hg19.chrom.sizes > ./$d/$d.bdg\n";
	print TSH "cat ./$d/$d.bdg | LC_COLLATE=C sort -k1,1 -k2,2n > ./$d/$d.sort.bdg \n";
	print TSH "bedGraphToBigWig ./$d/$d.sort.bdg hg19.chrom.sizes ./$d/$d.raw.bigwig\n";
}
