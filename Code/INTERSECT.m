function [I]=INTERSECT(clientID,vrep,L,OBJECTVERTICES)
I=0;
LEN=26;
for i=1:2:2*LEN
    P=polyshape(OBJECTVERTICES(:,i)',OBJECTVERTICES(:,i+1)');
    OUT=intersect(P,L);
    if length(OUT)>0
        I=1;
        break
    end
end

end