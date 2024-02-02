function [OBJECTVERTICES,ROBOTPOLY]=MAP(clientID,vrep)
OBJECTS=["Cuboid0","Cuboid1","Cuboid2","Cuboid3","Cuboid4","Cuboid5","Cuboid6","Cuboid7","Cuboid8","Cuboid9","Cuboid10","Cuboid11","Cuboid12","Cuboid13","Cuboid14","Cuboid15","Cuboid16","Cuboid17","Cuboid18","Cuboid19","Cuboid20","Cuboid21","Cuboid22","Cuboid23","Cuboid24","Cuboid25"];
OBJECTS_dim=[8.5,0.2;3,0.2;0.2,10;0.2,4;4.5,0.2;0.2,1.5;2,0.2;0.2,1.5;2,0.2;0.2,3.5;4,0.2;0.2,5;3,0.2;1,0.2;0.2,1;2.5,0.2;3,0.2;0.2,1.3;1,0.2;0.2,1;2,0.2;0.2,7;1.5,0.2;0.2,1;1,0.2;0.2,5];
OBJECTCENTRES=[];
OBJECTVERTICES=[];
LEN=length(OBJECTS);
for i=1:LEN
    [res,C1]=vrep.simxGetObjectHandle(clientID,convertStringsToChars(OBJECTS(1,i)),vrep.simx_opmode_blocking);
    [res,OBJECTCENTRES(1:3,i)]=vrep.simxGetObjectPosition(clientID,C1,-1,vrep.simx_opmode_blocking);
end
for i=1:LEN
    OBJECTVERTICES(1,2*i-1:2*i)=[OBJECTCENTRES(1,i)-0.5*OBJECTS_dim(i,1),OBJECTCENTRES(2,i)-0.5*OBJECTS_dim(i,2)];
    OBJECTVERTICES(2,2*i-1:2*i)=[OBJECTCENTRES(1,i)+0.5*OBJECTS_dim(i,1),OBJECTCENTRES(2,i)-0.5*OBJECTS_dim(i,2)];    
    OBJECTVERTICES(3,2*i-1:2*i)=[OBJECTCENTRES(1,i)+0.5*OBJECTS_dim(i,1),OBJECTCENTRES(2,i)+0.5*OBJECTS_dim(i,2)];    
    OBJECTVERTICES(4,2*i-1:2*i)=[OBJECTCENTRES(1,i)-0.5*OBJECTS_dim(i,1),OBJECTCENTRES(2,i)+0.5*OBJECTS_dim(i,2)];    
end
k=1;
for i=1:2:2*LEN
    P=polyshape(OBJECTVERTICES(:,i)',OBJECTVERTICES(:,i+1)')
    plot(P);
    hold on
end
[res,C1]=vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx',vrep.simx_opmode_blocking);
[res,R]=vrep.simxGetObjectPosition(clientID,C1,-1,vrep.simx_opmode_blocking);
ROBOTPOLY=polyshape([R(1)-0.26,R(1)+0.26,R(1)+0.26,R(1)-0.26],[R(2)-0.26,R(2)-0.26,R(2)+0.26,R(2)+0.26]);
plot(ROBOTPOLY);
hold on
end