#!/bin/bash
## PAM=NGG
sbatch ../guidemaker-ms/avx_final_nested.sh ../all_test_data/Escherichia.coli_str_K-12_substr_MG1655.gbk NGG
sbatch ../guidemaker-ms/avx_final_nested.sh ../all_test_data/Burkholderia_thailandensis_E264_ATCC_700388_133.gbk NGG
sbatch ../guidemaker-ms/avx_final_nested.sh ../all_test_data/Pseudomonas_aeruginosa_PAO1_107.gbk NGG
sbatch ../guidemaker-ms/avx_final_nested.sh ../all_test_data/Arabidopsis_thaliana.gbk NGG
sbatch ../guidemaker-ms/avx_final_nested.sh ../all_test_data/Aspergillus_fumigatus.gbk NGG
sbatch ../guidemaker-ms/avx_final_nested.sh ../all_test_data/GCF_000499845.1_PhaVulg1_0_genomic.gbff NGG


## PAM=NNGRRT
sbatch ../guidemaker-ms/avx_final_nested.sh ../all_test_data/Escherichia.coli_str_K-12_substr_MG1655.gbk NNGRRT
sbatch ../guidemaker-ms/avx_final_nested.sh ../all_test_data/Burkholderia_thailandensis_E264_ATCC_700388_133.gbk NNGRRT
sbatch ../guidemaker-ms/avx_final_nested.sh ../all_test_data/Pseudomonas_aeruginosa_PAO1_107.gbk NNGRRT
sbatch ../guidemaker-ms/avx_final_nested.sh ../all_test_data/Arabidopsis_thaliana.gbk NNGRRT
sbatch ../guidemaker-ms/avx_final_nested.sh ../all_test_data/Aspergillus_fumigatus.gbk NNGRRT
sbatch ../guidemaker-ms/avx_final_nested.sh ../all_test_data/GCF_000499845.1_PhaVulg1_0_genomic.gbff NNGRRT


## PAM=NNAGAAW
sbatch ../guidemaker-ms/avx_final_nested.sh ../all_test_data/Escherichia.coli_str_K-12_substr_MG1655.gbk NNAGAAW
sbatch ../guidemaker-ms/avx_final_nested.sh ../all_test_data/Burkholderia_thailandensis_E264_ATCC_700388_133.gbk NNAGAAW
sbatch ../guidemaker-ms/avx_final_nested.sh ../all_test_data/Pseudomonas_aeruginosa_PAO1_107.gbk NNAGAAW
sbatch ../guidemaker-ms/avx_final_nested.sh ../all_test_data/Arabidopsis_thaliana.gbk NNAGAAW
sbatch ../guidemaker-ms/avx_final_nested.sh ../all_test_data/Aspergillus_fumigatus.gbk NNAGAAW
sbatch ../guidemaker-ms/avx_final_nested.sh ../all_test_data/GCF_000499845.1_PhaVulg1_0_genomic.gbff NNAGAAW


#### leven with PhaVulg1 genome
sbatch ../guidemaker-ms/avx_final_nested_with_leven_phaesolus.sh ../all_test_data/GCF_000499845.1_PhaVulg1_0_genomic.gbff NGG
sbatch ../guidemaker-ms/avx_final_nested_with_leven_phaesolus.sh ../all_test_data/GCF_000499845.1_PhaVulg1_0_genomic.gbff NNGRRT
sbatch ../guidemaker-ms/avx_final_nested_with_leven_phaesolus.sh ../all_test_data/GCF_000499845.1_PhaVulg1_0_genomic.gbff NNAGAAW

##### hamming with human where, gl-25, and lsr == 15

avx_final_nested_with_hamming_human.sh
GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.gz

sbatch ../guidemaker-ms/avx_final_nested_with_hamming_human.sh ../all_test_data/GCF_000499845.1_PhaVulg1_0_genomic.gbff NNGRRT
sbatch ../guidemaker-ms/avx_final_nested_with_hamming_human.sh ../all_test_data/GCF_000499845.1_Pha NNAGAAW


###### PhaVulg1_0 hamming vs leven comp for supp fig 4
sbatch ../guidemaker-ms/avx_final_nested_with_leven_hamming_phaesolus.sh ../all_test_data/GCF_000499845.1_PhaVulg1_0_genomic.gbff NGG hamming Vulgaris_NGG_Hamming 
sbatch ../guidemaker-ms/avx_final_nested_with_leven_hamming_phaesolus.sh ../all_test_data/GCF_000499845.1_PhaVulg1_0_genomic.gbff NGG leven Vulgaris_NGG_Leven

sbatch ../guidemaker-ms/avx_final_nested_with_leven_hamming_phaesolus.sh ../all_test_data/GCF_000499845.1_PhaVulg1_0_genomic.gbff NNGRRT hamming Vulgaris_NNGRRT_Hamming 
sbatch ../guidemaker-ms/avx_final_nested_with_leven_hamming_phaesolus.sh ../all_test_data/GCF_000499845.1_PhaVulg1_0_genomic.gbff NNGRRT leven Vulgaris_NNGRRT_Leven

sbatch ../guidemaker-ms/avx_final_nested_with_leven_hamming_phaesolus.sh ../all_test_data/GCF_000499845.1_PhaVulg1_0_genomic.gbff NNAGAAW hamming Vulgaris_NNAGAAW_Hamming 
sbatch ../guidemaker-ms/avx_final_nested_with_leven_hamming_phaesolus.sh ../all_test_data/GCF_000499845.1_PhaVulg1_0_genomic.gbff NNAGAAW leven Vulgaris_NNAGAAW_Leven
