% ����6.3��a_lsf_main.m
%��֪�����ļ������LPCϵ���󣬵���a_lsf_conversion.m���������Ӧ��LSF
%a_lsf_main.m
clear;close all%�����б�����Ϊ0
clc%��������
fid=fopen('sx86.txt','r');
p1=fscanf(fid,'%f')
fclose(fid);
p=filter([1 -0.68], 1, p1)%Ԥ�����˲�
x=fra(320,160,p) %��֡��֡��Ϊ160������
x=x(60,:)%ȡ��60֡��Ϊ����֡
N=16%������Ԥ������Ľ״θ�ֵ
a1=lpc(x,N)%����MATLAB�⺯���е�lpc��������LPCϵ��a1
%�˴�Ҳ���Ե��ñ��¸��ĺ���lpc_coefficients(s,p)���������Ϊa1= lpc_coefficients(x,N)
a = a1(:);%������Ԥ��ϵ��a1��������a
lsf=a_lsf_conversion(a)%���ú���a_lsf_conversionʵ�ִ�LPCϵ����LSF������ת��
%lsf=poly2lsf(a);%Ҳ�ɵ���MATLAB�⺯���е�poly2lsf(a)��������LSFϵ�������ý��Ϊ��
%һ����Ƶ�ʡ�
lsf_abnormalized=lsf.*(6400/3.14);%����õ�lsf��������һ��������һ����0-6400Hz
%ʹ��ʱ�ɸ���ʵ����Ҫ���и��ģ���խ���������������ź�Ƶ����ΧΪ200-3400Hz����ʱ����Ҫ��%6400Hz��Ϊ3400Hz 
%����õĹ�һ��������һ��lsf����������ı��ļ�����lpcϵ����õ�lsf����.txt
fid= fopen('��lpcϵ����õ�lsf����.txt','w');
        fprintf(fid,'��һ����lsf��\n');
        fprintf(fid,'%6.2f�� ',lsf);
        fprintf(fid,'\n');
        fprintf(fid,'����һ����lsf��\n');
        fprintf(fid,'%8.4f�� ',lsf_abnormalized);
        fclose(fid);
%EOF  a_lsf_main.m
