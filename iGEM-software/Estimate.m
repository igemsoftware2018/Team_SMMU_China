function varargout = Estimate(varargin)
% ESTIMATE MATLAB code for Estimate.fig
%      ESTIMATE, by itself, creates a new ESTIMATE or raises the existing
%      singleton*.
%
%      H = ESTIMATE returns the handle to a new ESTIMATE or the handle to
%      the existing singleton*.
%
%      ESTIMATE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ESTIMATE.M with the given input arguments.
%
%      ESTIMATE('Property','Value',...) creates a new ESTIMATE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Estimate_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Estimate_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Estimate

% Last Modified by GUIDE v2.5 12-Oct-2018 22:59:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Estimate_OpeningFcn, ...
                   'gui_OutputFcn',  @Estimate_OutputFcn, ...
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


% --- Executes just before Estimate is made visible.
function Estimate_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Estimate (see VARARGIN)

% Choose default command line output for Estimate
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

movegui(gcf,'center');


% UIWAIT makes Estimate wait for user response (see UIRESUME)
% uiwait(handles.figEstimated);


% --- Outputs from this function are returned to the command line.
function varargout = Estimate_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnExit.
function btnExit_Callback(hObject, eventdata, handles)
% hObject    handle to btnExit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.figEstimated)


% --- Executes on selection change in popAAV.
function popAAV_Callback(hObject, eventdata, handles)
% hObject    handle to popAAV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popAAV contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popAAV


% --- Executes during object creation, after setting all properties.
function popAAV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popAAV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editAAV_Callback(hObject, eventdata, handles)
% hObject    handle to editAAV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editAAV as text
%        str2double(get(hObject,'String')) returns contents of editAAV as a double


% --- Executes during object creation, after setting all properties.
function editAAV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editAAV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnEstimate.
function btnEstimate_Callback(hObject, eventdata, handles)
% hObject    handle to btnEstimate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
b=str2double(get(handles.editBNP,'String'));
percent=get(hObject,'Value');
if isnan(b)
    uicontrol(handles.editBNP); 
    errordlg('Please input BNP value first','Error'); 
    return
end

aavtype=[0.2 0.3 0.4 0.5 0.2 0.7 0.15 0.3 0.9];
promoter=[0.8 0.2 0.5 0.4 0.6 0.45];

%두똑=aavtype*promtoer*133*1014
atype=1/aavtype(get(handles.popAAV,'value'));
prom=1/promoter(get(handles.popPromoter,'value'));

aav=fix(atype*prom*b*1.33*1014/percent);
set(handles.editAAV , 'String', num2str(aav));




function editBNP_Callback(hObject, eventdata, handles)
% hObject    handle to editBNP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editBNP as text
%        str2double(get(hObject,'String')) returns contents of editBNP as a double


% --- Executes during object creation, after setting all properties.
function editBNP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editBNP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popPromoter.
function popPromoter_Callback(hObject, eventdata, handles)
% hObject    handle to popPromoter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popPromoter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popPromoter


% --- Executes during object creation, after setting all properties.
function popPromoter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popPromoter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f=str2num(get(handles.editBNP,'String'));
global regcoefficient
y=polyval(regcoefficient,f)
set(handles.text7 , 'String', num2str(y));
set(handles.edit3 , 'String', num2str(y));



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
percent=get(hObject,'Value');
old=str2num(get(handles.text7 , 'String'));
nnew=old*percent;
set(handles.edit3 , 'String', num2str(nnew));
b=str2double(get(handles.editBNP,'String'));

if isnan(b)
    uicontrol(handles.editBNP); 
    errordlg('Please input BNP value first','Error'); 
    return
end

aavtype=[0.2 0.3 0.4 0.5 0.2 0.7 0.15 0.3 0.9];
promoter=[0.8 0.2 0.5 0.4 0.6 0.45];

%두똑=aavtype*promtoer*133*1014
atype=1/aavtype(get(handles.popAAV,'value'));
prom=1/promoter(get(handles.popPromoter,'value'));

aav=fix(atype*prom*b*1.33*1014/percent);
set(handles.editAAV , 'String', num2str(aav));


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
