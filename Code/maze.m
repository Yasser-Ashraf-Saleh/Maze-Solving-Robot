clear all
close all
clc
vrep=remApi('remoteApi');
%close_every_thing
vrep.simxFinish(-1);
clientID=vrep.simxStart('127.0.0.1',19997,true,true,5000,5)
% start simulation
if (clientID>-1)
    Actions=[];
    Goal=[-3.3,-0.55];
    [res,C1]=vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx',vrep.simx_opmode_blocking);
    [res,R]=vrep.simxGetObjectPosition(clientID,C1,-1,vrep.simx_opmode_blocking);
    R(1)=R(1)+0.30;
    R(2)=R(2)+0.30;
    START=[R(1),R(2)];
    [Shapes,ROBPOLY]=MAP(clientID,vrep);
    [PATH]=DFS(clientID,vrep,Shapes,ROBPOLY,Actions,Goal,START);
    vrep.simxStartSimulation(clientID, vrep.simx_opmode_oneshot);
    [res, rob] = vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx', vrep.simx_opmode_blocking);
    [res, Left_Motor] = vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx_leftMotor', vrep.simx_opmode_blocking);
    [res, right_Motor] = vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx_rightMotor', vrep.simx_opmode_blocking);
    LP=length(PATH);
    for i=1:4:LP-1
        Pd =mean(PATH(:,i:i+1));
        [X, Y]= gotoDesired(vrep, Pd, clientID, rob, Left_Motor, right_Motor);
    end
    % stop simulation
    vrep.simxStopSimulation(clientID, vrep.simx_opmode_oneshot)
end