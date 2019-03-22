clear;
tic;

Louvre = zeros(322*2,778*2,5)-2;
for f = 2:5
    Louvre(1:10*2,41*2:555*2,f) = f-3;
    Louvre(7*2:92*2,327*2:336*2,f) = f-3;
    Louvre(83*2:92*2,333*2:778*2,f) = f-3;
    Louvre(7*2:86*2,546*2:555*2,f) = f-3;
    Louvre(93*2:258*2,601*2:610*2,f) = f-3;
    Louvre(265*2:322*2,563*2:572*2,f) = f-3;
    Louvre(313*2:322*2,1:566*2,f) = f-3;
    Louvre(259*2:268*2,338*2:778*2,f) = f-3;
    Louvre(93*2:258*2,769*2:778*2,f) = f-3;
    Louvre(265*2:316*2,510*2:519*2,f) = f-3;
    Louvre(265*2:316*2,424*2:433*2,f) = f-3;
    Louvre(265*2:316*2,338*2:347*2,f) = f-3;
    Louvre(11*2:82*2,510*2:519*2,f) = f-3;
    Louvre(11*2:82*2,424*2:433*2,f) = f-3;
end

% stair
% ----
% r0, c0, f0
% r1, c1, f1
% ----
% [-2 -1]
stair(:,:,1) = [159*2 463*2 -2; 93*2 463*2 -1];
stair(:,:,2) = [187*2 463*2 -2; 258*2 463*2 -1];
stair(:,:,3) = [172*2 478*2 -2; 172*2 600*2 -1];
% [-1 0]
stair(:,:,4) = [262*2 527*2 -1; 262*2 539*2 0];
stair(:,:,5) = [88*2 446*2 -1; 88*2 456*2 0];
% [0 1]
stair(:,:,6) = [83*2 438*2 0; 83*2 449*2 1];
stair(:,:,7) = [88*2 771*2 0; 88*2 777*2 1];
stair(:,:,8) = [170*2 605*2 0; 190*2 605*2 1];
stair(:,:,9) = [265*2 512*2 0; 265*2 522*2 1];
stair(:,:,10) = [261*2 340*2 0; 261*2 345*2 1];
stair(:,:,11) = [318*2 136*2 0; 318*2 139*2 1];
% [1 2]
stair(:,:,12) = [83*2 438*2 1; 83*2 449*2 2];
stair(:,:,13) = [170*2 604*2 1; 190*2 604*2 2];
% [0 -2]
stair(:,:,14) = [170*2 461*2 0; 170*2 467*2 -2];

figure('Name', 'Â¬¸¡¹¬-3DÍ¼')
for k = 1:5
    mesh(Louvre(:,:,k),'LineStyle',':')
    hold on
end
f = 1;
for k = 1:10000
    yi = randi(322*2);
    xi = randi(778*2);
    if Louvre(yi,xi,f+1) == f-2
        plot3(xi,yi,f-3,'.r')
        hold on
    end
end
for f = 2:5
    for k = 1:10000
        yi = randi(322*2);
        xi = randi(778*2);
        if Louvre(yi,xi,f) == f-3
            plot3(xi,yi,f-3,'.r')
            hold on
        end
    end
end
for k = 1:size(stair,3)-1
    plot3(stair(:,2,k),stair(:,1,k),stair(:,3,k),'-sb')
    if stair(1,2,k)==stair(2,2,k)
        for n = 1:5
            plot3(stair(:,2,k)+n,stair(:,1,k),stair(:,3,k),'-sb')
        end
    end
    if stair(1,1,k)==stair(2,1,k)
        for n = 1:5
            plot3(stair(:,2,k),stair(:,1,k)+n,stair(:,3,k),'-sb')
        end
    end
end
plot3(stair(:,2,k+1),stair(:,1,k+1),stair(:,3,k+1),'-sr')
for n = 1:19
    plot3(stair(:,2,k+1),stair(:,1,k+1)+n,stair(:,3,k+1),'-sr')
end
hold off
toc;
