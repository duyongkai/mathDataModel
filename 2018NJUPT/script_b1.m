clear;
clc;

%%ʹ��PCA�����ó������������۾���ָ��֮��������������
%ԭʼ���ݼ��ĵ���-[[sourceData1 sourceText1] [sourceData2 sourceText2] [sourceData3 sourceText3] [sourceData4 sourceText4]]
[sourceData1, sourceText1] = xlsread('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\У����Ŀ\B�⸽��.xlsx', '����1-��۾���ָ��', 'A3:U34');
[sourceData2, sourceText2] = xlsread('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\У����Ŀ\B�⸽��.xlsx', '����2-����������ʷ����', 'A3:H32');

%ԭʼ���ݼ�������-[[r_sourceData1 c_sourceData1] [r_sourceData2 c_sourceData2]]
[r_sourceData1 c_sourceData1] = size(sourceData1);
[r_sourceData2 c_sourceData2] = size(sourceData2);

%PCA��������Ϣ������-[set_T]
set_T = 0.95;

%ԭʼ���ݼ������Ӧ�����ϵ������-[CS_sourceData1]
CS_sourceData1 = corrcoef(sourceData1);
clearvars k;

%�������ϵ������Ľ������е�����ֵ����������-[e V]
[V, D] = eig(CS_sourceData1);
for k = 1:c_sourceData1
    e(k) = D(c_sourceData1+1-k, c_sourceData1+1-k);
end
clearvars D k;

%���㹱���ʺ͹������ۼ�-[De_rate SDe_rate]
Se_val = sum(e);
temp = 0;
for k = 1:c_sourceData1
    De_rate(k) = e(k)/Se_val;
    temp = temp + De_rate(k);
    SDe_rate(k) = temp;
end
clearvars k temp Se_val;

%�ڷ���PCA�����ʵ��������ȡ���ɷֶ�Ӧ����������-[PCA_V colNum_T]
for k = 1:c_sourceData1
    if SDe_rate(k) >= set_T
        colNum_T = k;
        break;
    end
end
for k = 1:colNum_T
    PCA_V(:,k) = V(:,c_sourceData1+1-k); %һ���ǵ�����ȡ��
end
clearvars k;

%��������۶�������ɷֵ÷�-[new_score]
new_score = sourceData1 * PCA_V;

%�����ܷ�-[total_score]
for k = 1:r_sourceData1
    total_score(k, 1) = sum(new_score(k,:).*e(1:colNum_T));
end
clearvars k;

%����ܷ�-[total_score_year]
m = 0;
for k = 1:4:(r_sourceData1-3)
    m = m+1;
    total_score_year(m) = mean(total_score(k:k+3));
end
clearvars m k;

%�����ʷ���ݶ�Ӧ������ֳܷ�������ݵó�����-[p Pi_in Pi_out p_in p_out]
n = (size(total_score_year,2)-2):size(total_score_year,2);
m = 0;
for k = 3:2:7
    m = m+1;
    p_in(m) = sum(sourceData2(:,k))/total_score_year(n(m));
end
m = 0;
for k = 4:2:8
    m = m+1;
    p_out(m) = sum(sourceData2(:,k))/total_score_year(n(m));
end
pi_in = mean(p_in);
pi_out = mean(p_out);
clearvars m k n;

%�ó��������ɷֶ�Ӧ�ı���-[pi_PCA po_PCA]
pi_PCA = pi_in * e(1:colNum_T);
po_PCA = pi_out * e(1:colNum_T);

%���PCAģ�ͼ��������
disp('# PCA���������ģ�ͼ��������');
disp('## ����ֵ���乱���ʡ��ۼƹ�����');
disp('### ����ֵe');
disp(e);
% xlswrite('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\code\report.xlsx', e, 1, 'B1');
disp('### ������De');
disp(De_rate);
% xlswrite('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\code\report.xlsx', De_rate, 1, 'B2');
disp('### �ۼƹ�����SDe');
disp(SDe_rate);
% xlswrite('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\code\report.xlsx', SDe_rate, 1, 'B3');
disp('### �ۼƹ�����SDe');
disp('## ��Ϣ�����ʶ�Ӧ�����ɷ�������������');
disp('### ��Ϣ������T');
disp(set_T);
% xlswrite('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\code\report.xlsx', set_T, 1, 'B4');
disp('### �������ɷ���Ϣ�����ʵ���������������colNum_T');
disp(colNum_T);
% xlswrite('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\code\report.xlsx', colNum_T, 1, 'B5');
disp('### ���ɷ��µ���������PV');
disp(PCA_V);
% xlswrite('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\code\report.xlsx', PCA_V, 1, 'B6');
disp('## ���ɷֵ÷�[new_score total_score]');
disp([new_score total_score]);
% xlswrite('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\code\report.xlsx', [new_score total_score], 1, 'B27');
disp('## ����PCA��������������ܷ�����ʵ��������������������ϵ��');
disp('### ���p_in');
disp(p_in);
% xlswrite('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\code\report.xlsx', p_in, 1, 'B60');
disp('### ����p_out');
disp(p_out);
% xlswrite('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\code\report.xlsx', p_out, 1, 'B61');
disp('## ����PCA��������������ܷ�����ʵ�����������ƽ���ı���ϵ��');
disp('### ���pi_in');
disp(pi_in);
% xlswrite('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\code\report.xlsx', pi_in, 1, 'B62');
disp('### ����pi_out');
disp(pi_out);
% xlswrite('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\code\report.xlsx', pi_out, 1, 'B63');
disp('## ����PCA������������ķ����÷ֵ����յı���ϵ��');
disp('### ���pi_PCA');
disp(pi_PCA);
% xlswrite('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\code\report.xlsx', pi_PCA, 1, 'B64');
disp('### ����po_PCA');
disp(po_PCA);
% xlswrite('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\code\report.xlsx', po_PCA, 1, 'B65');
disp('-------------------------------------------------------------------');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%ԭʼ���ݼ��ĵ���-[[sourceData1 sourceText1] [sourceData2 sourceText2] [sourceData3 sourceText3] [sourceData4 sourceText4]]
[sourceData1, sourceText1] = xlsread('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\У����Ŀ\B�⸽��.xlsx', '����1-��۾���ָ��', 'A3:U35');
clearvars sourceText1;

%ԭʼ���ݼ�������-[r_sourceData1 c_sourceData1]
[r_sourceData1 c_sourceData1] = size(sourceData1);

%�������ϵ������Ľ������е�����ֵ����������-[V]
[V, D] = eig(CS_sourceData1);
clearvars D;

%��ȡ���ɷֶ�Ӧ����������-[PCA_V]
for k = 1:colNum_T
    PCA_V(:,k) = V(:,c_sourceData1+1-k); %һ���ǵ�����ȡ��
end
clearvars k;

%��������۶�������ɷֵ÷�-[new_score]
new_score = sourceData1 * PCA_V;

%���ȴ��ʹ����ܷ�-[total_score_in total_score_out]
for k = 1:r_sourceData1
    total_score_in(k, 1) = sum(new_score(k,:).*pi_PCA);
end
for k = 1:r_sourceData1
    total_score_out(k, 1) = sum(new_score(k,:).*po_PCA);
end
clearvars k;

%��ȴ��ʹ����ܷ�-[total_score_yearIn total_score_yearOut]
m = 0;
for k = 1:4:(r_sourceData1-3)
    m = m+1;
    total_score_yearIn(m) = mean(total_score_in(k:k+3));
end
m = 0;
for k = 1:4:(r_sourceData1-3)
    m = m+1;
    total_score_yearOut(m) = mean(total_score_out(k:k+3));
end
clearvars m k;

%��������Ԥ��Ľ������
disp('# �����Լ�Ԥ��ֵ�����ɷֵ÷��ܷ�');
disp('## ���ȶȴ�����    ���ȴ������');
disp('total_score_in    total_score_out');
disp([total_score_in(1:numel(total_score_in)-1, 1) total_score_out(1:numel(total_score_out)-1, 1)]);
disp('## ��ȴ�����   ��ȴ������');
disp('total_score_yearIn    total_score_yearOut');  
disp([transpose(total_score_yearIn) transpose(total_score_yearOut)]);
% xlswrite('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\code\report.xlsx', [transpose(total_score_yearIn) transpose(total_score_yearOut)], 1, 'B66');
disp('2018 ��ȴ��Ԥ��    ��ȴ���Ԥ��');
disp([total_score_in(numel(total_score_in)) total_score_out(numel(total_score_out))]);
disp('-------------------------------------------------------------------');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%������%%%%%%%%%%%%%%%%%%%%%%

residual = xlsread('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\У����Ŀ\B�⸽��.xlsx', '����2-����������ʷ����', 'C35:H35');
residual_in = residual(1:2:6);
residual_out = residual(2:2:6);
time_serious = [2015 2016 2017];

subplot(1, 2, 1);
bar(time_serious, residual_in);
xlabel('���');
ylabel('���');
title('���Ĳв����ͼ');
subplot(1, 2, 2);
bar(time_serious, residual_out);
xlabel('���');
ylabel('���');
title('����Ĳв����ͼ');
disp('# ������');
disp('- 2015-2017����Ĳв�');
disp(residual_in);
disp('- 2015-2017�����Ĳв�');
disp(residual_out);
disp('- 2015-2017����Ĳв��ֵ');
disp(mean(residual_in));
disp('- 2015-2017����Ĳв�ı�׼��');
disp(std(residual_in));
disp('- 2015-2017�����Ĳв��ֵ');
disp(mean(residual_out));
disp('- 2015-2017����Ĳв�ı�׼��');
disp(std(residual_in));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
