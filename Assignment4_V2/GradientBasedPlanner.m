function route = GradientBasedPlanner (f, start_coords, end_coords, max_its)
% GradientBasedPlanner : This function plans a path through a 2D
% environment from a start to a destination based on the gradient of the
% function f which is passed in as a 2D array. The two arguments
% start_coords and end_coords denote the coordinates of the start and end
% positions respectively in the array while max_its indicates an upper
% bound on the number of iterations that the system can use before giving
% up.
% The output, route, is an array with 2 columns and n rows where the rows
% correspond to the coordinates of the robot as it moves along the route.
% The first column corresponds to the x coordinate and the second to the y coordinate

[gx, gy] = gradient (-f);

%%% All of your code should be between the two lines of stars.
% *******************************************************************
grad_x = gx(start_coords(1,2),start_coords(1,1));
grad_y = gy(start_coords(1,2),start_coords(1,1));
route(1,1) = start_coords(1,1);
route(1,2) = start_coords(1,2);
for i=2:max_its
    normal = sqrt(grad_x^2+grad_y^2);
    grad_x = grad_x/normal;
    grad_y = grad_y/normal;
    route(i,1) = (route(i-1,1)+grad_x);
    route(i,2) = (route(i-1,2)+grad_y);
    if sqrt((route(i,1)-end_coords(1,1))^2+(route(i,2)-end_coords(1,2))^2) < 2.0
        break;
    end
    grad_x = gx(round(route(i,2)),round(route(i,1)));
    grad_y = gy(round(route(i,2)),round(route(i,1)));
end
route = double(route);
% *******************************************************************
end
