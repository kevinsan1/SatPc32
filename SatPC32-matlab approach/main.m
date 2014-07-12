%%%%%%%% All functions are called upon in this file %%%%%%%%%%%%%%%%%%%%%%%

% satpc32() outputs Az, El and Sat (Satellite name) from SatPC32.

% orbit() transmits the Az to the orbit unit, acuires the current rotor
% Az and controlls the rotor.

% yaseu() transmits the El, Az (for LCD) and satellite name (for LCD) to arduino,
% acuires the current rotor El and controlls the rotor.
%(Right now the arduino code do this but perhaps it is better if we do it in matlab instead).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function []=main()
delete(instrfind);

[chan] = satpc32_com();
[Az, El, Sat] = satpc32(chan);
previousElevation = El;
previousAzimuth = Az;
%%% Establish communication only once %%%%
comPortToArduino = 'COM15';
[arduinoCom, flag] = arduinoDisplay(comPortToArduino);
sport = orbit_com(Az);
%object = yaseu_com();
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' Az    El_SatPc32   El_Rotor   El_rotor_Mode   Satellite');

for i = 1:5
    
    [Az, El, Sat] = satpc32(chan);
    
    
    
    %%% Azimuth section - Orbit %%%%
    
    %          orbit(Az,sport)
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    %%% Elevation section - Arduino/Yaseu %%%
    elevationDirection = rotorDirection(El, previousElevation);
    azimuthDirection = rotorDirection(Az, previousAzimuth);
    fprintf(s,['e' El  elevationDirection]);
    pause(.1);
    fprintf(s,['a' Az  azimuthDirection]);
    %  [El_rotor, El_mode] = yaseu(El, object);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    fprintf( '%.2f',Az)
    fprintf( '  %.4f',El)
    %  fprintf( '  %.4f',El_rotor)
    % fprintf('    %s',El_mode)
    fprintf( '     %s\n',Sat)
    previousElevation = El;
    previousAzimuth = Az;
    pause(1);
    
    
    
end
delete(instrfind)

end



