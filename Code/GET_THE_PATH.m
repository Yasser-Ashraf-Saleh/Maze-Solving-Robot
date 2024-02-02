function [PATH]=GET_THE_PATH(CLOSED_ARRAY)
[r,c]=size(CLOSED_ARRAY);
PATH=[CLOSED_ARRAY(1:4,c-1:c)];
for i=c:-2:1
    m1=mean(PATH(:,1:2));
    m2=mean(CLOSED_ARRAY(5:8,i-1:i));
    TEST=sqrt((m1(1)-m2(1))^2+(m1(2)-m2(2))^2);
    if TEST<0.1
        PATH=[CLOSED_ARRAY(1:4,i-1:i),PATH];
    end
end