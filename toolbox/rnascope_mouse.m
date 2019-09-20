function rnascope_mouse(filename,toolbox)
% filename = '/dcl01/lieber/ajaffe/Maddy/RNAscope/mouse/Data/9029/9029_Ctx_Raw/9029_WT_ECS_Ctx_1_1.czi';
% toolbox = '/dcl01/lieber/ajaffe/Maddy/RNAscope/henry_test/toolbox';
addpath(genpath(toolbox))
	
	
tic
addpath(genpath(toolbox))
	warning('off','all')
out = ReadImage6D(filename);
	warning('on','all')
X = out{2}.SizeX;
Y = out{2}.SizeY;
Z = out{2}.SizeZ;
voxelSizeX = out{2}.ScaleX;
voxelSizeY = out{2}.ScaleY;
voxelSizeZ = out{2}.ScaleZ;
image6d = out{1}; 

out{1,2}.Dyes = {'Cy5','DsRed','EGFP','DAPI'}; %dye names are wiped out when cropped and the channel names have no information


d = find(cellfun(@(x) contains(x,"DAPI"), out{2}.Dyes), 1);
O = out{2}.Dyes;

if isempty(d)
    d = find(cellfun(@(x) contains(x,"DAPI"), out{2}.Channels), 1);
    O = out{2}.Channels;
end

for i = 1:numel(O)
  v = char(O(i));
  v(~isstrprop(v,'alphanum')) = '_';
  v = ['img.',v];
  L = squeeze(image6d(:,:,:,i,:,:));
  S = size(L);
  
  if X==Y
      x = find(S==X);
      eval([v '= permute(L,[x(1),x(2),find(S==Z)]);']);
  elseif Z==1
      eval([v '= L']);
  else 
  eval([v '= permute(L,[find(S==Y),find(S==X),find(S==Z)]);']);
  end  
end

clear v A L in i index out 
toc
	  
disp(['extracted', (string(fieldnames(img)))'])
fprintf('\n\n\n')

disp('segmenting DAPI')

ch = eval(['img.',char(O(d))]); 

prm.method = 'adth';	% adaptive thresholding
prm.adth.filtrad = 13;
prm.adth.th = 0.01;
prm.splitth = 1;
prm.split = 1;
prm.planewise = 0;
prm.splitplane = round(Z/2);
prm.h=[voxelSizeX,voxelSizeY,voxelSizeZ]; %x,y,z pixel to um 
[cellbw1,~,~,~] = cellsegm.segmct(ch,(0.038),((4/3)*(pi)*(Z/2*0.4)^3),'prm',prm);
load(fullfile(toolbox,'cellsegm-master','@cellsegm','private','ball3.mat'),'ball')
f= imopen(cellbw1,ball);
[segmented_nuclei,number_of_nuclei] = bwlabeln(f);
statsnuc = regionprops3(segmented_nuclei,eval(['img.',char(O(d))]),'Volume','Centroid','BoundingBox','MaxIntensity','MeanIntensity','MinIntensity','VoxelValues','VoxelList','VoxelIdxList');
toc
	
xx = ['no.of nuclei detected: ',num2str(number_of_nuclei)];
disp(xx)
clear xx

if size(statsnuc,1)>0
cel{1,number_of_nuclei} = [];
for i = 1:number_of_nuclei  
    cel{i}.ind = cell2mat(statsnuc.VoxelIdxList(i));
    cel{i}.location = statsnuc.VoxelList(i);
end
end
v = ['Segmentations.',char(O(d))];
eval([v '= segmented_nuclei;']);
v = ['excel_totaldots.',char(O(d))];
eval([v '= statsnuc;'])


clearex  d l filename img Segmentations excel_totaldots X Y Z folderpath name cel myfiles toolbox
 
 tic 
O = fieldnames(img);
c = 1:size(O,1);
c(c == d) = [];
for channe_i = 1:numel(c)
    channel_i = c(channe_i);
    eval(['channel = img.',char(O(channel_i)),';']);
	channel = rescale(channel);
    channel = imhmin(channel,std2(channel));% suppress background noise in RNA scope channels.  
  
  thresh = graythresh(channel);
  BWc = imbinarize(channel,thresh);
      
D = -bwdist(~BWc); 
D(~BWc) = Inf;
L = watershed(D);
BWc(L == 0) = 0;
[segmented_dotsc,no_of_dots] = bwlabeln(BWc);
v = ['Segmentations.',char(O(channel_i))];
eval([v '= BWc;']);

statsc = (regionprops3(segmented_dotsc,channel,'Volume','Centroid','MaxIntensity','VoxelIdxList','MeanIntensity','MinIntensity','VoxelValues','VoxelList'));

xx = ['CHANNEL ',['img.',char(O(channel_i)),':  '],  num2str(no_of_dots), ' dots detected'];
disp(xx)
clear xx
 
Dotc = statsc.VoxelIdxList;
%Dotsc = cellfun(@(x) x(round(length(x)/2)), Dotc);
v = [char(O(channel_i)),'_totaldots'];
eval([v '= statsc;'])
v = ['excel_totaldots.',char(O(channel_i))];
eval([v '= statsc;'])

if exist('cel','var')
tic
 warning('off','all');
dots_of_ROI = cell2table({{0},{0},0,{0},{0},{0}},'VariableNames',{'ROI','dotname','count','Volume','Location','Intensity'});
for i = 1:numel(cel) % for loop to find dots in ROI
dots=cellfun(@(x) intersect(x,cel{i}.ind), Dotc,'UniformOutput', false);
x = find(~cellfun(@isempty,dots));
dots_of_ROI.ROI{i} = {sprintf('ROI%d',i)};
dots_of_ROI.dotname{i} = x;
dots_of_ROI.count(i) = numel(x);
dots_of_ROI.Volume{i} = statsc.Volume(x);
dots_of_ROI.Location{i} = statsc.VoxelIdxList(x);
dots_of_ROI.Intensity{i} = statsc.VoxelValues(x);
XX = [num2str(i),' cells finished in time ', num2str(toc),'s'];
disp(XX)
clear XX x
end

warning('on','all');

v = ['excel_dots_of_ROI.',char(O(channel_i))];
eval([v '= dots_of_ROI;'])
 
end 
 disp(['completed ',char(O(channel_i))])
 
 clearex img filename Segmentations channe_i c O folderpath name st Z l cel excel_totaldots excel_dots_of_ROI myfiles toolbox
end
	 toc
save([filename(1:end-4),'_img.mat'],'img')
save([filename(1:end-4),'_segmentation.mat'],'Segmentations')
save([filename(1:end-4),'_totaldots.mat'],'excel_totaldots') 
save([filename(1:end-4),'_dots_of_ROI.mat'],'excel_dots_of_ROI') 

%clearex myfiles fn toolbox

