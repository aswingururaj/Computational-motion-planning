x = [1,2,1]; 
y = [1,2,3];
P1 = [x;y]';

x = [3,4,4];
y = [4,2,4];
P2 = [x;y]';

line([P1(:,1)' P1(1,1)],[P1(:,2)' P1(1,2)],'Color','r')
line([P2(:,1)' P2(1,1)],[P2(:,2)' P2(1,2)],'Color','b')

flag = triangle_intersection(P1,P2);
if flag == 1
    disp("Intersection")
else
    disp("No Intersection")
end