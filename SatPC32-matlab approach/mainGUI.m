function varargout = mainGUI(varargin)
% MAINGUI MATLAB code for mainGUI.fig
%      MAINGUI, by itself, creates a new MAINGUI or raises the
%      existing singleton*.
%
%      H = MAINGUI returns the handle to a new MAINGUI or the
%      handle to the existing singleton*.
%
%      MAINGUI('CALLBACK',hObject,eventData,handles,...) calls
%      the local function named CALLBACK in MAINGUI.M with the
%      given input arguments.
%
%      MAINGUI('Property','Value',...) creates a new MAINGUI or
%      raises the existing singleton*.  Starting from the left,
%      property value pairs are applied to the GUI before
%      mainGUI_OpeningFcn gets called.  An unrecognized property
%      name or invalid value makes property application stop. All
%      inputs are passed to mainGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI
%      allows only one instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mainGUI

% Last Modified by GUIDE v2.5 13-Jul-2014 16:17:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @mainGUI_OpeningFcn, ...
    'gui_OutputFcn',  @mainGUI_OutputFcn, ...
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


% --- Executes just before mainGUI is made visible.
function mainGUI_OpeningFcn(hObject, eventdata, handles, ...
    varargin)
% This function has no output args, see OutputFcn. hObject handle
% to figure eventdata  reserved - to be defined in a future
% version of MATLAB handles    structure with handles and user
% data (see GUIDATA) varargin   command line arguments to mainGUI
% (see VARARGIN) Choose default command line output for mainGUI
delete(instrfind);
handles.output = hObject;
handles.comsAvailable = getAvailableComPort;
% Update handles structure
guidata(hObject, handles);


% UIWAIT makes mainGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command
% line.
function varargout = mainGUI_OutputFcn(hObject, eventdata, ...
    handles)
% varargout  cell array for returning output args (see
% VARARGOUT); hObject    handle to figure eventdata  reserved -
% to be defined in a future version of MATLAB handles structure
% with handles and user data (see GUIDATA) Get default command
% line output from handles structure
handles.comsAvailable = getAvailableComPort;
set(handles.arduinoPort, 'String', handles.comsAvailable);
set(handles.azimuthPort, 'String', handles.comsAvailable);
% handles.chan = satpc32_com();
varargout{1} = handles.output;


% --- Executes on button press in connectToInstruments.
function connectToInstruments_Callback(hObject, eventdata, ...
    handles)
% hObject    handle to connectToInstruments (see GCBO) eventdata
% reserved - to be defined in a future version of MATLAB handles
% structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.arduinoPort,'String'));
arduinoPortName = contents{get(handles.arduinoPort,'Value')};
azimuthPortName = contents{get(handles.azimuthPort,'Value')};
[handles.arduinoCom, flag] = initializeArduino(arduinoPortName);
[handles.azimuthCom, flag2] = ...
    initializeAzimuthRotor(azimuthPortName);
switch (flag)
    case 1
        set(handles.edit2, 'String',...
            strvcat('Connected to Arduino',...
            get(handles.edit2,'String')));
    case 2
        set(handles.edit2, 'String',...
            strvcat('Not Connected to Azimuth',...
            get(handles.edit2,'String')));
end

switch (flag2)
    case 1
        set(handles.edit2, 'String',...
            strvcat('Connected to Azimuth',...
            get(handles.edit2,'String')));
    case 2
        set(handles.edit2, 'String',...
            strvcat('Not connected to Azimuth',...
            get(handles.edit2,'String')));
end

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in stopSatPC32.
function stopSatPC32_Callback(hObject, eventdata, handles)
% hObject    handle to stopSatPC32 (see GCBO) eventdata  reserved
% - to be defined in a future version of MATLAB handles structure
% with handles and user data (see GUIDATA)


% index% returns toggle state of stopSatPC32


% --- Executes on button press in startSatPC32.
function startSatPC32_Callback(hObject, eventdata, handles)
% hObject    handle to startSatPC32 (see GCBO) eventdata reserved
% - to be defined in a future version of MATLAB handles structure
% with handles and user data (see GUIDATA)
try
    [Az, El, Sat] = satpc32(handles.chan);
end
isStopButtonPushed = get(handles.stopSatPC32, 'Value');
count = 1;
while isStopButtonPushed ~= 1 || count == 1
    try
        lastString = get(handles.edit2, 'String');
    end
    set(handles.edit2, 'String', ...
        strvcat(num2str(count), get(handles.edit2, 'String')));
    isStopButtonPushed = get(handles.stopSatPC32, 'Value');
    count = count + 1;
    pause(0.01);
end


% --- Executes on button press in clearInstrumentConnections.
function clearInstrumentConnections_Callback(hObject,  ...
    eventdata, handles)
% hObject    handle to clearInstrumentConnections (see GCBO)
% eventdata  reserved - to be defined in a future version of
% MATLAB handles    structure with handles and user data (see
% GUIDATA)
delete(instrfind);
handles.comsAvailable = getAvailableComPort;
set(handles.arduinoPort, 'String', handles.comsAvailable);
set(handles.azimuthPort, 'String', handles.comsAvailable);
set(handles.edit2, 'String', '');


% --- Executes on selection change in arduinoPort.
function arduinoPort_Callback(hObject, eventdata, handles)
% hObject    handle to arduinoPort (see GCBO) eventdata  reserved
% - to be defined in a future version of MATLAB handles structure
% with handles and user data (see GUIDATA)
% set(handles.arduinoPort, 'String', handles.comsAvailable);
% handles.portSelected = get(handles.arduinoPort, 'String');

% --- Executes on selection change in azimuthPort.
function azimuthPort_Callback(hObject, eventdata, handles)
% hObject    handle to azimuthPort (see GCBO) eventdata  reserved
% - to be defined in a future version of MATLAB handles structure
% with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns
% azimuthPort contents as cell array
%        contents{index} returns selected item
%        from azimuthPort

% --- Executes during object creation, after setting all
% properties.
function azimuthPort_CreateFcn(hObject, eventdata, handles)
% hObject    handle to azimuthPort (see GCBO) eventdata  reserved
% - to be defined in a future version of MATLAB handles    empty
% - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on
% Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% set(hObject, 'String', '');

% --- Executes during object creation, after setting all
% properties.
function arduinoPort_CreateFcn(hObject, eventdata, handles)
% hObject    handle to arduinoPort (see GCBO) eventdata  reserved
% - to be defined in a future version of MATLAB handles    empty
% - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on
% Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% str = {['Since its founding in 1984, MathWorks has become the leading ',...
%    'global provider of technical computing and model-based design ',...
% 'software. Headquartered in Natick, Massachusetts, MathWorks ',...
% 'currently employs more than 1,000 people worldwide. Since its founding in 1984, MathWorks has become the leading ',...
%    'global provider of technical computing and model-based design ',...
% 'software. Headquartered in Natick, Massachusetts, MathWorks ',...
% 'currently employs more than 1,000 people worldwide. Since its founding in 1984, MathWorks has become the leading ',...
%    'global provider of technical computing and model-based design ',...
% 'software. Headquartered in Natick, Massachusetts, MathWorks ',...
% 'currently employs more than 1,000 people worldwide. Since its founding in 1984, MathWorks has become the leading ',...
%    'global provider of technical computing and model-based design ',...
% 'software. Headquartered in Natick, Massachusetts, MathWorks ',...
% 'currently employs more than 1,000 people worldwide. ']};
% set(hObject, 'String', str);
