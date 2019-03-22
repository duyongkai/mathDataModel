clear
clc

%设置全局变量[year_num3 x_num]
year_num3 = 10;
grade_num = 1;
N = 4
foreYear_num = 10;

%导入数据[outWater_abs]
outWater_abs = transpose([174 179 183 189 207 234 220.5 256 270 285]);

%趋势性移动平均法
outWater_abs1 = zeros(year_num3-N+1, grade_num);
outWater_abs2 = zeros(year_num3-2*N+1, grade_num);
for k = 1:size(outWater_abs1,1)
    outWater_abs1(k,:) = mean(outWater_abs(k:k+N-1,:));
end
for k = 1:size(outWater_abs2,1)
    outWater_abs2(k,:) = mean(outWater_abs1(k:k+N-1,:));
end
a = 2.*outWater_abs1(size(outWater_abs1,1),:)-outWater_abs2(size(outWater_abs2,1),:)
b = 2/(N-1).*(outWater_abs1(size(outWater_abs1,1),:)-outWater_abs2(size(outWater_abs2,1),:))
fore_result = zeros(foreYear_num, grade_num);
for k = 1:foreYear_num
    fore_result(k,:) = a + b.*k;
end
fore_result