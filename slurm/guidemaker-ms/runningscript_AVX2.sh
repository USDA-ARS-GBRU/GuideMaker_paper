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
