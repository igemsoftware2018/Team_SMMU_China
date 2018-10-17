

function varargout = BNPCA(varargin)
% BNPCA MATLAB code for BNPCA.fig
%      BNPCA, by itself, creates a new BNPCA or raises the existing
%      singleton*.
%
%      H = BNPCA returns the handle to a new BNPCA or the handle to
%      the existing singleton*.
%
%      BNPCA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BNPCA.M with the given input arguments.
%
%      BNPCA('Property','Value',...) creates a new BNPCA or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BNPCA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BNPCA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BNPCA

% Last Modified by GUIDE v2.5 12-Oct-2018 23:33:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BNPCA_OpeningFcn, ...
                   'gui_OutputFcn',  @BNPCA_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

% End initialization code - DO NOT EDIT

% --- Executes just before BNPCA is made visible.
function BNPCA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BNPCA (see VARARGIN)
global SaveFolder

add0=mfilename;%��ǰM�ļ���
add1=mfilename('fullpath');%��ǰm�ļ�·��
i=length(add0);
j=length(add1);

local_address=add1(1:j-i-1);
SaveFolder=local_address;

cd (SaveFolder)
% Choose default command line output for BNPCA
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

initialize_gui(hObject, handles, false);
movegui(gcf,'center');



% UIWAIT makes BNPCA wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BNPCA_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function editBNP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBNP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editBNP_Callback(hObject, eventdata, handles)
% hObject    handle to editBNP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBNP as text
%        str2double(get(hObject,'String')) returns contents of editBNP as a double
density = str2double(get(hObject, 'String'));
if isnan(density)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end

% Save the new editBNP value
handles.metricdata.density = density;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function volume_CreateFcn(hObject, eventdata, handles)
% hObject    handle to volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global subdirpath
global merageImage
global sampleName

subdirpath=uigetdir('C:\','Please select the folder where the images are stored');

set(handles.Calculate , 'enable', 'off');

set(handles.editNumber , 'String', '');
set(handles.editRate , 'String', '');

strSplit=regexp(subdirpath, '\', 'split')
sampleName=strSplit(end);
set(handles.txtFilename , 'String',strcat( 'Automatic splicing of calcium spark images,please wait......',sampleName));

imgType='.tif';
imgFilter=fullfile(subdirpath,['*',imgType]);
images=dir(imgFilter);
 
if (length(images) == 1) %��ֻѡ��һ��ͼƬ����ͼƬ�������ImageSingle��
        FileNum = 1;
        FileName=strcat(subdirpath,'\',images(1,1).name)
        ImageSingle = imread(FileName);
else FileNum = length(images);%��ѡ�����ͼƬ��������ͼƬ����Ԫ������ImageCell{ }��
    for sn1 = 1:FileNum
        FileName=strcat(subdirpath,'\',images(sn1,1).name);
        ImageCell{sn1} = imread(FileName);            
    end
end

w_load = waitbar(0,'Please wait...','Name','Phase load'); %����waitbar
if FileNum>1 
    merageImage = cell2mat(ImageCell');
else   
    merageImage = ImageSingle;
end
NbColors = 255;
map = jet(NbColors);
axes(handles.axes1);
colormap(handles.axes1,map);
image(merageImage);colormap(map);title('Automatic splicing of calcium spark images');xlabel('time s');ylabel('��m');axis('off');

set(handles.txtFilename , 'String', 'Filter noise and pseudo-color processing, please wait......');
set(handles.Count , 'enable', 'off');
set(handles.Calculate , 'enable', 'off');

b=merageImage(:,1:900); %��ȡ�м�900�����أ�ÿ������0.111um,�ߴ�Ϊ100um
%b=merageImage(:,500:700); %��ȡ�м�520������
b=b';

waitbar(0.2 ,w_load,'Please wait...');
%1.2 ����С������
%ͼ����
%�۳�����F0
Temp= bsxfun(@minus, (b), min(b));
Temp(Temp<0) = 0;
my_imageDataColor=Temp;

Cols=size(my_imageDataColor,2); %�������� 
Rows=size(my_imageDataColor,1); %�������� =512

%���õ�ɫ������
NbColors = 255;
map = jet(NbColors);
mapsize=size(map,1);
%С������
X=wextend('2','sp0',my_imageDataColor,[8-mod(size(my_imageDataColor,1),2^3),8-mod(size(my_imageDataColor,2),2^3)],'r'); %��ά����,�Ա���С���ֽ�
wavename='db3';  %���÷ֽ���С��

[swa,swh,swv,swd] = swt2(X,3,wavename); %С�����׷ֽ�
thr =150; %����������ֵ
sorh = 's'; %������ֵΪ����ֵ soft
dswh = wthresh(swh,sorh,thr); %ˮƽϸ��ϵ������
dswv = wthresh(swv,sorh,thr); %��ֱϸ��ϵ������
dswd = wthresh(swd,sorh,thr); %�Խ�ϸ��ϵ������
clean = iswt2(swa,dswh,dswv,dswd,wavename); %��������ϵ���ع�ͼ��ϵ��
t=wcodemat(clean ,mapsize); %�ع�ͼ��
tt=imresize(t,[Rows,Cols]); %�����ع�ͼ���СΪԭ��С

my_imageDataDenoise=tt(16:end-16,16:end-16); %ȥ��������ΪС����ά���ز����ĸ���

waitbar(0.4 ,w_load,'Please wait...');
global Cols
global Rows
global umperPix
global timeperPix

umperPix=round(113.5/1024,3) ;%ÿ��������Ʒ��С
timeperPix=round(1.28/512,3)*1000;%ÿ������ʱ��  ����Ϊ��λ

Cols=size(my_imageDataDenoise,2); %�������� 
Rows=size(my_imageDataDenoise,1); %��������

imgSize=umperPix*Rows;
imgTimes=timeperPix*Cols;
global totalTimelapse
totalTimelapse=ceil(imgTimes);

%�۳�F0
my_imageF0=bsxfun(@minus, (my_imageDataDenoise), min(my_imageDataDenoise));
global SaveFolder
tmpFile=strcat(SaveFolder ,'\TEMP.tif');
imwrite(my_imageF0,colormap(map),tmpFile,'tif','compression','none') ;

%�ƻ�ʶ��
waitbar(0.6 ,w_load,'Please wait...');
I= imread(tmpFile); %����������ͼ��my_imageF0;
axes(handles.axes1);
colormap(handles.axes1,map);
image(I) ;colormap(map);title(strcat('Calcium sparks release in  ��',num2str(totalTimelapse),'�� millisecond' ) ) ;xlabel('time s');ylabel('��m');axis('off');
waitbar(0.8 ,w_load,'Please wait...');
set(handles.txtFilename , 'String', subdirpath);
set(handles.Count , 'enable', 'on');
set(handles.mnuCalspark , 'enable', 'on');

set(handles.btnDetail , 'enable', 'off');
set(handles.mnuViewsparks , 'enable', 'off');
close (w_load);




% --- Executes on button press in Count.
function Count_Callback(hObject, eventdata, handles)
% hObject    handle to Count (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global merageImage    
global SaveFolder

global sampleName

% cd (SaveFolder)
% 
% delete('*.xls');


global SaveFolder
tmpFile=strcat(SaveFolder ,'\TEMP.tif');

%�ƻ�ʶ��

I= imread(tmpFile); %����������ͼ��my_imageF0;
Ic = imcomplement(I); %ȡ��������
BW = im2bw(Ic, graythresh(Ic)*0.618); %������ֵ����Ϊ�ڰ׶�ֵͼ,��ֵΪȫ����ֵ*ϵ��
se = strel('disk',3); %�԰뾶Ϊ3��Բ��Ѱ�Ҹƻ�,���ص���logicalֵ
BWc = imclose(BW, se);  %�ںڰ׶�ֵͼ�����øƻ�����
BWco = imopen(BWc, se); %��ոƻ�����
[L, SparkNum] = bwlabel(~BWco,4);
BWoutline = bwperim(~BWco); 
Segout = I; 
Segout(BWoutline) = 255; %�ð�ɫȦ���ƻ�����
Iimpose = imimposemin(I, BWco);

%��ԭͼ�ϵ��Ӹƻ�������ʾ

singleSparksTime=120; %�ڶ̶̵�10ms�ڣ�ϸ����ĳһ΢��Ca2+̽��Fluo-3��ӫ��ǿ������һ�����������20ms����ʧ���ʳƸƻ𻨡�20��Լ50ms
singleSparksWidth=20; %�ƻ𻨵�ֱ��Լ2��m��ÿ��0.11��m  20��Լ2.2um


set(handles.editNumber , 'String', num2str(SparkNum));

w_load = waitbar(0,'Please wait...','Name','Phase load'); %����waitbar

global Cols
global Rows
global umperPix
global timeperPix

for k = 1:SparkNum 
    waitbar(k /SparkNum ,w_load,strcat('Please wait...',num2str(fix( (k /SparkNum)*100)), '%'));
    [r,c] = find(L == k);  %�ƻ�����
    if max(c)-singleSparksTime/2 <= 0
        leftX=1 ;
    else
        leftX=floor(max(c)-singleSparksTime/2) +1;
    end

    if mean(c)+singleSparksTime/2 >=Cols
        rightX=Cols;
    else
        rightX=floor(mean(c)+singleSparksTime/2)+1;
    end

     if mean(r)-singleSparksWidth/2 <= 0
        upY=1 ;
    else
        upY=floor(mean(r)-singleSparksWidth/2)+1;
    end

    if mean(r)+singleSparksWidth/2 >Rows
        downY=Rows;
    else
        downY=floor(mean(r)+singleSparksWidth/2)+1;
    end

    %����ƻ����겢������ʾ
    singleSparks(k)=struct('X1',leftX,'X2',rightX,'Y1',upY,'Y2',downY,'centerY',floor(mean(r)),'centerX',floor(mean(c)));
    axes(handles.axes1);
    hold on ;
    plot(singleSparks(k).centerX,singleSparks(k).centerY,'marker','^','markeredgecolor','r','markersize',10);  
    
    ttSpark=I(singleSparks(k).Y1:singleSparks(k).Y2,singleSparks(k).X1:singleSparks(k).X2);

    sparkCols=size(ttSpark,2); %�������� 
    sparkRows=size(ttSpark,1); %�������� 

    %���ɺ���/um����
    xxSpark=[1:1:sparkCols]'*timeperPix; 
    yySpark=[1:1:sparkRows]'*umperPix;

    av=mean(ttSpark,1) ;%����ƽ��


    %ƽ��
    smoothingFactor=3;  
    aav=smooth(xxSpark,av(1:length(xxSpark)),smoothingFactor);
    aav=(aav-min(aav))/min(aav);

    %�ҳ�ӫ�����ߵ����ֵ������x����
    [Fmax ind]=max(aav); 
    xFluomax = xxSpark(ind);    

    clear z;
    %�ҳ�ӫ�����߱仯���ֵ������x����
    y=aav;
    z = diff(y);
    


    [Fchangemax,b] = max(z);
    xChangemax = xxSpark(b); 
    FluoChangemax=aav(b);


    SparkDeltaF0(k)=struct('Fluo',ttSpark,'SampleName',sampleName,'number',k,'aav',aav,'PeakValue',Fmax,'PeakTime',xFluomax,'FluoChangemax',FluoChangemax,'xChangemax',xChangemax);

end

global totalTimelapse
imgSize=umperPix*Rows;
imgTimes=timeperPix*Cols;

global FreqSpark
FreqSpark=SparkNum/(imgSize/1000)/(totalTimelapse/1000);

global Sparks
Sparks=struct('SampleName',[sampleName],'sparkArea',singleSparks,'SparkDeltaF0',SparkDeltaF0,'SparkNum',SparkNum, 'imgSize',imgSize,'imgTime',totalTimelapse,'FreqSpark',FreqSpark,'sparkAnalysis','');

 
set(handles.editRate , 'String','') ;
close (w_load);
set(handles.btnDetail , 'enable', 'on');
set(handles.mnuViewsparks , 'enable', 'on');

set(handles.Calculate , 'enable', 'on');
set(handles.mnuLeak , 'enable', 'on');




% --- Executes on button press in Calculate.
function Calculate_Callback(hObject, eventdata, handles)
% hObject    handle to Calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FreqSpark
set(handles.editRate , 'String', strcat(num2str(roundn(FreqSpark,-2)),'') );
 


% --- Executes on button press in btnDetail.
function btnDetail_Callback(hObject, eventdata, handles)
% hObject    handle to btnDetail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)\
setappdata(gcf, 'IgnoreCloseAll', 1); 
close all;
global Sparks

sampleName=Sparks.SampleName;
sparkSeries=1;
clear sparksAnalisis;

 %���õ�ɫ������
NbColors = 255;
map = jet(NbColors);
mapsize=size(map,1);

umperPix=round(113.5/1024,3) ;%ÿ��������Ʒ��С
timeperPix=round(1.28/512,3)*1000;%ÿ������ʱ��  ����Ϊ��λ

for j = 1:Sparks.SparkNum
    figure();

    subplot(2,1,1);image(Sparks.SparkDeltaF0(j).Fluo);colormap(map);title([sampleName,' - ',num2str(j)] ) ;xlabel('time s');ylabel('��m');axis('off');

    sparkCols=size(Sparks.SparkDeltaF0(j).Fluo,2); %�������� 
    sparkRows=size(Sparks.SparkDeltaF0(j).Fluo,1); %�������� 


    startPosition=Sparks.SparkDeltaF0(j).xChangemax/timeperPix;
    peakPosition=Sparks.SparkDeltaF0(j).PeakTime/timeperPix;

    amplitude=double(Sparks.SparkDeltaF0(j).PeakValue)-double(Sparks.SparkDeltaF0(j).FluoChangemax);
    risingTime=Sparks.SparkDeltaF0(j).PeakTime-Sparks.SparkDeltaF0(j).xChangemax;

    TD50Series=find(Sparks.SparkDeltaF0(j).aav<Sparks.SparkDeltaF0(j).PeakValue*0.5);
    TD50Position=TD50Series(find(TD50Series>peakPosition,1));
    TD50=(TD50Position-peakPosition)*timeperPix;

    TD90Series=find(Sparks.SparkDeltaF0(j).aav<Sparks.SparkDeltaF0(j).PeakValue*0.1);
    TD90Position=TD90Series(find(TD90Series>peakPosition,1));
    TD90=double((TD90Position-peakPosition)*timeperPix);

    duration=double((TD90Position-startPosition)*timeperPix);


    xxSpark=[startPosition:1:sparkCols+startPosition-1]'*timeperPix;
    yySpark=[1:1:sparkRows]'*umperPix;

    S = stepinfo(Sparks.SparkDeltaF0(j).aav);

    subplot(2,1,2);

    ylimmax=ceil(max(Sparks.SparkDeltaF0(j).aav));
    ylim([-0.5 ylimmax]);
    xlim([min(xxSpark) max(xxSpark)]);
    hold on


    plot(xxSpark,Sparks.SparkDeltaF0(j).aav);title '';xlabel('time (ms)');ylabel('(F-F0)/F0');%axis([0.0 5 -1 max(x)+1
    line([min(xxSpark) (S.PeakTime+startPosition-1)*timeperPix], [S.Peak S.Peak],'linestyle',':','color','b'); %peak value
    line([(S.PeakTime+startPosition-1)*timeperPix (S.PeakTime+startPosition-1)*timeperPix], [-0.5  S.Peak],'linestyle',':','color','b'); %Rising time

    line([(S.SettlingTime+startPosition-1)*timeperPix (S.SettlingTime+startPosition-1)*timeperPix], [-0.5  S.Peak*0.9],'linestyle',':','color','R'); %SettlingTime time


    hold on

end
    

% --- Executes on button press in btnSave.
function btnSave_Callback(hObject, eventdata, handles)
% hObject    handle to btnSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataFilename

r=str2double(get(handles.editRate,'String'));


if isnan(r)
    set(handles.editRate, 'String', 0);
    errordlg('Please calcute calcium spark rate first','Error');
end


b=get(handles.editBNP,'String');

if str2num(b) <=0
    uicontrol(handles.editBNP); 
    errordlg('Please input BNP value first','Error'); 
    return
end

f=get(handles.txtDataFilename,'String');

fid = fopen(char(f),'a');
pCaSpark=get(handles.editRate,'String');
BNP=get(handles.editBNP,'String');

fprintf(fid,'%s %s \r\n',BNP,pCaSpark);
fclose(fid);

% --------------------------------------------------------------------
function initialize_gui(fig_handle, handles, isreset)
% If the metricdata field is present and the reset flag is false, it means
% we are we are just re-initializing a GUI by calling it from the cmd line
% while it is up. So, bail out as we dont want to reset the data.
% if isfield(handles, 'metricdata') && ~isreset
%     return;
% end
% 
% handles.metricdata.editBNP = 0;
% handles.metricdata.volume  = 0;
% 
% set(handles.editBNP, 'String', handles.metricdata.editBNP);
% set(handles.volume,  'String', handles.metricdata.volume);
% set(handles.mass, 'String', 0);
% 
% set(handles.unitgroup, 'SelectedObject', handles.english);
% 
% set(handles.text4, 'String', 'lb/cu.in');
% set(handles.text5, 'String', 'cu.in');
% set(handles.text6, 'String', 'lb');

% Update handles structure




% --- Executes on button press in btnEstimate.
function btnEstimate_Callback(hObject, eventdata, handles)
% hObject    handle to btnEstimate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Estimate


% --------------------------------------------------------------------
function mnuFile_Callback(hObject, eventdata, handles)
% hObject    handle to mnuFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mnuImage_Callback(hObject, eventdata, handles)
% hObject    handle to mnuImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mnuCal_Callback(hObject, eventdata, handles)
% hObject    handle to mnuCal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mnuHelp_Callback(hObject, eventdata, handles)
% hObject    handle to mnuHelp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mnuAbout_Callback(hObject, eventdata, handles)
% hObject    handle to mnuAbout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
about

% --------------------------------------------------------------------
function mnuCalspark_Callback(hObject, eventdata, handles)
% hObject    handle to mnuCalspark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Count_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function mnuViewsparks_Callback(hObject, eventdata, handles)
% hObject    handle to mnuViewsparks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
btnDetail_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function mnuEstimate_Callback(hObject, eventdata, handles)
% hObject    handle to mnuEstimate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
btnEstimate_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function mnuLeak_Callback(hObject, eventdata, handles)
% hObject    handle to mnuLeak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Calculate_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function mnuSpark_Callback(hObject, eventdata, handles)
% hObject    handle to mnuSpark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pushbutton3_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function mnuTransients_Callback(hObject, eventdata, handles)
% hObject    handle to mnuTransients (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mnuContent_Callback(hObject, eventdata, handles)
% hObject    handle to mnuContent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function nmuExit_Callback(hObject, eventdata, handles)
% hObject    handle to nmuExit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear all
close all 



% --------------------------------------------------------------------
function mnuOpen_Callback(hObject, eventdata, handles)
% hObject    handle to mnuOpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
btnOpen_Callback(hObject, eventdata, handles)





function editNumber_Callback(hObject, eventdata, handles)
% hObject    handle to editNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editNumber as text
%        str2double(get(hObject,'String')) returns contents of editNumber as a double


% --- Executes during object creation, after setting all properties.
function editNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editRate_Callback(hObject, eventdata, handles)
% hObject    handle to editRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editRate as text
%        str2double(get(hObject,'String')) returns contents of editRate as a double


% --- Executes during object creation, after setting all properties.
function editRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnOpen.
function btnOpen_Callback(hObject, eventdata, handles)
% hObject    handle to btnOpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataFilename
[file,path]=uigetfile('*.txt','Select Data File');

if isequal(file,0)
   disp('User selected Cancel');
else
   dataFilename= char(fullfile(path,file));
   set(handles.txtDataFilename , 'String', dataFilename);
   set(handles.btnSave , 'enable', 'on');
   set(handles.btnView , 'enable', 'on');
   set(handles.mnuOpti  , 'enable', 'on');
   set(handles.mnuAppend , 'enable', 'on');
end

% --- Executes on key press with focus on density and none of its controls.
function editBNP_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to density (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mnuNew_Callback(hObject, eventdata, handles)
% hObject    handle to mnuNew (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=inputdlg('Please enter the name of the data file','CaRTIN');
global dataFilename
global SaveFolder

dataFilename= strcat(SaveFolder,'\', a ,'.txt');
set(handles.txtDataFilename , 'String', dataFilename);
f=get(handles.txtDataFilename,'String');

fid = fopen(char(f),'a');
pCaSpark=get(handles.editRate,'String');
BNP=get(handles.editBNP,'String');

fprintf(fid,'%s %s \r\n','BNP','pCaSpark');
fclose(fid);
set(handles.btnSave , 'enable', 'on');
set(handles.btnView , 'enable', 'on');



% --- Executes on button press in btnView.
function btnView_Callback(hObject, eventdata, handles)
% hObject    handle to btnView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


f=get(handles.txtDataFilename,'String');
datas=importdata(char(f));
m_data=datas.data;

a1=m_data(:,1);
[a1,pos]=sort(a1);%����a1������֮��ģ�pos���������±�
a2=m_data(pos,2);

x=a1;
y=a2;
global regcoefficient

p=polyfit(x,y,4)
regcoefficient=p;
y1=polyval(p,x);
if p(1)>=0 
        f=strcat(num2str(p(1)),'x^4');
    else
        f=strcat('-',num2str(p(1)),'x^4');
end

for i=2 :4
    if p(i)>=0 
        xx=strcat('+',p(i));
    else
        xx=num2str(p(i));
    end
    f=strcat(f , xx , 'x^' ,num2str(5-i));
    
end

if p(5)>=0 
        f=strcat(f,'+',num2str(p(5)));
    else
        f=strcat(f,num2str(p(5)));
end
axes(handles.axes2);
cla(handles.axes2);
f=strcat('pCaSpark=',f,' (x=BNP)');
plot(x,y,'b.','MarkerSize',15);axis equal;axis([min(x)-5 max(x)+5 min(y)-5 max(y)+5]);
xlabel('BNP','Fontname', 'Times New Roman','FontSize',9);
ylabel('pCaSpark ','Fontname', 'Times New Roman','FontSize',9);
title (f,'Fontname', 'Times New Roman','FontSize',9);
hold on

plot(x,y1,'Color',[1 0 0])
set(handles.btnEstimate , 'enable', 'on');
set(handles.mnuEstimate , 'enable', 'on');


% --------------------------------------------------------------------
function mnuOpti_Callback(hObject, eventdata, handles)
% hObject    handle to mnuOpti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
btnView_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function mnuAppend_Callback(hObject, eventdata, handles)
% hObject    handle to mnuAppend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
btnSave_Callback(hObject, eventdata, handles)
