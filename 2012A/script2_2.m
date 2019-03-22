red1_score = xlsread('data1.xlsx', 'red2', 'K3:K29');
red_factor1 = xlsread('附件2-指标总表.xls', '葡萄酒', 'F3:F29');
red_factor2 = xlsread('附件2-指标总表.xls', '葡萄酒', 'K3:K29');
red_factor3 = xlsread('附件2-指标总表.xls', '葡萄酒', 'O3:O29');
red_factor4 = xlsread('附件2-指标总表.xls', '葡萄酒', 'S3:S29');
red_factor5 = xlsread('附件2-指标总表.xls', '葡萄酒', 'T3:T29');
red_factor6 = xlsread('附件2-指标总表.xls', '葡萄酒', 'AC3:AC29');
red_factor7 = xlsread('附件2-指标总表.xls', '葡萄酒', 'AD3:AD29');
red_factor8 = xlsread('附件2-指标总表.xls', '葡萄酒', 'AE3:AE29');
red_factor9 = xlsread('附件2-指标总表.xls', '葡萄酒', 'AF3:AF29');
red_factors = [red_factor1 red_factor2 red_factor3 red_factor4 red_factor5 red_factor6 red_factor7 red_factor8 red_factor9];

std_factors = std(red_factors);
std_score = std(red1_score);
mean_factors = mean(red_factors);
mean_score = mean(red1_score);
for k = 1:9
    subplot(3,3,k)
    [(red_factors(:,k)-mean_factors)./std_factors (red1_score-mean_score)./std_score]
    plot((red_factors(:,k)-mean_factors)./std_factors,(red1_score-mean_score)./std_score,'*')
end
