cat 1.ssG4_rep1.flt.clean.rmDup_peaks.narrowPeak 2.ssG4_rep2.flt.clean.rmDup_peaks.narrowPeak 3.ssG4_rep3.flt.clean.rmDup_peaks.narrowPeak | bedtools sort -i - | bedtools merge -i - > out1.ssG4_merge.flt.clean.rmDup_peaks.peak.bed

bedtools intersect -a out1.ssG4_merge.flt.clean.rmDup_peaks.peak.bed -b 1.ssG4_rep1.flt.clean.rmDup_peaks.narrowPeak -c > tmp.rep1_have.list
bedtools intersect -a out1.ssG4_merge.flt.clean.rmDup_peaks.peak.bed -b 2.ssG4_rep2.flt.clean.rmDup_peaks.narrowPeak -c > tmp.rep2_have.list
bedtools intersect -a out1.ssG4_merge.flt.clean.rmDup_peaks.peak.bed -b 3.ssG4_rep3.flt.clean.rmDup_peaks.narrowPeak -c > tmp.rep3_have.list

perl select_high_confidence_peak.pl tmp.rep1_have.list tmp.rep2_have.list tmp.rep3_have.list fwd > out2.ssG4_merge.flt.clean.rmDup_peaks.peak.anno.bed

awk '{if($5 > 2){print $0}}' out2.ssG4_merge.flt.clean.rmDup_peaks.peak.anno.bed > out3.ssG4_merge.flt.clean.rmDup_peaks.peak.anno.highconf.bed



