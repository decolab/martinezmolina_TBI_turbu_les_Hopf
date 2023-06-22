#!/bin/bash

# Set up path

Schaefer1000_path='/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/data/lesions/overlap_Schaefer/Schaefer1000_wotbi09/';
cd $Schaefer1000_path

#Extract parcels from atlas

# for id in `seq -w 1 1000`; do
# 
# fslmaths Schaefer2018_1000Parcels_7Networks_order_FSLMNI152_2mm -thr $id -uthr $id -bin Schaefer2018_1000Parcels_7Networks_order_FSLMNI152_2mm_${id}
# 
# done;

# Calculate lesion volume from lesion masks resampled to Schaefer dimensions in mricron (sub-tbi-09 lesions excluded for misalignment)
# ls -d *RS* >subRS_list.txt
# for subj in `cat subRS_list.txt` ; do
# 	fslstats  ${subj} -V > ${subj}_lesion_volume.txt
# done

# Calculate overlap with Schaefer parcel
# ls -d Schaefer* >Schaefer1000_list.txt
# ls -d *RS.nii >subRS_list.txt
# for schaefer in `cat Schaefer1000_list.txt` ; do
#     fslstats  ${schaefer} -V > ${schaefer}_volume.txt
# 	for subjRS in `cat subRS_list.txt` ; do
# 	fslstats ${schaefer} -k  ${subjRS} -V > ${schaefer}_${subjRS}_overlap_volume.txt
# 	done
# done

# Combine output textfiles
# ls -d  *nii.gz_volume.txt > volume_Schaefer_list.txt
# for Sc_Vol in `cat volume_Schaefer_list.txt`; do
# cat ${Sc_Vol} >> Schaefer_volume_combined.txt
# done
# 
# ls -d  *lesion_volume.txt > volume_lesion_list.txt
# for Les_Vol in `cat volume_lesion_list.txt`; do
# cat ${Les_Vol} >> Lesion_volume_combined.txt
# done
ls -d  *wsub-tbi02_lesion_mask_robin_RS.nii_overlap_volume.txt > overlap_list_tbi02.txt
for text in `cat overlap_list_tbi02.txt`; do
cat ${text} >> overlap_volume_combined_wsub-tbi02.txt
done

l# s -d  *wsub-tbi03_lesion_mask_robin_RS.nii_overlap_volume.txt > overlap_list_tbi03.txt
# for text in `cat overlap_list_tbi03.txt`; do
# cat ${text} >> overlap_volume_combined_wsub-tbi03.txt
# done
# 
# ls -d  *wsub-tbi04_lesion_mask_robin_RS.nii_overlap_volume.txt > overlap_list_tbi04.txt
# for text in `cat overlap_list_tbi04.txt`; do
# cat ${text} >> overlap_volume_combined_wsub-tbi04.txt
# done
# 
# ls -d  *wsub-tbi05_lesion_mask_robin_RS.nii_overlap_volume.txt > overlap_list_tbi05.txt
# for text in `cat overlap_list_tbi05.txt`; do
# cat ${text} >> overlap_volume_combined_wsub-tbi05.txt
# done
# 
# ls -d  *wsub-tbi06_lesion_mask_robin_RS.nii_overlap_volume.txt > overlap_list_tbi06.txt
# for text in `cat overlap_list_tbi06.txt`; do
# cat ${text} >> overlap_volume_combined_wsub-tbi06.txt
# done
# 
# ls -d  *wsub-tbi07_lesion_mask_robin_RS.nii_overlap_volume.txt > overlap_list_tbi07.txt
# for text in `cat overlap_list_tbi07.txt`; do
# cat ${text} >> overlap_volume_combined_wsub-tbi07.txt
# done
# 
# ls -d  *wsub-tbi08_lesion_mask_robin_RS.nii_overlap_volume.txt > overlap_list_tbi08.txt
# for text in `cat overlap_list_tbi08.txt`; do
# cat ${text} >> overlap_volume_combined_wsub-tbi08.txt
# done
# 
# ls -d  *wsub-tbi10_lesion_mask_robin_RS.nii_overlap_volume.txt > overlap_list_tbi10.txt
# for text in `cat overlap_list_tbi10.txt`; do
# cat ${text} >> overlap_volume_combined_wsub-tbi10.txt
# done
# 
# ls -d  *wsub-tbi11_lesion_mask_robin_RS.nii_overlap_volume.txt > overlap_list_tbi11.txt
# for text in `cat overlap_list_tbi11.txt`; do
# cat ${text} >> overlap_volume_combined_wsub-tbi11.txt
# done
# 
# ls -d  *wsub-tbi14_lesion_mask_robin_RS.nii_overlap_volume.txt > overlap_list_tbi14.txt
# for text in `cat overlap_list_tbi14.txt`; do
# cat ${text} >> overlap_volume_combined_wsub-tbi14.txt
# done