clear;
clc;

%ԭʼ���ݼ��ĵ���-[[sourceData1 sourceText1] [sourceData2 sourceText2] [sourceData3 sourceText3] [sourceData4 sourceText4]]
[sourceData1, sourceText1] = xlsread('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\У����Ŀ\B�⸽��.xlsx', '����1-��۾���ָ��', 'A3:U35');
[sourceData2, sourceText2] = xlsread('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\У����Ŀ\B�⸽��.xlsx', '����2-����������ʷ����', 'A3:H32');
[sourceData3, sourceText3] = xlsread('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\У����Ŀ\B�⸽��.xlsx', '����3-���������ˮƽ', 'A15:H44');
[sourceData4, sourceText4] = xlsread('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\У����Ŀ\B�⸽��.xlsx', '����4-��ȡ��ÿ������', 'A4:CM368');

%���ݼ�1(��۾���ָ��)�Ŀ��ӻ�
s1 = size(sourceText1);
s2 = size(sourceData1);
sourceText1_v1 = 1:s1(1);
for k = 1:s2(2)
    subplot(4, ceil(s2(2)/4), k);
    plot(sourceText1_v1, sourceData1(:,k), '*r');
end
clearvars s1 s2 sourceText1_v1 k;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear;
clc;

%%ʹ��PCA�����ó������������۾���ָ��֮��������������
%ԭʼ���ݼ��ĵ���-[[sourceData1 sourceText1] [sourceData2 sourceText2] [sourceData3 sourceText3] [sourceData4 sourceText4]]
[sourceData1, sourceText1] = xlsread('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\У����Ŀ\B�⸽��.xlsx', '����1-��۾���ָ��', 'A3:U35');
[sourceData2, sourceText2] = xlsread('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\У����Ŀ\B�⸽��.xlsx', '����2-����������ʷ����', 'A3:H32');
[sourceData3, sourceText3] = xlsread('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\У����Ŀ\B�⸽��.xlsx', '����3-���������ˮƽ', 'A15:H44');
[sourceData4, sourceText4] = xlsread('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\У����Ŀ\B�⸽��.xlsx', '����4-��ȡ��ÿ������', 'A4:CM368');

%ԭʼ���ݼ�������-[r_sourceData1 c_sourceData1]
[r_sourceData1 c_sourceData1] = size(sourceData1);

%����ԭʼ���ݹ�����ı��ڴ��������

%PCA��������Ϣ������-[set_T]
set_T = 0.9;

%��׼��ԭʼ���ݼ��������Ӧ�����ϵ������-[S_sourceData1 CS_sourceData1]
for k = 1:c_sourceData1
    S_sourceData1(:,k) = (sourceData1(:,k) - mean(sourceData1(:,k)))/std(sourceData1(:,k));
end
CS_sourceData1 = corrcoef(S_sourceData1);
clearvars k;

%�������ϵ������Ľ������е�����ֵ����������-[e V]
[V, D] = eig(CS_sourceData1)
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
new_score = S_sourceData1 * PCA_V;

%

%���PCAģ�ͼ��������
disp('# PCA���������ģ�ͼ��������');
disp('-------------------------------------------------------------------');
disp('## ����ֵ���乱���ʡ��ۼƹ�����');
disp('### ����ֵe');
disp(e);
disp('### ������De');
disp(De_rate);
disp('### �ۼƹ�����SDe');
disp(SDe_rate);
disp('-------------------------------------------------------------------');
disp('## ��Ϣ�����ʶ�Ӧ�����ɷ�������������');
disp('### ��Ϣ������T');
disp(set_T);
disp('### �������ɷ���Ϣ�����ʵ���������������colNum_T');
disp(colNum_T);
disp('### ���ɷ��µ���������PV');
disp(PCA_V);
disp('-------------------------------------------------------------------');
disp('## ���ɷֵ÷�');
disp(new_score);







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc;

%%ʹ��PCA�����ó������������۾���ָ��֮��������������
%ԭʼ���ݼ��ĵ���-[[sourceData1 sourceText1] [sourceData2 sourceText2] [sourceData3 sourceText3] [sourceData4 sourceText4]]
[sourceData1, sourceText1] = xlsread('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\У����Ŀ\B�⸽��.xlsx', '����1-��۾���ָ��', 'A3:U35');
[sourceData2, sourceText2] = xlsread('E:\Users\dyk\Documents\Projects\��ѧ��ģ\��ģУ��\У����Ŀ\B�⸽��.xlsx', '����2-����������ʷ����', 'A3:H32');

%ԭʼ���ݼ�������-[[r_sourceData1 c_sourceData1] [r_sourceData2 c_sourceData2]]
[r_sourceData1 c_sourceData1] = size(sourceData1);
[r_sourceData2 c_sourceData2] = size(sourceData2);

%��׼��ԭʼ���ݼ��������Ӧ�����ϵ������-[S_sourceData1 CS_sourceData1]
for k = 1:c_sourceData1
    S_sourceData1(:,k) = (sourceData1(:,k) - mean(sourceData1(:,k)))/std(sourceData1(:,k));
end
CS_sourceData1 = corrcoef(S_sourceData1);
clearvars k;

%�������ϵ������Ľ������е�����ֵ����������-[e]
e = eig(CS_sourceData1)
s = size(D, 1);
for k = 1:s
    e(k) = D(k, k);
end
e
clearvars V D k s;
size(sourceData1)
%�������ϵ��
for k = 1:r_sourceData1
    z0(k) = sourceData1(k, :) * transpose(e);
end
z0
m = 0;
for k = 1:4:(r_sourceData1-3)
    m = m+1;
    z1(m) = mean(z0(k:k+3));
end
z1
m = 0;
n = (size(z1,2)-2):size(z1,2);
for k = 3:2:7
    m = m+1;
    z2(m) = sum(sourceData2(:,k))/z1(n(m));
end
z2
p = z1(n) .* z2

%���PCAģ�ͼ��������
disp('# PCA���������ģ�ͼ��������');
disp('-------------------------------------------------------------------');
disp('## ����ֵe');
disp(e);
disp('## z0');
disp(z0);
