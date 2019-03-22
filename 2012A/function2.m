clear;
clc;

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % ʹ��PCA�����ó������������۾���ָ��֮��������������
% ԭʼ���ݼ��ĵ���-[sourceData]
sourceData = xlsread('data2.xls', '���Ѿ�', 'D33:CF60');

% ԭʼ���ݼ�������-[r_sourceData c_sourceData]
[r_sourceData c_sourceData] = size(sourceData);

% PCA��������Ϣ������-[set_T]
set_T = 0.9;

% ԭʼ���ݼ������Ӧ�����ϵ������-[CS_sourceData]
CS_sourceData = corrcoef(sourceData);
clearvars k;

% �������ϵ������Ľ������е�����ֵ����������-[e V]
[V, D] = eig(CS_sourceData);
for k = 1:c_sourceData
    e(k) = D(c_sourceData+1-k, c_sourceData+1-k);
end

% ���㹱���ʺ͹������ۼ�-[De_rate SDe_rate]
Se_val = sum(e);
temp = 0;
for k = 1:c_sourceData
    De_rate(k) = e(k)/Se_val;
    temp = temp + De_rate(k);
    SDe_rate(k) = temp;
end

% �ڷ���PCA�����ʵ��������ȡ���ɷֶ�Ӧ����������-[PCA_V colNum_T]
for k = 1:c_sourceData
    if SDe_rate(k) >= set_T
        colNum_T = k;
        break;
    end
end
for k = 1:colNum_T
    PCA_V(:,k) = V(:,c_sourceData+1-k); % һ���ǵ�����ȡ��
end

% ��������۶�������ɷֵ÷�-[new_score]
S_sourceData = (sourceData-mean(sourceData))./std(sourceData);
new_score = S_sourceData * PCA_V;

% �ܷ�-[total_score]
for k = 1:r_sourceData
    total_score(k, 1) = sum(new_score(k,:).*e(1:colNum_T));
end

% ���PCAģ�ͼ��������
disp('# PCA���������ģ�ͼ��������');
disp('## ����ֵ���乱���ʡ��ۼƹ�����');
disp('### ����ֵe');
disp(e);
disp('### ������De');
disp(De_rate);
disp('### �ۼƹ�����SDe');
disp(SDe_rate);
disp('### �ۼƹ�����SDe');
disp('## ��Ϣ�����ʶ�Ӧ�����ɷ�������������');
disp('### ��Ϣ������T');
disp(set_T);
disp('### �������ɷ���Ϣ�����ʵ���������������colNum_T');
disp(colNum_T);
disp('## ���ɷֵ÷�[new_score total_score]');
disp([new_score total_score]);
disp('-------------------------------------------------------------------');
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
xlswrite('output3_new_score.xlsx',new_score,'white_drink','A1');
xlswrite('output2_red.xlsx',S_sourceData,'S_sourceData','A1');
