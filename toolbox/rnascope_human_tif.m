
function rnascope_human_tif(filename, toolbox, DAPI, LIP, DROP)

% filename = '/dcl01/lieber/ajaffe/Maddy/RNAscope/Carlee_Toddes_dotdotdot/122718_NPY86_4_L_40x_00001_CH4.tif';
addpath(genpath(toolbox))

myfiles = dir([filename,'*.tif']);
channels = cellfun(@(x) x{7}(1:end-4) , cellfun(@(x) strsplit(x,'_'),{myfiles.name}', 'UniformOutput', false), 'UniformOutput', false);

for fn = 1:numel(myfiles)
    
    if strcmp(channels{fn},DAPI)
        channels{fn} = 'DAPI';
    elseif strcmp(channels{fn},LIP)
        channels{fn} = 'Lipofuscin';
    elseif strcmp(channels{fn},DROP)
        continue
    end
    
    channel = imread(fullfile(myfiles(fn).folder, myfiles(fn).name));
    
    if (size(channel,3) == 3)
        eval(['img.',channels{fn},'= rgb2gray(channel);'])
    else
        eval(['img.',channels{fn},'= channel;'])
    end
    
end

[Y, X, Z] = size(img.DAPI);

clearex X Y Z filename toolbox img
	  
disp('extracted')
disp(fieldnames(img))
OUTimg = [];


	O = fieldnames(img);
for i = 1:numel(O)
	  channe_i = ['rescale(img.',O{i},')'];
       
  if contains(channe_i, 'Lipofuscin')
      channel = eval(channe_i);
  	  Lip = i;
  elseif contains(channe_i,'DAPI')
	  channel = medfilt3(eval(channe_i),[7 7 3]);
	  DAPI = i;
  else
      channel = imhmin(eval(channe_i),2*std2(eval(channe_i)));% suppress background noise in RNA scope channels.
  end
  
   thresh = graythresh(channel); %for rosehip
    
   %  if thresh<0.1
   %      thresh = 0.1;
   %  end
   %  if contains(channe_i,'Cy5')
   %     thresh = 0.2;
   %  end
     
     
    BWc = imbinarize(channel,thresh);
 
if contains(channe_i,'DAPI')
    
    BWc = imfill(BWc,'holes');
	bw3=max(BWc,[],3);
    D = -bwdist(~bw3);
    mask = imextendedmin(D,2);
    D2 = imimposemin(D,mask);
    Ld2 = watershed(D2);
    bw3(Ld2 == 0) = 0;
	
	for zi =1:Z	
		A = BWc(:,:,zi);
		A(bw3==0)=0;
		BWc(:,:,zi) = A;	
       % BWc(:,:,zi) = imfill(BWc(:,:,zi),'holes');
    end
    
	
else	
	 x = imcomplement(channel);
	 x = imhmin(x,2*std(channel(:)));
	 L = watershed(x);
	 BWc(L==0) = 0;  
end	 

[segmented_dotsc,no_of_dots] = bwlabeln(BWc);
statsc = regionprops3(segmented_dotsc,eval(['img.',O{i}]),'Volume','Centroid','BoundingBox','MaxIntensity','MeanIntensity','MinIntensity','VoxelValues','VoxelList','VoxelIdxList');

disp(['segmented ',O{i}, ': ',num2str(no_of_dots),' threshold:',num2str(thresh)])


v = ['excel_totaldots.',O{i}];
	eval([v '= statsc;'])
v = ['segmentation.',O{i}];
	eval([v '= BWc;']);
v = ['thresholds.',O{i}];
	eval([v '= thresh;']);
	
 OUTimg = [OUTimg ,[max(rescale(img.(O{i})),[],3),ones(Y,5); ones(5,X), ones(5,5); max(BWc,[],3), ones(Y,5)]];
clearex X Y Z OUTimg filename out toolbox img O segmentation excel_totaldots i Lip DAPI thresholds
end

%%masking

if ~isempty(LIP)
	 mask = O{Lip};		 
	 eval(['mask = segmentation.',mask,';']);
	 Segmentations_m = segmentation;
	 for i = 1:numel(O)
	 eval(['Segmentations_m.',O{i},'(mask) = 0;']);
	 channel = ['img.',O{i}]; Seg = ['Segmentations_m.',O{i}];
	 statsc = (regionprops3(eval(Seg),eval(channel),'Volume','Centroid','BoundingBox','MaxIntensity','MeanIntensity','MinIntensity','VoxelValues','VoxelList','VoxelIdxList'));
	 v = ['excel_totaldots_mask.',O{i}];
	 eval([v '= statsc;'])
	 disp(['Completed Masking ',O{i}]) 
	 end
end		
	
		 
	cel = eval(['excel_totaldots.',O{DAPI},'.VoxelIdxList;']);


	 for ii = setdiff(1:numel(O),DAPI)
	    disp(['Started ',O{ii}])
		statsc = eval(['excel_totaldots.',O{ii},';']);
		if ~isempty(LIP) , statsc_m = eval(['excel_totaldots_mask.',O{ii},';']); end
		
		 warning('off','all');
		 		tic
		 		dots_of_ROI = cell2table({{0},{0},0,{0},{0},{0}},'VariableNames',{'ROI','dotname','count','Volume','Location','Intensity'});
			if ~isempty(LIP) , dots_of_ROI_m = cell2table({{0},{0},0,{0},{0},{0}},'VariableNames',{'ROI','dotname','count','Volume','Location','Intensity'}); end
		 		for i = 1:numel(cel) % for loop to find dots in ROI%
		 			dots=cellfun(@(x) intersect(x,cel{i}), statsc.VoxelIdxList,'UniformOutput', false);
					x = find(~cellfun(@isempty,dots));
					dots_of_ROI.ROI{i} = sprintf('ROI%d',i);
                    dots_of_ROI.dotname{i} = x;
                    dots_of_ROI.count(i) = numel(x);
                    dots_of_ROI.Volume{i} = statsc.Volume(x);
                    dots_of_ROI.Location{i} = statsc.VoxelIdxList(x);
                    dots_of_ROI.Intensity{i} = statsc.VoxelValues(x);
                    
                    if ~isempty(LIP)
                    dots_m=cellfun(@(x) intersect(x,cel{i}), statsc_m.VoxelIdxList,'UniformOutput', false);
                    x_m = find(~cellfun(@isempty,dots_m));
					dots_of_ROI_m.ROI{i} = sprintf('ROI%d',i);
                    dots_of_ROI_m.dotname{i} = x_m;
					dots_of_ROI_m.count(i) = numel(x_m);
					dots_of_ROI_m.Volume{i} = statsc_m.Volume(x_m);
					dots_of_ROI_m.Location{i} = statsc_m.VoxelIdxList(x_m);
					dots_of_ROI_m.Intensity{i} = statsc_m.VoxelValues(x_m);
                    end
                    
		 		disp([num2str(i),' cells finished in time ', num2str(toc),'s'])
		 		clear x
				
		 		end
		 warning('on','all');
		 		v = ['excel_dots_of_ROI.',O{ii}];
		 		eval([v '= dots_of_ROI;'])
			 	
                if ~isempty(LIP)
                v = ['excel_dots_of_ROI_mask.',O{ii}];
			 	eval([v '= dots_of_ROI_m;'])
                end
     end 	
    		 
save([filename,'_img.mat'],'img','-v7.3')
if ~isempty(LIP)
save([filename,'_segmentation.mat'],'segmentation','Segmentations_m')
save([filename,'_totaldots.mat'],'excel_totaldots','excel_totaldots_mask') 
save([filename,'_dots_of_ROI.mat'],'excel_dots_of_ROI','excel_dots_of_ROI_mask') 
save([filename,'_thresholds.mat'],'thresholds','excel_dots_of_ROI_mask') 
else
save([filename,'_segmentation.mat'],'segmentation')
save([filename,'_totaldots.mat'],'excel_totaldots') 
save([filename,'_dots_of_ROI.mat'],'excel_dots_of_ROI') 
save([filename,'_thresholds.mat'],'thresholds') 
end

imwrite(OUTimg,[filename,'.png']);
end
