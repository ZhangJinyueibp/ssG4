ln -s ../out1.ICGC_in_bothSP1andssG4.bed ./result0.ICGC_in_bothSP1andssG4.bed
perl step1.extract_seq.pl result0.ICGC_in_bothSP1andssG4.bed hg19.chrom.sizes GRCh37.p13.genome.clean.fa
perl step2.creat_Mut.pl result2.ICGC_around.Ref.fa > result2.ICGC_around.mut.fa
perl step3.predict_G4.pl result2.ICGC_around.mut.fa > result3.ICGC_around.mut.G4_loci.list
perl step3.predict_G4.pl result2.ICGC_around.Ref.fa > result3.ICGC_around.Ref.G4_loci.list
perl step3.predict_SP1.pl result2.ICGC_around.mut.fa out1.cycle4.kmer_frq.xls > result3.ICGC_around.mut.SP1_binding.list
perl step3.predict_SP1.pl result2.ICGC_around.Ref.fa out1.cycle4.kmer_frq.xls > result3.ICGC_around.Ref.SP1_binding.list

perl step4.compare_Ref_mut.pl result3.ICGC_around.Ref.G4_loci.list result3.ICGC_around.mut.G4_loci.list result3.ICGC_around.Ref.SP1_binding.list result3.ICGC_around.mut.SP1_binding.list > result4.ICGC_around.ref_vs_mut.G4_bases.SP1_binding.xls

perl step5.classify_eQTL_by_G4dynamics.pl result4.ICGC_around.ref_vs_mut.G4_bases.SP1_binding.xls result0.ICGC_in_bothSP1andssG4.bed 


perl step6.select_ICGC_changeG4_nearTSS.pl result5.ICGC.repress_G4.decrease_SP1.table out2.ICGC_TSS.overlap > result6.ICGC.repress_G4.decrease_SP1.near_TSS.table
perl step6.select_ICGC_changeG4_nearTSS.pl result5.ICGC.enhance_G4.increase_SP1.table out2.ICGC_TSS.overlap > result6.ICGC.enhance_G4.increase_SP1.near_TSS.table

cat result6.ICGC.repress_G4.decrease_SP1.near_TSS.table | awk '{print $12}' | sort | uniq > result7.ICGC.repress_G4.decrease_SP1.near_TSS.affected_genes.list
cat result6.ICGC.enhance_G4.increase_SP1.near_TSS.table | awk '{print $12}' | sort | uniq > result7.ICGC.enhance_G4.increase_SP1.near_TSS.affected_genes.list
