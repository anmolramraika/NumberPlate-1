function varargout = HPU_gui(varargin)
% HPU_GUI MATLAB code for HPU_gui.fig
%      HPU_GUI, by itself, creates a new HPU_GUI or raises the existing
%      singleton*.
%
%      H = HPU_GUI returns the handle to a new HPU_GUI or the handle to
%      the existing singleton*.
%
%      HPU_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HPU_GUI.M with the given input arguments.
%
%      HPU_GUI('Property','Value',...) creates a new HPU_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HPU_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HPU_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HPU_gui

% Last Modified by GUIDE v2.5 15-Mar-2015 20:42:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HPU_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @HPU_gui_OutputFcn, ...
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


% --- Executes just before HPU_gui is made visible.
function HPU_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HPU_gui (see VARARGIN)

% Choose default command line output for HPU_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HPU_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HPU_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
old = cd('dataset');
handles.f = ls('*.jpg');
handles.c = 1;
cd(old);
guidata(hObject,handles);
varargout{1} = handles.output;

% --- Executes on button press in NextImage.
function NextImage_Callback(hObject, eventdata, handles)
cla reset
old = cd('dataset');
handles.I = imread(handles.f(handles.c,:),'jpg');
assignin('base','im',handles.I);
im = handles.I;
axes(handles.axes1);
handles.I1 = crop_cpu(im);
imshow(handles.I1);
axes(handles.axes2);
handles.I2 = crop_cpu_2(im);
imshow(handles.I2);
cd(old);
% handles.c = handles.c + 1;
guidata(hObject,handles);


% --- Executes on button press in PassImage.
function PassImage_Callback(hObject, eventdata, handles)
old = cd('crop_images');
filename = strcat('crop_',handles.f(handles.c,:));
imwrite(handles.I1,filename,'jpg');
cd(old);
handles.c = handles.c + 1;
axes(handles.axes1);
cla reset
axes(handles.axes2);
cla reset
guidata(hObject,handles);


% --- Executes on button press in CropImage.
function CropImage_Callback(hObject, eventdata, handles)
axes(handles.axes1);
cla reset
axes(handles.axes2);
cla reset
axes(handles.axes1);
imshow(handles.I);
handles.crop = imcrop(handles.I);
old = cd('crop_images');
filename = strcat('crop_',handles.f(handles.c,:));
imwrite(handles.crop,filename,'jpg');
cd(old);
axes(handles.axes2);
imshow(handles.crop);
handles.c = handles.c + 1;
guidata(hObject,handles);


% --- Executes on button press in PassImage2.
function PassImage2_Callback(hObject, eventdata, handles)
old = cd('crop_images');
filename = strcat('crop_',handles.f(handles.c,:));
imwrite(handles.I2,filename,'jpg');
cd(old);
handles.c = handles.c + 1;
axes(handles.axes1);
cla reset
axes(handles.axes2);
cla reset
guidata(hObject,handles);
