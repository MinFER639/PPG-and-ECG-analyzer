function varargout = MichalGrabarczyk(varargin)
% MICHALGRABARCZYK MATLAB code for MichalGrabarczyk.fig
%      MICHALGRABARCZYK, by itself, creates a new MICHALGRABARCZYK or raises the existing
%      singleton*.
%
%      H = MICHALGRABARCZYK returns the handle to a new MICHALGRABARCZYK or the handle to
%      the existing singleton*.
%
%      MICHALGRABARCZYK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MICHALGRABARCZYK.M with the given input arguments.
%
%      MICHALGRABARCZYK('Property','Value',...) creates a new MICHALGRABARCZYK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MichalGrabarczyk_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MichalGrabarczyk_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MichalGrabarczyk

% Last Modified by GUIDE v2.5 04-Jul-2020 14:32:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MichalGrabarczyk_OpeningFcn, ...
    'gui_OutputFcn',  @MichalGrabarczyk_OutputFcn, ...
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


% --- Executes just before MichalGrabarczyk is made visible.
function MichalGrabarczyk_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MichalGrabarczyk (see VARARGIN)

% Choose default command line output for MichalGrabarczyk
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MichalGrabarczyk wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MichalGrabarczyk_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OpenSyg.
function OpenSyg_Callback(hObject, eventdata, handles)
% hObject    handle to OpenSyg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global struct
global struct1

[File,Path]=uigetfile({'*.mat'});
[File1,~]=uigetfile({'*.mat'});
set(handles.text3,'string',join(["Nazwa: ",File]));
set(handles.text6,'string',join(["Œcie¿ka dostêpu: ",Path]));
set(handles.text8,'string',join(["Nazwa: ",File1]));

struct=load(File);
len=length(struct.sig)/250;
Ts=1/250;
t=0:Ts:len-Ts;
struct.t=t;

struct1=load(File1);
len1=length(struct1.sig)/250;
t1=0:Ts:len1-Ts;
struct1.t=t1;

set(handles.text4,'string',join(["D³ugoœæ: ",len]));
set(handles.text5,'string',join(["Typ: ",struct.sigType]));

set(handles.text9,'string',join(["D³ugoœæ: ",len1]));
set(handles.text10,'string',join(["Typ: ",struct1.sigType]));

if isequal(struct.sigType, 'ecg')
    set(handles.axes1,'NextPlot','replace');
    plot(handles.axes1,t,struct.sig);
    set(handles.axes1,'NextPlot','add');
    plot(handles.axes1,struct.ar_pts/250, struct.sig(struct.ar_pts));
    set(handles.axes1,'XGrid','on');
    set(handles.axes1,'YGrid','on');
    title(handles.axes1,'EKG');
elseif isequal(struct.sigType, 'ppg')
    set(handles.axes1,'NextPlot','replace');
    plot(handles.axes1,t,struct.sig);
    set(handles.axes1,'NextPlot','add');
    plot(handles.axes1,struct.ad_pts/250, struct.sig(struct.ad_pts));
    plot(handles.axes1,struct.add_pts/250, struct.sig(struct.add_pts));
    set(handles.axes1,'XGrid','on');
    set(handles.axes1,'YGrid','on');
    title(handles.axes1,'PPG');
end

if isequal(struct1.sigType, 'ecg')
    set(handles.axes3,'NextPlot','replace');
    plot(handles.axes3,t,struct1.sig);
    set(handles.axes3,'NextPlot','add');
    plot(handles.axes3,struct1.ar_pts/250, struct1.sig(struct1.ar_pts));
    set(handles.axes3,'XGrid','on');
    set(handles.axes3,'YGrid','on');
    title(handles.axes3,'EKG');
elseif isequal(struct1.sigType, 'ppg')
    set(handles.axes3,'NextPlot','replace');
    plot(handles.axes3,t,struct1.sig);
    set(handles.axes3,'NextPlot','add');
    plot(handles.axes3,struct1.ad_pts/250, struct1.sig(struct1.ad_pts));
    plot(handles.axes3,struct1.add_pts/250, struct1.sig(struct1.add_pts));
    set(handles.axes3,'XGrid','on');
    set(handles.axes3,'YGrid','on');
    title(handles.axes3,'PPG');
end


% --- Executes on button press in Anzalize.
function Anzalize_Callback(hObject, eventdata, handles)
% hObject    handle to Anzalize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global struct
global struct1
global popup_var

dispVal=zeros(1, length(struct.sig));
dispVal1=zeros(1, length(struct1.sig));

switch popup_var
    case 2
        %AMPLITUDA
        %BRAK FUNKCJI GETAMP
    case 3
        %ZMIENNOŒÆ AMPLITUDY
        %BRAK FUNKCJI GETAMP
    case 4
        %D£UGOŒÆ
        for i=1:length(struct.s1)
           dispVal(struct.s1(i):struct.s2(i))=length(struct.sig(struct.s1(i):struct.s2(i))); 
        end
        
        for i=1:length(struct1.s1)
           dispVal1(struct1.s1(i):struct1.s2(i))=length(struct1.sig(struct1.s1(i):struct1.s2(i))); 
        end
    case 5
        %ZMIENNOŒÆ D£UGOŒCI
        for i=1:length(struct.s1)
           lenVal(i)=length(struct.sig(struct.s1(i):struct.s2(i))); 
        end
        rlenVal=lenVal(2:end)-lenVal(1:end -1);
        rlenVal=[0 rlenVal];
        
        for i=1:length(struct.s1)
            dispVal(struct.s1(i):struct.s2(i))=rlenVal(i);
        end
        
        
        for i=1:length(struct1.s1)
           lenVal(i)=length(struct1.sig(struct1.s1(i):struct1.s2(i))); 
        end
        rlenVal=lenVal(2:end)-lenVal(1:end -1);
        rlenVal=[0 rlenVal];
        
        for i=1:length(struct1.s1)
            dispVal1(struct1.s1(i):struct1.s2(i))=rlenVal(i);
        end
        
    case 6
        %ŒREDNIA
        for i=1:length(struct.s1)
            dispVal(struct.s1(i):struct.s2(i))=mean(struct.sig(struct.s1(i):struct.s2(i)));
        end
        
        for i=1:length(struct1.s1)
            dispVal1(struct1.s1(i):struct1.s2(i))=mean(struct1.sig(struct1.s1(i):struct1.s2(i)));
        end
        
    case 7
        %ENERGIA
        %BRAK FUNKCJI GETENERGY
    case 8
        %WARJANCJA
        for i=1:length(struct.s1)
            dispVal(struct.s1(i):struct.s2(i))=var(struct.sig(struct.s1(i):struct.s2(i)));
        end
        
        for i=1:length(struct1.s1)
            dispVal1(struct1.s1(i):struct1.s2(i))=var(struct1.sig(struct1.s1(i):struct1.s2(i)));
        end
    case 9
        %ODCHYLENIE
        for i=1:length(struct.s1)
            dispVal(struct.s1(i):struct.s2(i))=std(struct.sig(struct.s1(i):struct.s2(i)));
        end
        
        for i=1:length(struct1.s1)
            dispVal1(struct1.s1(i):struct1.s2(i))=std(struct1.sig(struct1.s1(i):struct1.s2(i)));
        end
    case 10
        %SKOŒNOŒÆ
        for i=1:length(struct.s1)
            dispVal(struct.s1(i):struct.s2(i))=skewness(struct.sig(struct.s1(i):struct.s2(i)));
        end
        
        for i=1:length(struct1.s1)
            dispVal1(struct1.s1(i):struct1.s2(i))=skewness(struct1.sig(struct1.s1(i):struct1.s2(i)));
        end
    case 11
        %KURTOZA
        for i=1:length(struct.s1)
            dispVal(struct.s1(i):struct.s2(i))=kurtosis(struct.sig(struct.s1(i):struct.s2(i)));
        end
        
        for i=1:length(struct1.s1)
            dispVal1(struct1.s1(i):struct1.s2(i))=kurtosis(struct1.sig(struct1.s1(i):struct1.s2(i)));
        end
end
set(handles.axes2,'NextPlot','replace');
plot(handles.axes2,struct.t,dispVal);
set(handles.axes2,'XGrid','on');
set(handles.axes2,'YGrid','on');

set(handles.axes4,'NextPlot','replace');
plot(handles.axes4,struct1.t,dispVal1);
set(handles.axes4,'XGrid','on');
set(handles.axes4,'YGrid','on');

% --- Executes on button press in End.
function End_Callback(hObject, eventdata, handles)
% hObject    handle to End (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq();

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

global popup_var
popup_var=get(hObject,'Value');


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
