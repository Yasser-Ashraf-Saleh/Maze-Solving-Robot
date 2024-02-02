function [C]=IN_MAP(K)
C=1;
K=[K(:,1)',K(:,2)'];
if (any(K(:,1)'>4.7))|(any(K(:,1)'<-3.5))|(any(K(:,2)'<-5.3))|(any(K(:,2)'>4.8))
    C=0;
end
end