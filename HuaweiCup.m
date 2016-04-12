function varargout = HuaweiCup(varargin)
%HUAWEICUP M-file for HuaweiCup.fig
%      HUAWEICUP, by itself, creates a new HUAWEICUP or raises the existing
%      singleton*.
%
%      H = HUAWEICUP returns the handle to a new HUAWEICUP or the handle to
%      the existing singleton*.
%
%      HUAWEICUP('Property','Value',...) creates a new HUAWEICUP using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to HuaweiCup_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      HUAWEICUP('CALLBACK') and HUAWEICUP('CALLBACK',hObject,...) call the
%      local function named CALLBACK in HUAWEICUP.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HuaweiCup

% Last Modified by GUIDE v2.5 30-May-2015 10:18:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HuaweiCup_OpeningFcn, ...
                   'gui_OutputFcn',  @HuaweiCup_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before HuaweiCup is made visible.
function HuaweiCup_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for HuaweiCup
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HuaweiCup wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HuaweiCup_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_start.
function btn_start_Callback(hObject, eventdata, handles)
% hObject    handle to btn_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
addpath Perceptron-Algorithms-master
NumOfImage = get(handles.NumOfImage,'String');
NumOfImage = str2num(NumOfImage);
if(NumOfImage<=0)
    errordlg('Please Input the Number of images to recognize!','Error');
    return;
end

if get(handles.raBtn_MP4,'value') == 1;
     id=1; % Set the editbox string.
elseif get(handles.raBtn_Abacus,'value') == 1;
     id =2;
elseif get(handles.raBtn_Keyboard,'value')==1;
      id=3;
elseif get(handles.raBtn_RemoteControl,'value')==1;
         id=4;
elseif get(handles.raBtn_MobilePhone,'value')==1;
        id=5;
else
        msgbox('none,please select a catgory of images!') % Very unlikely I think.
        return;
end

[index] = LabelAllData(id);

for j = 1:NumOfImage
    i = index(j);
    fprintf('indexµÄÖµ %d\n',i);
    filename = ['image\' num2str(i) '.png'];
    im1=imread(filename);
    axes(handles.axe_currentImage);
    imshow(im1);
    set(handles.staTex_state,'String','Recognizing£¬please wait£¡');
    [recogTime label] = ImgRecognize(j,id);
    TimeString = [num2str(recogTime) ' sec.'];
    set(handles.text5,'String',TimeString);
    set(handles.staTex_state,'String','Finish recognizing£¡');
    set(handles.text4,'UserData',id);
    set(handles.staTex_state,'UserData',label);
    if(label == 0)
        set(handles.staText_YesNo,'String','No£¡It is not the image I want.');
       
    end
    if(label == 1)
        set(handles.staText_YesNo,'String','Yes£¡It is the image I want.');
      
    end
       pause;
end

guidata(hObject, handles);



% --- Executes on button press in bt_rightOrWrong.
function bt_rightOrWrong_Callback(hObject, eventdata, handles)
% hObject    handle to bt_rightOrWrong (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
addpath SpeechRec
set(handles.staTex_state,'String','Press any key to start 2 seconds of speech recording...');
result = VocRecognition();
if result == 3
    set(findobj('tag','staTex_state'),'String','The word you have said could not be properly recognised. Please say agin.');
else if result == 4
        set(findobj('tag','staTex_state'),'String','No microphone connected or you have not said anything. Please say agin.');
    else
        result = mod(result,2);
        label = get(findobj('tag','staTex_state'),'UserData');
        id = get(findobj('tag','text4'),'UserData');
        if(result==0)
            set(findobj('tag','staTex_state'),'String','You have just said No. The result of image recognition is wrong! Finetuning the model!');
            Finetune(~label,id);
        else if(result == 1)
                set(findobj('tag','staTex_state'),'String','You have just said Yes. The result of image recognition is right!');
            end
        end
    end
end

guidata(hObject, handles);





function NumOfImage_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NumOfImage = get(hObject,'String');
NumOfImage = str2num(NumOfImage);
% Hints: get(hObject,'String') returns contents of NumOfImage as text
%        str2double(get(hObject,'String')) returns contents of NumOfImage as a double


% --- Executes during object creation, after setting all properties.
function NumOfImage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_Stop.
function btn_Stop_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;
return;
%guidata(hObject, handles);
