function [sport, flag] = initializeAzimuthRotor( comPort )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
flag = 1;
sport = serial(comPort);
% sport = serial('/dev/tty.usbserial-PXHD6DXX');
% Prologix Controller 4.2 requires CR as command terminator, LF is
% optional. The controller terminates internal query responses with CR and
% LF. Responses from the instrument are passed through as is. (See Prologix
% Controller Manual)
sport.Terminator = 'CR/LF';

% Reduce timeout to 0.5 second (default is 10 seconds)
sport.Timeout = .5;
try
    fopen(sport);
    fprintf(sport, '++mode 1');
    fprintf(sport, '++addr 15');
    fprintf(sport, '++auto 1');
    fprintf(sport, '++clr');
catch
    flag = 2;
end
end

