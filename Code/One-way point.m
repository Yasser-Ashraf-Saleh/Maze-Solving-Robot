% PID program for a mobile robot (waypoint follower): 1 point
close all
?
% object vrep ~ vrep software
vrep=remApi('remoteApi');
?
% close everything 
vrep.simxFinish(-1);
?
% client to vrep
clientID=vrep.simxStart('127.0.0.1', 19997, true, true, 5000, 5);
% (server,port,waitUntilConnected,doNotReconnectOnceDisconnected,timeOutInMs,commThreadCycleInMs) 
?
% start simulation
vrep.simxStartSimulation(clientID, vrep.simx_opmode_oneshot)
?
% get handles: robot, left motor and right motor
[res, rob] = vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx', vrep.simx_opmode_blocking);
[res, Left_Motor] = vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx_leftMotor', vrep.simx_opmode_blocking);
[res, right_Motor] = vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx_rightMotor', vrep.simx_opmode_blocking);
?
?
%%
    
% desired location
Pd = [3, 4];
% Pd = [3, -1];
% Pd = [3, -2];
% Pd = [3, -3];
% Pd = [3, -4];
?
% go to location by using PID
[X, Y]= gotoDesired(vrep, Pd, clientID, rob, Left_Motor, right_Motor)
?
% plot
plot(X, Y) % trajectory of robot
hold on
plot(Pd(1), Pd(2), 'or') % desired location
?
?
% stop simulation
% vrep.simxStopSimulation(clientID, vrep.simx_opmode_oneshot)