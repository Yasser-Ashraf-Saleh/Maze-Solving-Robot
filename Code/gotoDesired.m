function [X, Y]= gotoDesired(vrep, Pd, clientID, rob, Left_Motor, right_Motor)
% from current position to Pd (x,y)
xr = Pd(1);
yr = Pd(2);
dt = 0.05; 
Kp = 0.6;
Ki = 0.1;
Kd = 0;
Kpo = 0.03;
Kio = 0.01;
Kdo = 0;
DT =0.08;
D = Inf;
PE = 0; IE = 0;
PEo = 0; IEo = 0;
X= []; Y = [];
while (D > DT)
    D
    % current position of robot
    [res, po] = vrep.simxGetObjectPosition(clientID, rob, -1, vrep.simx_opmode_blocking);
    % get x-y coordinates of robot
    x = po(1); y = po(2);
    X = [X x]; Y = [Y y];
    % current orientation of robot
    [res, or] = vrep.simxGetObjectOrientation(clientID, rob, -1, vrep.simx_opmode_blocking);
    theta = or(3);
        % compute cross product
    v1 = [cos(theta), sin(theta), 0];
    v2 = [xr, yr, 0] - [x, y, 0]; 
    dv = dot(v2, v1)/norm(v2);
    if abs(dv-1) < 1e-5; dv = 1; end % accuracy problem in Matlab
    phi = acos( dv )*180/pi; % deg. system 
    cp = cross(v1, v2);
    % Error in orientation
    phiE = sign(cp(3))*phi;
    % Error euclidean
    D = norm( [x, y] - [xr, yr] );
    % PID for euclidean error
    IE = IE + D*dt;
    DE = (D - PE)/dt;
    v = Kp*D  + Ki*IE + Kd*DE; % linear velocity
    PE = D;
    % PID for orientation
    IEo = IEo + phiE*dt;
    DEo = (phiE - PEo)/dt;
    w = Kpo*phiE  + Kio*IEo + Kdo*DEo; %%angular vel.
    PEo = phiE;
    L = 0.3310; % distance between wheels
    Wr = 0.1; % radius of wheel
    wr = (v + L*w)/Wr; % angular speed in right wheel
    wl = (v - L*w)/Wr;  % angular speed in left wheel
    % set speed in left and right wheels
    [res]=vrep.simxSetJointTargetVelocity(clientID, Left_Motor, wl, vrep.simx_opmode_oneshot);
    [res]=vrep.simxSetJointTargetVelocity(clientID, right_Motor, wr, vrep.simx_opmode_oneshot); 
end     
end