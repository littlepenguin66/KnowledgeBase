% ����6.4��a_isf_lpc_conversion.m
clear;close all
clc
fid=fopen('sx86.txt','r');
p1=fscanf(fid,'%f')
fclose(fid);
p=filter([1 -0.68], 1, p1);%Ԥ�����˲�
x=fra(320,160,p);
x=x(60,:);
a3=lpc(x,15);
a4 = a3(:); %������Ԥ��ϵ����������a4
lsf=a_lsf_conversion(a4) ;  %���ú���a_lsf_conversionʵ�ִ�LPCϵ����lsf������ת��
%����a_lsf_conversion()��MATLAB���������6.6.2����������
%�˴�Ҳ�ɵ���MATLAB�Դ��Ŀ⺯��lsf=poly2lsf(a4) ;
isf=lsf;
isf(16,1)=0.5*acos(a4(16,1));
%isp�����һ������ȡΪa�����һ��������isf�����һ������ȡΪ0.5*acos(a4(16,1))
 
%�����Ǵ�isf��a�ĳ�������ǰp-1��a��������ǰp-1��isf�����õ������һ��a��������isf�ĵ�p����%���õ�
isf1=isf(1:(size(isf)-1),:);%��isfǰp-1����������isf1
a2=lsf_lpc_conversion(isf1)%���ú���lsf_lpc_conversionʵ�ִ�lsf������LPCϵ����ת��
a2(1,16)=cos(2*isf(16,1));%���һ��a��������isf�ĵ�p�������õ�
a=a2;%��ת���õ���lpcϵ������a
%EOF  a_isf_lpc_conversion.m
