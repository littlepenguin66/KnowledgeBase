% ����6.6��a_lpcc_main.m
%a_lpcc_main����
%��֪�����ļ������LPCϵ���󣬵���lpc_lpcc_conversion����������lpcc���� 
%���������ļ�����lpcϵ����õ�LPCC����.txt��
clear;close all
clc
fid=fopen('sx86.txt','r');
p1=fscanf(fid,'%f')
fclose(fid);
p=filter([1 -0.68], 1, p1)%Ԥ�����˲�
x=fra(320,160,p)%��p���з�֡��֡��320��֡��160
x=x(60,:)
a1=lpc(x,16)
a = a1(:);%������Ԥ��ϵ����������a
a_num=16;%a_numΪ����Ԥ�⵹��ϵ���״Σ�������a��0��
C_num=16;%C_numΪ����Ԥ�⵹��ϵ��LPCC����
lpcc=lpc_lpcc_conversion(a,C_num,a_num)%����lpc_lpcc_conversion����������lpcc����
%���������ļ�����lpcϵ����õ�LPCC����.txt��
fid= fopen('��lpcϵ����õ�LPCC����.txt','w');
fprintf(fid,'lpcϵ����\n');
fprintf(fid,'%6.2f�� ',a);
fprintf(fid,'\n');
fprintf(fid,'��lpcϵ����õ�LPCC������\n');
fprintf(fid,'%8.4f�� ',lpcc);
fclose(fid);
%EOF a_lpcc_main����
