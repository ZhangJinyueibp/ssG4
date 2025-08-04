bedtools intersect -a 1.ssG4_rep1.flt.clean.rmDup.bam -b 1.ssG4_rep1.flt.clean.rmDup_peaks.narrowPeak -u > 1.ssG4_rep1.flt.clean.rmDup.inPeak.bam
samtools view -c 1.ssG4_rep1.flt.clean.rmDup.bam
samtools view -c 1.ssG4_rep1.flt.clean.rmDup.inPeak.bam
bedtools intersect -a 2.ssG4_rep2.flt.clean.rmDup.bam -b 2.ssG4_rep2.flt.clean.rmDup_peaks.narrowPeak -u > 2.ssG4_rep2.flt.clean.rmDup.inPeak.bam
samtools view -c 2.ssG4_rep2.flt.clean.rmDup.bam 
samtools view -c 2.ssG4_rep2.flt.clean.rmDup.inPeak.bam
bedtools intersect -a 3.ssG4_rep3.flt.clean.rmDup.bam -b 3.ssG4_rep3.flt.clean.rmDup_peaks.narrowPeak -u > 3.ssG4_rep3.flt.clean.rmDup.inPeak.bam
samtools view -c 3.ssG4_rep3.flt.clean.rmDup.bam
samtools view -c 3.ssG4_rep3.flt.clean.rmDup.inPeak.bam