%����3.1��gaopintisheng.m
%����������xylabel��ע���ύ����û��
fid=fopen('voice2.txt','rt')    %���ļ�
e=fscanf(fid,'%f');          %������
ee=e(200:455);            %ѡȡԭʼ�ļ�e�ĵ�200��455�������,Ҳ��ѡ��������
r=fft(ee,1024);             %���ź�ee����1024�㸵��Ҷ�任
r1=abs(r);                 %��rȡ����ֵ r1��ʾƵ�׵ķ���ֵ
pinlv=(0:1:255)*8000/512    %���Ƶ�ʵĶ�Ӧ��ϵ
yuanlai=20*log10(r1)       %�Է�ֵȡ����
signal(1:256)=yuanlai(1:256);%ȡ256���㣬Ŀ���ǻ�ͼ��ʱ��ά��һ��
[h1,f1]=freqz([1,-0.98],[1],256,4000);%��ͨ�˲���
pha=angle(h1);           %��ͨ�˲�������λ
H1=abs(h1);             %��ͨ�˲����ķ�ֵ
r2(1:256)=r(1:256)
u=r2.*h1'               % ���ź�Ƶ�����ͨ�˲���Ƶ����� �൱����ʱ��ľ��
u2=abs(u)              %ȡ���Ⱦ���ֵ
u3=20*log10(u2)        %�Է�ֵȡ����
un=filter([1,-0.98],[1],ee)  %unΪ������Ƶ�������ʱ���ź�
figure(1);subplot(211);
plot(f1,H1);title('��ͨ�˲����ķ�Ƶ��Ӧ');
xlabel('Ƶ��/Hz');
ylabel('����');
subplot(212);plot(pha);title('��ͨ�˲�������λ��Ӧ');
xlabel('Ƶ��/Hz');
ylabel('�Ƕ�/radians');
figure(2);subplot(211);plot(ee);title('ԭʼ�����ź�');
xlabel('������');
ylabel('����');
axis([0 256 -3*10^4 2*10^4]);
subplot(212);plot(real(un));
title('����ͨ�˲���������ź�');
xlabel('������');
ylabel('����');
axis([0 256 -1*10^4 1*10^4]);
figure(3);subplot(211);plot(pinlv,signal);title('ԭʼ�����ź�Ƶ��');
xlabel('Ƶ��/Hz');
ylabel('����/dB');
subplot(212);plot(pinlv,u3);title('����ͨ�˲���������ź�Ƶ��');
xlabel('Ƶ��/Hz');
ylabel('����/dB');

