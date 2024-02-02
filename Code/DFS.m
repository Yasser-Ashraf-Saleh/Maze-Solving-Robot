function [PATH]=DFS(clientID,vrep,Shapes,ROBP,ACTIONS,GOAL,START)
dx=0.5;
dy=0.5;
EXPANDED_ARRAY=[[ROBP.Vertices(:,1),ROBP.Vertices(:,2)+dy],[ROBP.Vertices(:,1),ROBP.Vertices(:,2)-dy],[ROBP.Vertices(:,1)+dx,ROBP.Vertices(:,2)],[ROBP.Vertices(:,1)-dx,ROBP.Vertices(:,2)]];
CLOSED_ARRAY=[];
VISITED=[];
DRAFT=[[0 -dy];[0 dy];[-dx 0];[dx 0]];
TREE=[];
while length(EXPANDED_ARRAY)>0
    LE=length(EXPANDED_ARRAY);
    L=EXPANDED_ARRAY(:,1:2);
    EXPANDED_ARRAY=EXPANDED_ARRAY(:,3:LE);
    INTER=INTERSECT(clientID,vrep,L,Shapes);
    VISITED=[VISITED,L];
    J=0;
    CLOSED_ARRAY=[L,CLOSED_ARRAY];
    if INTER==0
        for j=1:4
            K=[L(:,1)+DRAFT(j,1),L(:,2)+DRAFT(j,2)];
            if IN_LIST(VISITED,K)==1
                if IN_MAP(K)==1
                    EXPANDED_ARRAY=[K,EXPANDED_ARRAY];
                    [r,c]=size(TREE)
                    TREE(:,c+1:c+2)=[L;K];
                    end
        end
        
        end
    A=polyshape(L);
    plot(A);
    pause(0.1);

    end
    %%if J==0
        %CA=length(CLOSED_ARRAY);
        %if CA>4
          %  CLOSED_ARRAY=CLOSED_ARRAY(:,3:CA);
       % end
    %end
   
    L_AVG=mean(L);
    TEST=sqrt((L_AVG(1)-GOAL(1))^2+(L_AVG(2)-GOAL(2))^2);
    if TEST<0.5
        break
    end
end
[PATH]=GET_THE_PATH(TREE)
end