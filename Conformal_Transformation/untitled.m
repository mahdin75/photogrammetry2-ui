function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 24-May-2017 12:52:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
movegui(hObject, 'center');

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Importing Fiducial Mark Coordinates

[N1,P1] = uigetfile('*.txt','Fiducial Marks');
fid1 = strcat(P1,N1);
fidM = dlmread(fid1);
global X;
global Y;
global R;

X = fidM(1:4,2);
Y = fidM(1:4,3);

R = length(X);

if R
    set(handles.text2,'backgroundColor','green');
else
    condi = 0;
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Acquisition of Machine Coordinate for Fiducial Marks for Left Image

global X;
global Y;
global R;
global X_L_A;
%% Importing Left Image
[N3,P3] = uigetfile('*.tif','Left Image');
fid3 = strcat(P3,N3);
Im_L = imread(fid3);

Img_L = rgb2gray(Im_L);

figure(1)
imshow(Img_L)

%% Acquisition of Machine Coordinate for Fiducial Marks for Left Image

for i = 1:R
    pause
    [x_L(i) y_L(i)] = ginput(1)
end
%% Performing Conformal Transformation to find the relation between Machine and Image Systems
for j = 1:length(X)
    A_L_A(2*j-1:2*j,:) = [ceil(x_L(j)) -ceil(y_L(j)) 1 0; ceil(y_L(j)) ceil(x_L(j)) 0 1];
end

for k = 1:length(X)
    l_L_A(2*k-1:2*k,1) = [X(k) Y(k)];
end

X_L_A = inv(A_L_A'*A_L_A)*(A_L_A'*l_L_A)

l_L_A_Calc = A_L_A * X_L_A;
dif_L_A = l_L_A - l_L_A_Calc;
dif2_L_A = dif_L_A.^2;
RMSE_L_A = (sqrt(sum(dif2_L_A)))/(length(l_L_A_Calc)-1)

global condi;
    if X_L_A
 %   if RMSE_L_A>.001
  %      msgbox('error: your percision is not good!');
   %     condi = 0;
    %end
    condi = 1;
set(handles.text3,'backgroundColor','green');
 set(handles.pushbutton3,'Enable','on');
    end



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Performing Conformal Transformation to find the Image Coordinates for all pixels

global condi;

if condi == 1
    
    global X_L_A;
    for ii = 1:1
    x_A_Mach(ii)=str2num(get(handles.edit1,'String'));
    y_A_Mach(ii)=str2num(get(handles.edit3,'String'));
    end

    for jj = 1:ii
        A_L_A_Mach(2*jj-1:2*jj,:) = [ceil(x_A_Mach(jj)) -ceil(y_A_Mach(jj)) 1 0;ceil(y_A_Mach(jj)) ceil(x_A_Mach(jj)) 0 1];
    end
    X_L_A
    A_L_A_Mach

    l_L_A_Cal = A_L_A_Mach * X_L_A;

    set(handles.text4,'String',num2str(l_L_A_Cal(1)));
    set(handles.text7,'String',num2str(l_L_A_Cal(2)));

end

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('This program is to do conformal trsansformation.   1. first you should Import txt file that includes fiducial marks coordinats.  2.then import ur image and mark fiducial 1 , 2 ,3 ,4.   3. after u have 2 green lights Enter a pixel coordinate then click on compute so photogrammetric coordinates will coumput! ');

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit1,'String','');
set(handles.edit3,'String','');
set(handles.text4,'String','');
set(handles.text7,'String','');
set(handles.text2,'backgroundColor','red');
set(handles.text3,'backgroundColor','red');
clear All;
