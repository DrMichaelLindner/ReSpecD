function respecd(targetfolder)

% This tool is designed to rename all spectroscopy dicomfiles in the 
% selected folder.
%
%   new filename structure:
%   <patient_id> _ <series number> _ <instance number>.dcm
%
% BE AWARE: ORIGINAL DATA WILL BE DELETED!
%           MAKE A COPY BEFORE RENAMING!!
%
%
% INPUT:
% targetfolder (optional) : folder that contains all dicom files to rename
%               if targetfolder is not specified, a dialog will pop up to
%               browse and select the folder.
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License (GPLv3) as published
% by the Free Software Foundation;
%
% This program is distributed in the hope that it will be useful, 
% but WITHOUT ANY WARRANTY;
% 
% AUTHOR
% Michael Lindner  
% University of Reading, 2018  
% School of Psychology and Clinical Language Sciences  
% Center for Integrative Neuroscience and Neurodynamics

uiwait(warndlg('WARNING: Original data will be deleted. Make a copy before renaming!'))
clc
warning('\n\nOriginal data will be deleted.\n\n')

if nargin <1
    targetfolder = uigetdir('','Select folder containing all spectroscopy dicom files to rename');
end
targetfolder = [targetfolder,filesep];

fd=strcat(targetfolder);
D=dir([fd,'*.dcm']);
files = {D.name}';
num = length(files);


f = waitbar(0,'1','Name','Renaming files ...');

for ii=1:num
    
    % Update waitbar and message
    waitbar(ii/num,f,sprintf('%s',[num2str(ii), ' of ', num2str(num)]))
    
    count=1;
    try
        dic = strcat(targetfolder,char(files(ii,:)));
        dicn = dicominfo(dic);
        n = getfield(dicn,'PatientID');
        s = getfield(dicn,'SeriesNumber');
        i = getfield(dicn,'InstanceNumber');
        for jj = 1:4-length(num2str(s))
            ns(1,jj)='0';
        end
        for jj = 1:4-length(num2str(i))
            ni(1,jj)='0';
        end
        oldfile=strcat(targetfolder,files{ii});
        % check file
        newfile=strcat('s',ns,num2str(s),'_i',ni,num2str(i),'_',num2str(count),'_',n,'.dcm');
        if regexp(newfile, '[*:?"<>|]', 'once')
            t=0;
            while t==0
                if regexp(newfile, '[*:?"<>|]', 'once')
                    newfile(regexp(newfile, '[*:?"<>|]', 'once'))='_';
                else
                    t=1;
                end
            end
        end
        
        d=0;
        while d==0
            if exist(newfile, 'file') == 2
                count=count+1;
                newfile=strcat(targetfolder,'s',ns,num2str(s),'_i',ni,num2str(i),'_',num2str(count),'_',n,'.dcm');
                if regexp(newfile, '[*:?"<>|]', 'once')
                    t=0;
                    while t==0
                        if regexp(newfile, '[*:?"<>|]', 'once')
                            newfile(regexp(newfile, '[*:?"<>|]', 'once'))='_';
                        else
                            t=1;
                        end
                    end
                end
                
            else
                d=1;
            end
        end
        
        newfile=[targetfolder,newfile];
        
        copyfile(char(oldfile),char(newfile))
        delete(char(oldfile))
        clear ns ni
    end
end
delete(f)

