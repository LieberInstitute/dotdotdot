

function final_table(path1,ext,toolbox,channels)

%path1 = '/dcl01/lieber/ajaffe/Stephanie/Data/PTSD_BKB/';
%ext = '*.czi';
%toolbox = '/dcl01/lieber/ajaffe/Maddy/RNAscope/dotdotdot/dotdot_vignette/toolbox';
%channels = {'DAPI';'Opal520_Lp20';'Opal570Lp1_0';'Opal620_LP10';'Opal690Lp30';'Lipofuscin'};

addpath(genpath(toolbox))
	myfiles = dir(fullfile(path1,ext));
	ROI = table;
	Img = table;
	
	disp([path1,' : ',num2str(numel(myfiles))])
	fprintf('\n') 
    
for fn = 1:numel(myfiles)
 
filename = fullfile(myfiles(fn).folder,myfiles(fn).name(1:end-4));
load([filename,'_totaldots.mat'])
load([filename,'_dots_of_ROI.mat'])
load([filename,'_img.mat'])
    
channel = fieldnames(img);

if ~isempty(setdiff(channels,channel))
   disp('channel names doesnt match')
   setdiff(channel,channels) 
   disp(filename)
    continue
end

name = myfiles(fn).name(1:end-4);
Img1 = cell2table({name});

names = repmat({name},size(excel_totaldots.DAPI,1),1);
RVolume = excel_totaldots.DAPI.Volume;
ROI1 = [cell2table(names),table(RVolume)];

for ch = 1:numel(channels)
	eval(['PO_',channels{ch},' = sum(excel_totaldots.(channels{ch}).Volume);']);
    eval(['PM_',channels{ch},' = sum(excel_totaldots_mask.(channels{ch}).Volume);']);
    eval(['DO_',channels{ch},' = numel(excel_totaldots.(channels{ch}));']);
    eval(['DM_',channels{ch},' = numel(excel_totaldots_mask.(channels{ch}));']);
    eval(['IO_',channels{ch},' = mean(excel_totaldots.(channels{ch}).MeanIntensity);']);
    eval(['IM_',channels{ch},' = mean(excel_totaldots_mask.(channels{ch}).MeanIntensity);']);
    eval(['MI_',channels{ch},' = mean(img.(channels{ch})(:));']);
    
	eval(['Img1 = [Img1, table(PO_',channels{ch},',PM_',channels{ch},',DO_',channels{ch},',DM_',channels{ch},',IO_',channels{ch},',IM_',channels{ch},',MI_',channels{ch},')];']); 
end

Img = [Img;Img1];

Da = find(contains(channels,'DAPI'));
Li = find(contains(channels,'Lipofuscin'));
for ch = 1:numel(channels)
    
    if ch == Da || ch == Li
        continue
    end
    
O = cellfun(@(x) intersect(x,cat(1,excel_totaldots.(channels{ch}).VoxelIdxList{:})), excel_totaldots.DAPI.VoxelIdxList, 'UniformOutput',false);
eval(['O_',channels{ch},'=O;']);
P = cellfun(@(x) numel(x),O);
eval(['P_',channels{ch},'=P;']);
MI_P = cellfun(@(x) mean(img.(channels{ch})(x)), O);
eval(['MI_P_',channels{ch},'=MI_P;']);
D = excel_dots_of_ROI.(channels{ch}).count;
eval(['D_',channels{ch},'=D;']);
V = cellfun(@(x) mean(x),excel_dots_of_ROI.(channels{ch}).Volume);
eval(['V_',channels{ch},'=V;']);
MI_D = cellfun(@(x) mean(cellfun(@(y) mean(y),x)),excel_dots_of_ROI.(channels{ch}).Intensity);
eval(['MI_D_',channels{ch},'=MI_D;']);

MO = cellfun(@(x) intersect(x,cat(1,excel_totaldots_mask.(channels{ch}).VoxelIdxList{:})), excel_totaldots.DAPI.VoxelIdxList, 'UniformOutput',false);
eval(['MO_',channels{ch},'=MO;']);
MP = cellfun(@(x) numel(x),MO);
eval(['MP_',channels{ch},'=MP;']);
MI_MP = cellfun(@(x) mean(img.(channels{ch})(x)), MO);
eval(['MI_MP_',channels{ch},'=MI_MP;']);
MD = excel_dots_of_ROI_mask.(channels{ch}).count;
eval(['MD_',channels{ch},'=MD;']);
MV = cellfun(@(x) mean(x),excel_dots_of_ROI_mask.(channels{ch}).Volume);
eval(['MV_',channels{ch},'=MV;']);
MI_MD = cellfun(@(x) mean(cellfun(@(y) mean(y),x)),excel_dots_of_ROI_mask.(channels{ch}).Intensity);
eval(['MI_MD_',channels{ch},'=MI_MD;']);
eval(['ROI1 = [ROI1,table(P_',channels{ch},',MP_',channels{ch},',MI_P_',channels{ch},',MI_MP_',channels{ch},',D_',channels{ch},',MD_',channels{ch},',V_',channels{ch},',MV_',channels{ch},',MI_D_',channels{ch},',MI_MD_',channels{ch},')];']);
end

ROI = [ROI;ROI1];

clearex myfiles ROI fn path1 Img
disp(['file ',num2str(fn),' completed'])
end

writetable(ROI,[path1(1:end-5),'ROI.csv'])
writetable(Img,[path1(1:end-5),'Img.csv'])
end



