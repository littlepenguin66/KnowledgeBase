% ����6.5��a_isf_lpc_conversion_20frame.m
%������20֡������16��ISF�켣ͼ
%a_isf_lpc_conversion_20frame.m
clear;close all
clc
fid=fopen('sx86.txt','r');
p1=fscanf(fid,'%f')
fclose(fid);
p=filter([1 -0.68], 1, p1);%Ԥ�����˲�
x1=fra(320,160,p);
for i=60:79
x=x1(i,:)
a3=lpc(x,15);
a4 = a3(:);%������Ԥ��ϵ����������a4
lsf=a_lsf_conversion(a4)%���ú���a_lsf_conversionʵ�ִ�LPCϵ����lsf������ת��
isf=lsf;
isf(16)=0.5*acos(a4(16,1));%isp�����һ������ȡΪa�����һ��������isf�����һ������ȡΪ%0.5*acos(a4(16,1))
isp=cos(isf);
hold on%������20֡isp��isf������һ��ͼ����
figure(1);
       for j=1:16
       isf2(i-59,j)=isf(j);
       end
figure(2);
plot(isp)
end
%EOF  a_isf_lpc_conversion_20frame.m
