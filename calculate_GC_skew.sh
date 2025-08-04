bedtools getfasta -fi GRCh37.p13.genome.fa -bed out2.potentialG4sites.classified.bed -name+ -fo out2.potentialG4sites.classified.fa
perl calculate_GC_skew.pl out2.potentialG4sites.classified.fa out2.potentialG4sites.classified.bed > out3.potentialG4sites.classified.addSkew.bed


