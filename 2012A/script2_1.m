clear;
clc;

rank1 = 1718;
rank2 = 1405;

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
red1 = xlsread('data1.xlsx', 'red1', 'B3:K29');
white2 = xlsread('data1.xlsx', 'white2', 'B3:K30');

%ԭʼ���ݼ�������-[[r_red1 c_red1] [r_sourceData2 c_sourceData2]]
[r_red1 c_red1] = size(red1);

%PCA��������Ϣ������-[set_T]
set_T = 0.95;

%ԭʼ���ݼ������Ӧ�����ϵ������-[CS_red1]
CS_red1 = corrcoef(red1);
clearvars k;

%�������ϵ������Ľ������е�����ֵ����������-[e V]
[V, D] = eig(CS_red1);
for k = 1:c_red1
    e(k) = D(c_red1+1-k, c_red1+1-k);
end

%���㹱���ʺ͹������ۼ�-[De_rate SDe_rate]
Se_val = sum(e);
temp = 0;
for k = 1:c_red1
    De_rate(k) = e(k)/Se_val;
    temp = temp + De_rate(k);
    SDe_rate(k) = temp
end
clearvars k temp Se_val;

%�ڷ���PCA�����ʵ��������ȡ���ɷֶ�Ӧ����������-[PCA_V colNum_T]
for k = 1:c_red1
    if SDe_rate(k) >= set_T
        colNum_T = k;
        break;
    end
end
for k = 1:colNum_T
    PCA_V(:,k) = V(:,c_red1+1-k); %һ���ǵ�����ȡ��
end
clearvars k;

%��������۶�������ɷֵ÷�-[new_score]
new_score = red1 * PCA_V;

%�����ܷ�-[total_score]
for k = 1:r_red1
    total_score(k, 1) = sum(new_score(k,:).*e(1:colNum_T));
end

red_factors = [red_factor1 red_factor2 red_factor3 red_factor4 red_factor5 red_factor6 red_factor7 red_factor8 red_factor9];
white_factors = [white_factor1 white_factor2 white_factor3 white_factor4 white_factor5 white_factor6 white_factor7 white_factor8];
red_rank = zeros(size(red1_score));
white_rank = zeros(size(white2_score));
for k = 1:numel(red1_score)
    if total_score(k)>rank1
        red_rank(k) = 1;
    end
    if total_score(k)<=rank1 & total_score(k)>rank2
        red_rank(k) = 2;
    end
    if total_score(k)<=rank2
        red_rank(k) = 3;
    end
end
% for k = 1:numel(white2_score)
%     if white2_score(k)>rank1
%         white_rank(k) = 1;
%     end
%     if white2_score(k)<=rank1 & white2_score(k)>rank2
%         white_rank(k) = 2;
%     end
%     if white2_score(k)<=rank2
%         white_rank(k) = 3;
%     end
% end

corr_red = corrcoef([red_rank new_score])
% corr_white = corrcoef([white_rank white_factors])



xlswrite('output2.xlsx', [red_rank red_factors], 'red', 'A1');
% xlswrite('output2.xlsx', [white_rank white_factors], 'white', 'A1');
