% ����3.9��xiuzhengzixiangguan.m
fid=fopen('voice.txt','rt')
b=fscanf(fid,'%f');

b1=b(1:640);
N=320;                                       %ѡ��Ĵ���
A=[];
for k=1:320;
sum=0;
for m=1:N;
sum=sum+b1(m)*b1(m+k-1);
end
A(k)=sum;
end
for k=1:320
A1(k)=A(k)/A(1);                              %��һ��
end
figure(1)
subplot(3,1,1)
plot(A1);
xlabel('��ʱ k')
ylabel('R(k)')
legend('N=320')
axis([0,320,-1,1]);

b2=b(1:320);
N=160;                                     %ѡ��Ĵ���
B=[];
for k=1:160;
sum=0;
for m=1:N;
sum=sum+b2(m)*b2(m+k-1);
end
B(k)=sum;
end
for k=1:160
B1(k)=B(k)/B(1);%��һ��B(k)
end
figure(1)
subplot(3,1,2)
plot(B1);
xlabel('��ʱ k')
ylabel('R(k)')
legend('N=160')
axis([0,320,-1,1]);

b3=b(1:140);                               %ѡ���������ʼ��
N=70;                                     %ѡ��Ĵ���
C=[];
for k=1:70;
sum=0;
for m=1:N;
sum=sum+b3(m)*b3(m+k-1);
end
C(k)=sum;
end
for k=1:70
C1(k)=C(k)/C(1);%��һ��C(k)
end
figure(1)
subplot(3,1,3)
plot(C1);
xlabel('��ʱ k')
ylabel('R(k)')
legend('N=70')
axis([0,320,-1,1]);
