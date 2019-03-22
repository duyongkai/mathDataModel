m11 = -5;
m12 = 50;
m22 = 100;
p = m11*r.^2 + 2*m12*r + m22;
v = 1.65*p -r;
plot(r, v);
hold on
m11 = 1;
m12 = 50;
m22 = -100;
p = m11*r.^2 + 2*m12*r + m22;
v = 1.65*p -r;
plot(r, v);
title('VaR约束条件下的组合有效边界');
xlabel('组合风险');
ylabel('组合收益率');
ylim([0 900]);
hold off
