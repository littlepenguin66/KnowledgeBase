% ����3.12��
fid=fopen('zhouqi.txt','rt');          %���������ļ�
zhouqi=fscanf(fid,'%f');
fclose(fid);

zhouqi0=medfilt1(zhouqi,5);  %�����ֵƽ��
zhouqi1=medfilt1(zhouqi0,3); %������ֵƽ����zhouqi1Ϊ�����ֵƽ����������ֵƽ�����
zhouqi2=linsmooth(zhouqi0,5);%�������ƽ����zhouqi2Ϊ�����ֵƽ�����������ƽ�����

w=[];
w=zhouqi;
w1=w-zhouqi2;
w1=medfilt1(w1,5);         %�����ֵƽ��
w1=linsmooth(w1,5);        %�������ƽ��
zhouqi3=w1+zhouqi2;       %����ƽ���㷨

v=[];
v(1)=0;v(2)=0;v(3)=0;v(4)=0;  %��ʱ4������
for i=1:(length(zhouqi)-4)
    v(i+4)=zhouqi(i);
end
v=v(:);
v1=v-zhouqi2;
v1=medfilt1(v1,5);          %�����ֵƽ��
v1=linsmooth(v1,5);         %�������ƽ��
zhouqi4=v1+zhouqi2;        %����ʱ�Ķ���ƽ���㷨

figure(1)
subplot(511)
plot(zhouqi);
xlabel('֡��')
ylabel('������')
axis([0,360,0,150])
title('ԭʼ�������ڹ켣')

subplot(512),plot(zhouqi2);
xlabel('֡��')
ylabel('������')
axis([0,360,0,150])
title('�����ֵƽ����������ֵƽ�����')

subplot(513),plot(zhouqi2);
xlabel('֡��')
ylabel('������')
axis([0,360,0,150])
title('�����ֵƽ�����������ƽ�����')

subplot(514),plot(zhouqi3);
xlabel('֡��')
ylabel('������')
axis([0,360,0,150])
title('����ƽ���㷨')

subplot(515),plot(zhouqi4);
xlabel('֡��')
ylabel('������')
axis([0,360,0,150])
title('����ʱ�Ķ���ƽ���㷨')
