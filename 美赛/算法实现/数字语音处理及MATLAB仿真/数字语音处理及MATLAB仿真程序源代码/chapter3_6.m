% ����3.6��guoling.m
clear all
fid=fopen('beijing.txt','rt')
x1=fscanf(fid,'%f');
fclose(fid);
x=awgn(x1,15,'measured');%����15dB������
s=fra(220,110,x);%��֡��֡��110
zcr=zcro(s);%�������
figure(1);
subplot(2,1,1)
plot(x);
title('ԭʼ�ź�');
xlabel('������');
ylabel('����');
axis([0,39760,-2*10^4,2*10^4]);
subplot(2,1,2)
plot(zcr);
xlabel('֡��');
ylabel('�������');
title('ԭʼ�źŵĹ�����');
axis([0,360,0,200]);


