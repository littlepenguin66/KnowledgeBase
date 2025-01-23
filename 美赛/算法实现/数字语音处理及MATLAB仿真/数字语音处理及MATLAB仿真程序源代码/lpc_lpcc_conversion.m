%���㵹�ײ���C(1)-C(C_num)�ĺ���
%����lpcΪlpcϵ����a_numΪLPCϵ������,��LPCϵ���״Σ�������a��0����
%C_numΪ����ϵ������
% lpc_lpcc_conversion.m
function lpcc=lpc_lpcc_conversion(a,C_num,a_num) 
n_lpc=a_num;n_lpcc=C_num; 
lpcc=zeros(n_lpcc,1); %��ʼ��lpcc����Ϊn_lpcc��1�е�һ��ȫ0����
lpcc(1)=a(1); %C(1)=a(1)
%���㵹�ײ���C(2)��C(n_lpc)
for n=2:n_lpc 
    lpcc(n)=a(n); 
    for m=1:n-1 
        lpcc(n)=lpcc(n)+a(m)*lpcc(n-m)*(n-m)/n; 
    end 
end 
%���㵹�ײ���C(n_lpc+1)��C(C_num) 
for n=n_lpc+1:n_lpcc 
    lpcc(n)=0; 
    for m=1:n_lpc 
        lpcc(n)=a(n)+a(m)*lpcc(n-m)*(n-m)/n; 
    end 
end 
%EOF lpc_lpcc_conversion.m
