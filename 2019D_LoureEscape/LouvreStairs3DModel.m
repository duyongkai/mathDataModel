clear;
tic;

Louvre = zeros(322,778,5)-2;
for f = 2:5
    Louvre(1:10,41:555,f) = f-3;
    Louvre(7:92,327:336,f) = f-3;
    Louvre(83:92,333:778,f) = f-3;
    Louvre(7:86,546:555,f) = f-3;
    Louvre(93:258,601:610,f) = f-3;
    Louvre(265:322,563:572,f) = f-3;
    Louvre(313:322,1:566,f) = f-3;
    Louvre(259:268,338:778,f) = f-3;
    Louvre(93:258,769:778,f) = f-3;
    Louvre(265:316,510:519,f) = f-3;
    Louvre(265:316,424:433,f) = f-3;
    Louvre(265:316,338:347,f) = f-3;
    Louvre(11:82,510:519,f) = f-3;
    Louvre(11:82,424:433,f) = f-3;
end

% stair
% ----
% r0, c0, f0
% r1, c1, f1
% ----
stair = zeros(2,3,10);
% [-2 -1]
stair(:,:,1) = [159 463 -2; 93 463 -1];
stair(:,:,2) = [187 463 -2; 258 463 -1];
stair(:,:,3) = [172 478 -2; 172 600 -1];
% [-1 0]
stair(:,:,4) = [262 527 -1; 262 539 0];
stair(:,:,5) = [88 446 -1; 88 456 0];
% [0 1]
stair(:,:,6) = [83 438 0; 83 449 1];
stair(:,:,7) = [88 771 0; 88 777 1];
stair(:,:,8) = [170 605 0; 190 605 1];
stair(:,:,9) = [265 512 0; 265 522 1];
stair(:,:,10) = [261 340 0; 261 345 1];
stair(:,:,11) = [318 136 0; 318 139 1];
% [1 2]
stair(:,:,12) = [83 438 1; 83 449 2];
stair(:,:,13) = [170 604 1; 190 604 2];
% [0 -2]
stair(:,:,14) = [170 461 0; 170 467 -2];

figure('Name', 'Â¬¸¡¹¬-3DÍ¼')
f = 1;
for k = 1:10:322
    plot3([0 778], [k k], [f-3 f-3], 'b')
    hold on
end
for k = 1:10:778
    plot3([k k], [0 322], [f-3 f-3], 'b')
end
f = 2;
for k = 1:10:322
    plot3([0 778], [k k], [f-3 f-3], 'g')
end
for k = 1:10:778
    plot3([k k], [0 322], [f-3 f-3], 'g')
end
f = 3;
for k = 1:10:322
    plot3([0 778], [k k], [f-3 f-3], 'c')
end
for k = 1:10:778
    plot3([k k], [0 322], [f-3 f-3], 'c')
end
f = 4;
for k = 1:10:322
    plot3([0 778], [k k], [f-3 f-3], 'm')
end
for k = 1:10:778
    plot3([k k], [0 322], [f-3 f-3], 'm')
end
f = 5;
for k = 1:10:322
    plot3([0 778], [k k], [f-3 f-3], 'y')
end
for k = 1:10:778
    plot3([k k], [0 322], [f-3 f-3], 'y')
end

for k = 1:size(stair,3)-1
    plot3(stair(:,2,k),stair(:,1,k),stair(:,3,k),'-sb')
    if stair(1,2,k)==stair(2,2,k)
        for n = 1:2
            plot3(stair(:,2,k)+n,stair(:,1,k),stair(:,3,k),'-sb')
        end
    end
    if stair(1,1,k)==stair(2,1,k)
        for n = 1:2
            plot3(stair(:,2,k),stair(:,1,k)+n,stair(:,3,k),'-sb')
        end
    end
end
plot3(stair(:,2,k+1),stair(:,1,k+1),stair(:,3,k+1),'-sr')
for n = 1:9
    plot3(stair(:,2,k+1),stair(:,1,k+1)+n,stair(:,3,k+1),'-sr')
end
hold off
toc;
