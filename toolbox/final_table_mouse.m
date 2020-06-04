function final_table_mouse(path1,ext,toolbox,channels)

%path1 = '/dcl01/lieber/ajaffe/Maddy/RNAscope/dotdotdot/dotdot_vignette/';
%ext = 'Mouse*.czi';
%toolbox = '/dcl01/lieber/ajaffe/Maddy/RNAscope/dotdotdot/dotdot_vignette/toolbox';
%channels = {'Cy5','DsRed','EGFP','DAPI'};

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
    eval(['DO_',channels{ch},' = numel(excel_totaldots.(channels{ch}));']);
    eval(['IO_',channels{ch},' = mean(excel_totaldots.(channels{ch}).MeanIntensity);']);
    eval(['MI_',channels{ch},' = mean(img.(channels{ch})(:));']);
    
	eval(['Img1 = [Img1, table(PO_',channels{ch},',DO_',channels{ch},',IO_',channels{ch},',MI_',channels{ch},')];']); 
end

Img = [Img;Img1];

Da = find(contains(channels,'DAPI'));
for ch = 1:numel(channels)
    
    if ch == Da 
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
eval(['ROI1 = [ROI1,table(P_',channels{ch},',MI_P_',channels{ch},',D_',channels{ch},',V_',channels{ch},',MI_D_',channels{ch},')];']);
end

ROI = [ROI;ROI1];

clearex myfiles ROI fn path1 Img channels
disp(['file ',num2str(fn),' completed'])
end

writetable(ROI,[path1,'Mouse_long_data.csv'])
writetable(Img,[path1,'Mouse_man.csv'])
end
