# ReSpecD -  REname SPECtroscopy Dicom files

This MATLAB based tool is designed to rename all MR spectroscopy dicom files in a given (or selected) folder.


The new filename structure will be:
< patient ids > _ < series number > _ < instance number>.dcm


BE AWARE: ORIGINAL DATA WILL BE DELETED!
MAKE A COPY BEFORE RENAMING!!


## *INPUT:*
targetfolder (optional) : folder that contains all dicom files to rename
e.g. respecd('C:\yourfolder')

If no targetfolder is specified, a dialog will pop up to
browse and select a folder.


## *License*  
pyBIDSconv by Michael Lindner is licensed under GPLv3

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
  
  
Author:  
Michael Lindner  
University of Reading, 2018  
School of Psychology and Clinical Language Sciences  
Centre for Integrative Neuroscience and Neurodynamics
