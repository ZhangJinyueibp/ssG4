bedtools intersect -a out3.ssG4_merge.flt.clean.rmDup_peaks.peak.anno.highconf.bed -b out3.BG4_merge.flt.clean.rmDup_peaks.bed -u > result1.ssG4_shared.peak.bed 
bedtools intersect -a out3.ssG4_merge.flt.clean.rmDup_peaks.peak.anno.highconf.bed -b out3.BG4_merge.flt.clean.rmDup_peaks.bed -v > result1.ssG4_unique.peak.bed


bedtools intersect -b out3.ssG4_merge.flt.clean.rmDup_peaks.peak.anno.highconf.bed -a out3.BG4_merge.flt.clean.rmDup_peaks.bed -u > result1.BG4_shared.peak.bed
bedtools intersect -b out3.ssG4_merge.flt.clean.rmDup_peaks.peak.anno.highconf.bed -a out3.BG4_merge.flt.clean.rmDup_peaks.bed -v > result1.BG4_unique.peak.bed
