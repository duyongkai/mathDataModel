num = 21;

% Aeq1 = [ones(92,num) zeros(92,92*num-num)];
% Aeq1 = [zeros(92,92) ones(92,num) zeros(92,92*num-num-92)];
% Aeq1 = [zeros(92,92*2) ones(92,num) zeros(92,92*num-num-92*2)];
Aeq = zeros(92,num*92);
% for k = 1:num
%     Aeq(:,1+92*(k-1):92+92*(k-1)) = [zeros(92,92*(k-1)) ones(92,num) zeros(92,92*num-num-92*(k-1))];
% end
for m = 1:92
    for n = 1:num
        Aeq(m,m+(n-1)*92) = 1;
    end
end
beq = ones(92,1);
lb = zeros(num*92,1);
ub = ones(num*92,1);
x0 = zeros(1,num*92);
[x,faval] = fmincon('function1_3',x0,[],[],Aeq,beq,lb,ub);


% rand('state',sum(clock));
% p0=0;
% tic
% for i=1:10^7
%     x=99*rand(5,1);
%     x1=floor(x);
%     x2=ceil(x);
%     [f,g]=fun1(x1);
%     if sum(g<=0)==4
%         if p0<=f
%             x0=x1;
%             p0=f;
%         end
%     end
% end
% x0, p0
% toc