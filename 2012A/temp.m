%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% script2.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
clc

rank1 = 93;
rank2 = 88;

red1_score = xlsread('data1.xlsx', 'red2', 'K3:K29');
white2_score = xlsread('data1.xlsx', 'white2', 'K3:K30');
red_factor1 = xlsread('附件2-指标总表.xls', '葡萄酒', 'F3:F29');
red_factor2 = xlsread('附件2-指标总表.xls', '葡萄酒', 'K3:K29');
red_factor3 = xlsread('附件2-指标总表.xls', '葡萄酒', 'O3:O29');
red_factor4 = xlsread('附件2-指标总表.xls', '葡萄酒', 'S3:S29');
red_factor5 = xlsread('附件2-指标总表.xls', '葡萄酒', 'T3:T29');
red_factor6 = xlsread('附件2-指标总表.xls', '葡萄酒', 'AC3:AC29');
red_factor7 = xlsread('附件2-指标总表.xls', '葡萄酒', 'AD3:AD29');
red_factor8 = xlsread('附件2-指标总表.xls', '葡萄酒', 'AE3:AE29');
red_factor9 = xlsread('附件2-指标总表.xls', '葡萄酒', 'AF3:AF29');
white_factor1 = xlsread('附件2-指标总表.xls', '葡萄酒', 'K33:K60');
white_factor2 = xlsread('附件2-指标总表.xls', '葡萄酒', 'O33:O60');
white_factor3 = xlsread('附件2-指标总表.xls', '葡萄酒', 'S33:S60');
white_factor4 = xlsread('附件2-指标总表.xls', '葡萄酒', 'T33:T60');
white_factor5 = xlsread('附件2-指标总表.xls', '葡萄酒', 'AC33:AC60');
white_factor6 = xlsread('附件2-指标总表.xls', '葡萄酒', 'AD33:AD60');
white_factor7 = xlsread('附件2-指标总表.xls', '葡萄酒', 'AE33:AE60');
white_factor8 = xlsread('附件2-指标总表.xls', '葡萄酒', 'AF33:AF60');

red_factors = [red_factor1 red_factor2 red_factor3 red_factor4 red_factor5 red_factor6 red_factor7 red_factor8 red_factor9];
white_factors = [white_factor1 white_factor2 white_factor3 white_factor4 white_factor5 white_factor6 white_factor7 white_factor8];
red_rank = zeros(size(red1_score));
white_rank = zeros(size(white2_score));
for k = 1:numel(red1_score)
    if red1_score(k)>rank1
        red_rank(k) = 1;
    end
    if red1_score(k)<=rank1 & red1_score(k)>rank2
        red_rank(k) = 2;
    end
    if red1_score(k)<=rank2
        red_rank(k) = 3;
    end
end
for k = 1:numel(white2_score)
    if white2_score(k)>rank1
        white_rank(k) = 1;
    end
    if white2_score(k)<=rank1 & white2_score(k)>rank2
        white_rank(k) = 2;
    end
    if white2_score(k)<=rank2
        white_rank(k) = 3;
    end
end

corr_red = corrcoef([red_rank red_factors])
corr_white = corrcoef([white_rank white_factors])

xlswrite('output2.xlsx', [red_rank red_factors], 'red', 'A1');
xlswrite('output2.xlsx', [white_rank white_factors], 'white', 'A1');
