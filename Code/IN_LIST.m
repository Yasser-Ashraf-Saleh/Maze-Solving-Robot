function [C]=IN_LIST(VISITED,K)
C=1;
K=[K(:,1)',K(:,2)'];
for i=1:2:length(VISITED)-2
    M=K==[VISITED(:,i)',VISITED(:,i+1)'];
    Q=M(8)*M(1)*M(2)*M(3)*M(4)*M(5)*M(6)*M(7);
    if Q==1
        C=0;
        break
    end
end
end