#!/bin/bash

# Set up path

lesions_renamed='/Volumes/LASA/TBI_OpenNeuro/TBI_openneuro/data/lesions/masks/lesions_renamed/';
cd $lesions_renamed

# Calculate lesion volume

ls -d sub-tbi*bin* >sub_list.txt
for subj in `cat sub_list.txt` ; do
	fslstats  ${subj} -V > ${subj}_lesion_volume.txt
done

# Combine output textfiles
ls -d  *lesion_volume.txt > lesion_list.txt
for text in `cat lesion_list.txt`; do
	cat ${text} >> lesion_volume_combined.txt
done
	

