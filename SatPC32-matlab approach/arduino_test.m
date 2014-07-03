% Create arduino object and connect to board, make sure arduino has the
% filed adio.pde sketch uploaded to it (or one of them)!

if exist('a','var') && isa(a,'arduino') && isvalid(a),
    % nothing to do    
else
    a=arduino('COM3');
end
%%


disp('Initializing Pins ...');
a.pinMode(9, 'OUTPUT')
a.pinMode(10, 'OUTPUT')


for c=1:10;

    c
    a.digitalWrite(9,1);
    a.digitalWrite(10,1);
    pause(0.1)
    a.digitalWrite(9,0);
    a.digitalWrite(10,0);
    pause(0.1)
end 


