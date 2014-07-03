%%%%%%% Arduino controller %%%%%%%%%%%%%%
% This files decides whether the rotor goes up or down <=>  pins low (0)
% or high (1). 


% Arduino object is currently 'a'

function []=yaseu(El);

% Constants %%%%%%%%%%%%%%%%%%%%%55

elAdZeroOffset   =   0;  % adjust to zero out lcd el reading when control box el = 0


% Declare PINS

el_input_pin = 1; %A1 not required, pinmode not required.   
el_up_pin = 8;
el_down_pin = 9;

a.pinMode(el_up_pin , 'OUTPUT')
a.pinMode(el_down_pin , 'OUTPUT')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Code so that analogread translates into a current Elevation degree called
% rotor_El. 

if rotor_El ~= El
    if rotor_El < El
        a.digitalWrite(el_up_pin, 1) % 1 <=> go high
    else 
        a.digitalWrite(el_down_pin, 1) 
    end
    disp('Elevation is already correct')
end 