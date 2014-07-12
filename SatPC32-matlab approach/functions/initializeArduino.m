function [s, flag] = arduinoDisplay(comPort)
if nargin < 1
    comPort = 'COM15';
end
flag = 1;
s = serial(comPort);
set(s,'DataBits', 8 );
set(s,'StopBits', 1 );
set(s,'BaudRate', 9600);
set(s,'Parity', 'none');
try
    fopen(s);
catch
    flag = 2;
end
% a = 'b';
% while ( a ~= 'a')
%     a = fread(s, 1, 'uchar');
% end
% if (a == 'a')
%     disp('serial read');
% end
% fprintf(s,'%c','a');
% mbox = msgbox('Serial Communication setup.');
% uiwait(mbox);
%%
% pause(1); %% needed
% fprintf(s,['e145' 'd']);
% pause(1);
% fprintf(s,'a45u');
% pause(1);
% fprintf(s,'e13d');
% pause(.1);
% fprintf(s,'a45s');
% %%
% fclose(s);
