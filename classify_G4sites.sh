
perl format.pl out3.ssG4_merge.flt.clean.rmDup_peaks.peak.anno.highconf.bed > out0.potentialG4sites.format.bed
bigWigAverageOverBed out1.ssG4_merge.flt.clean.rmDup.fwd.bigwig out0.potentialG4sites.format.bed out1.fwd_on_sites.tab
bigWigAverageOverBed out1.ssG4_merge.flt.clean.rmDup.rev.bigwig out0.potentialG4sites.format.bed out1.rev_on_sites.tab 
perl classify_G4sites.pl out1.fwd_on_sites.tab out1.rev_on_sites.tab out3.ssG4_merge.flt.clean.rmDup_peaks.peak.anno.highconf.bed > out2.potentialG4sites.classified.bed


