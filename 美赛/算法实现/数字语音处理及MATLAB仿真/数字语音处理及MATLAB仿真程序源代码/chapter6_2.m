% ����6.2��a_lsf_continue_20frame.m
%a_lsf_continue_20frame.m
clear;close all
clc
fid=fopen('sx86.txt','r');
p1=fscanf(fid,'%f')
fclose(fid);
p=filter([1 -0.68], 1, p1)%Ԥ�����˲�
x1=fra(320,160,p)%��֡��ÿ֡320�����㣬֡�ص�160������
for i=60:79  %ȡ����60��79֡���źŽ��з���
x=x1(i,:)
a1=lpc(x,16)
a = a1(:);%������Ԥ��ϵ����������a
lsf=a_lsf_conversion(a)%���ú���a_lsf_conversionʵ�ִ�LPCϵ����lsf������ת��������%a_lsf_conversion������6..6.2����������
lsp=cos(lsf)
hold on %������20֡lsp������һ��ͼ��figure(1)��
figure(1);
       for j=1:16
       lsp1(i-59,j)=lsp(j);
       end
figure(2);
plot(lsf)
end
%EOF a_lsf_continue_20frame.m

