bedtools intersect -a ENCFF545HSY_SP1_peaks_narrowPeak.bed -b out3.ssG4_merge.flt.clean.rmDup_peaks.peak.anno.highconf.bed -u | wc -l
bedtools intersect -a ENCFF545HSY_SP1_peaks_narrowPeak.bed -b out3.ssG4_merge.flt.clean.rmDup_peaks.peak.anno.highconf.bed -v | wc -l
bedtools intersect -b ENCFF545HSY_SP1_peaks_narrowPeak.bed -a out3.ssG4_merge.flt.clean.rmDup_peaks.peak.anno.highconf.bed -u | wc -l
bedtools intersect -b ENCFF545HSY_SP1_peaks_narrowPeak.bed -a out3.ssG4_merge.flt.clean.rmDup_peaks.peak.anno.highconf.bed -v | wc -l

echo "----------";
bedtools intersect -a GSE128106_ChIPseq_YY1_Combined_peaks.bed -b out3.ssG4_merge.flt.clean.rmDup_peaks.peak.anno.highconf.bed -u | wc -l
bedtools intersect -a GSE128106_ChIPseq_YY1_Combined_peaks.bed -b out3.ssG4_merge.flt.clean.rmDup_peaks.peak.anno.highconf.bed -v | wc -l
bedtools intersect -b GSE128106_ChIPseq_YY1_Combined_peaks.bed -a out3.ssG4_merge.flt.clean.rmDup_peaks.peak.anno.highconf.bed -u | wc -l
bedtools intersect -b GSE128106_ChIPseq_YY1_Combined_peaks.bed -a out3.ssG4_merge.flt.clean.rmDup_peaks.peak.anno.highconf.bed -v | wc -l

echo "----------";
bedtools intersect -a ENCFF821SUV_ZNF507_peaks_narrowPeak.bed -b out3.ssG4_merge.flt.clean.rmDup_peaks.peak.anno.highconf.bed -u | wc -l
bedtools intersect -a ENCFF821SUV_ZNF507_peaks_narrowPeak.bed -b out3.ssG4_merge.flt.clean.rmDup_peaks.peak.anno.highconf.bed -v | wc -l
bedtools intersect -b ENCFF821SUV_ZNF507_peaks_narrowPeak.bed -a out3.ssG4_merge.flt.clean.rmDup_peaks.peak.anno.highconf.bed -u | wc -l
bedtools intersect -b ENCFF821SUV_ZNF507_peaks_narrowPeak.bed -a out3.ssG4_merge.flt.clean.rmDup_peaks.peak.anno.highconf.bed -v | wc -l


