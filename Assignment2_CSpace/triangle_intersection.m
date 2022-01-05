function flag = triangle_intersection(P1, P2)
% triangle_test : returns true if the triangles overlap and false otherwise

%%% All of your code should be between the two lines of stars.
% *******************************************************************
flag = true;
count = 0;
for i=0:5
    if i<3
        [m,c] = findLine(P1((mod(i,3)+1),1),P1((mod(i,3)+1),2),P1((mod(i+1,3)+1),1),P1((mod(i+1,3)+1),2));    
        [flag, zero_flag] = checkSign(P1,P2,m,c,i);
        if flag == false
            break
        end
        if zero_flag == true
            count = count + 1;
        end
    end
    if i > 2
        [m,c] = findLine(P2((mod(i-3,3)+1),1),P2((mod(i-3,3)+1),2),P2((mod(i-2,3)+1),1),P2((mod(i-2,3)+1),2));
        [flag,zero_flag] = checkSign(P1,P2,m,c,i);
        if flag == false
            break
        end
        if zero_flag == true
            count = count + 1;
        end
    end
end
if count ~= 0
    zero_flag = true;
else
    zero_flag = false;
end
if flag==true && zero_flag == false
    area_1 = findArea(P1(1,:),P1(2,:),P1(3,:));
    area_2 = findArea(P2(1,:),P2(2,:),P2(3,:));
    if area_1 < area_2
        one = findArea(P1(1,:),P2(2,:),P2(3,:));
        two = findArea(P1(1,:),P2(3,:),P2(1,:));
        three = findArea(P1(1,:),P2(1,:),P2(2,:));
        if (one+two+three > area_2)
            flag = false;
        end    
    else
        one = findArea(P2(1,:),P1(2,:),P1(3,:));
        two = findArea(P2(1,:),P1(3,:),P1(1,:));
        three = findArea(P2(1,:),P1(1,:),P1(2,:));
        if (one+two+three > area_1)
            flag = false;
        end
    end
end
% *******************************************************************
end
function [m,c] = findLine(x1,y1,x2,y2)
m = (y2-y1)/(x2-x1);
c = y2 - (m*x2);
end
function [flag,zero_flag] = checkSign(P1,P2,m,c,i)
flag = true;
zero_flag = false;
if i<3
    index  = 4 - mod(i,3) - mod(i+1,3);
    left = P1(index,2) - (m*P1(index,1)) - c;
    right_1 = P2(1,2) - (m*P2(1,1)) - c;
    right_2 = P2(2,2) - (m*P2(2,1)) - c;
    right_3 = P2(3,2) - (m*P2(3,1)) - c;
    if ((right_1>0 && right_2 > 0 && right_3 > 0 && left < 0) || (right_1<0 && right_2 < 0 && right_3 < 0 && left > 0))
        flag = false;
    end
    if right_1 == 0 || right_2 == 0 || right_3 == 0 || left == 0
        zero_flag = true;
    end
end
if i>2
    index  = 4 - mod(i-3,3) - mod(i-2,3);
    right = P2(index,2) - (m*P2(index,1)) - c;
    left_1 = P1(1,2) - (m*P1(1,1)) - c;
    left_2 = P1(2,2) - (m*P1(2,1)) - c;
    left_3 = P1(3,2) - (m*P1(3,1)) - c;
    if ((left_1>0 && left_2 > 0 && left_3 > 0 && right < 0) || (left_1<0 && left_2 < 0 && left_3 < 0 && right > 0))
        flag = false;
    end
    if left_1 == 0 || left_2 == 0 || left_3 == 0 || right == 0
        zero_flag = true;
    end
end
end
function area = findArea(one,two,three)
a = sqrt((two(1,2)-one(1,2))^2+(two(1,1)-one(1,1))^2);
b = sqrt((three(1,2)-two(1,2))^2+(three(1,1)-two(1,1))^2);
c = sqrt((one(1,2)-three(1,2))^2+(one(1,1)-three(1,1))^2);
p = (a+b+c)/2;
area = sqrt(p*(p-a)*(p-b)*(p-c));
end