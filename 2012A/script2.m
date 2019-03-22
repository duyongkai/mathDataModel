clear
clc

rank1 = 0.9*110;
rank2 = 0.6*110;

red1_score = xlsread('data1.xlsx', 'red2', 'K3:K29');
white2_score = xlsread('data1.xlsx', 'white2', 'K3:K30');
red_factor1 = xlsread('����2-ָ���ܱ�.xls', '���Ѿ�', 'F3:F29');
red_factor2 = xlsread('����2-ָ���ܱ�.xls', '���Ѿ�', 'K3:K29');
red_factor3 = xlsread('����2-ָ���ܱ�.xls', '���Ѿ�', 'O3:O29');
red_factor4 = xlsread('����2-ָ���ܱ�.xls', '���Ѿ�', 'S3:S29');
red_factor5 = xlsread('����2-ָ���ܱ�.xls', '���Ѿ�', 'T3:T29');
red_factor6 = xlsread('����2-ָ���ܱ�.xls', '���Ѿ�', 'AC3:AC29');
red_factor7 = xlsread('����2-ָ���ܱ�.xls', '���Ѿ�', 'AD3:AD29');
red_factor8 = xlsread('����2-ָ���ܱ�.xls', '���Ѿ�', 'AE3:AE29');
red_factor9 = xlsread('����2-ָ���ܱ�.xls', '���Ѿ�', 'AF3:AF29');
white_factor1 = xlsread('����2-ָ���ܱ�.xls', '���Ѿ�', 'K33:K60');
white_factor2 = xlsread('����2-ָ���ܱ�.xls', '���Ѿ�', 'O33:O60');
white_factor3 = xlsread('����2-ָ���ܱ�.xls', '���Ѿ�', 'S33:S60');
white_factor4 = xlsread('����2-ָ���ܱ�.xls', '���Ѿ�', 'T33:T60');
white_factor5 = xlsread('����2-ָ���ܱ�.xls', '���Ѿ�', 'AC33:AC60');
white_factor6 = xlsread('����2-ָ���ܱ�.xls', '���Ѿ�', 'AD33:AD60');
white_factor7 = xlsread('����2-ָ���ܱ�.xls', '���Ѿ�', 'AE33:AE60');
white_factor8 = xlsread('����2-ָ���ܱ�.xls', '���Ѿ�', 'AF33:AF60');

red_factors = [red_factor1 red_factor2 red_factor3 red_factor4 red_factor5 red_factor6 red_factor7 red_factor8 red_factor9];
white_factors = [white_factor1 white_factor2 white_factor3 white_factor4 white_factor5 white_factor6 white_factor7 white_factor8];
red_rank = zeros(size(red1_score));
white_rank = zeros(size(white2_score));

while 1
    
end

corr_red = corrcoef([red_rank red_factors])
corr_white = corrcoef([white_rank white_factors])

xlswrite('output2.xlsx', [red_rank red_factors], 'red', 'A1');
xlswrite('output2.xlsx', [white_rank white_factors], 'white', 'A1');
