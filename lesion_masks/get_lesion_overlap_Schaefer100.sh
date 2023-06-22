#!/bin/bash

# Set up path

Schaefer100_path='/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/data/lesions/overlap_Schaefer/Schaefer100/';
cd $Schaefer100_path

#Extract parcels from atlas

# for id in `seq -w 1 100`; do
# 
# fslmaths Schaefer2018_100Parcels_7Networks_order_FSLMNI152_2mm -thr $id -uthr $id -bin Schaefer2018_100Parcels_7Networks_order_FSLMNI152_2mm_${id}
# 
# done;

# Calculate lesion volume and resample lesion mask to Schaefer resolution
# ls -d wsub* >sub_list.txt
# for subj in `cat sub_list.txt` ; do
# 	fslstats  ${subj} -V > ${subj}_lesion_volume.txt
# 	flirt -in  ${subj} -ref Schaefer2018_100Parcels_7Networks_order_FSLMNI152_2mm_001 -out ${subj}_RS.nii.gz -applyxfm
# done

# Resample lesion mask to Schaefer parcel
# ls -d Schaefer* >Schaefer100_list.txt
# ls -d *RS* >subRS_list.txt
# for schaefer in `cat Schaefer100_list.txt` ; do
#     fslstats  ${schaefer} -V > ${schaefer}_volume.txt
# 	for subjRS in `cat subRS_list.txt` ; do
# 	fslstats ${schaefer} -k  ${subjRS} -V > ${schaefer}_${subjRS}_overlap_volume.txt
# 	done
# done

# Combine output textfiles
ls -d  *overlap_volume.txt > overlap_list.txt
for text in `cat overlap_list.txt`; do
	cat ${text} >> overlap_volume_combined.txt
done
	

