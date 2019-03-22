clear;
tic;

points_x = zeros(101,3);
points_x(:,1) = 0:0.1:10;
points_x(:,2) = 0;
points_x(:,3) = 0;
points_y = zeros(101,3);
points_y(:,2) = 0:0.1:10;
points_y(:,1) = 0;
points_y(:,3) = 0;
points_z = zeros(101,3);
points_z(:,3) = 0:0.1:10;
points_z(:,2) = 0;
points_z(:,1) = 0;
o0 = [2 -3 1];
D = 0.1;
angle1 = pi/4; % ¦Õ
angle2 = pi/4; % ¦È
% T1 = [1 0 0 0; 0 1 0 0; 0 0 1 0; -o0(1) -o0(2) -o0(3) 1];
% T2 = [sin(angle2) cos(angle2) 0 0; -cos(angle2) sin(angle2) 0 0; 0 0 1 0; 0 0 0 1];
% T3 = [1 0 0 0; 0 -sin(angle1) -cos(angle1) 0; 0 cos(angle1) -sin(angle1) 0; 0 0 0 1];
% T4 = [-1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
% % T = T1*T2*T3*T4;
% T = T4*T3*T2*T1;
T = [-sin(angle2) -cos(angle2)*sin(angle1) -cos(angle2)*cos(angle1) 0; cos(angle2) -sin(angle2)*sin(angle1) -sin(angle2)*cos(angle1) 0; 0 cos(angle1) -sin(angle1) 0; 0 0 sqrt(sum(o0.^2)) 1];
for k = 1:numel(points_x(:,1))
    xyzc = [points_x(k,1) points_x(k,2) points_x(k,3) 1]*T;
    x0(k) = xyzc(1);
    y0(k) = xyzc(2);
    z0(k) = xyzc(3);
    c0(k) = xyzc(4);
end
xe = (x0./z0).*D;
ye = (y0./z0).*D;
plot(xe, ye, 'r')
hold on
for k = 1:numel(points_x(:,1))
    xyzc = [points_y(k,1) points_y(k,2) points_y(k,3) 1]*T;
    x0(k) = xyzc(1);
    y0(k) = xyzc(2);
    z0(k) = xyzc(3);
    c0(k) = xyzc(4);
end
xe = (x0./z0).*D;
ye = (y0./z0).*D;
plot(xe, ye, 'g')
for k = 1:numel(points_x(:,1))
    xyzc = [points_z(k,1) points_z(k,2) points_z(k,3) 1]*T;
    x0(k) = xyzc(1);
    y0(k) = xyzc(2);
    z0(k) = xyzc(3);
    c0(k) = xyzc(4);
end
xe = (x0./z0).*D;
ye = (y0./z0).*D;
plot(xe, ye, 'b')
hold off

toc;
