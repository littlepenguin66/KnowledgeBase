% ����3.11��AMDF.m
fid=fopen('voice.txt','rt')
[b,count]=fscanf(fid,'%f',[1,inf]);
fclose(fid);
	
b1=b(1:640);
N=320;                          %ѡ��Ĵ���
A=[];
for k=1:320;
sum=0;
for m=1:N;
sum=sum+abs(b1(m)-b1(m+k-1));
end
A(k)=sum;
end

s=b(1:320)
figure(1)
subplot(2,1,1)
plot(s);
xlabel('������')
ylabel('����')
title('�����ź�')
axis([0,320,-2*10^3,2*10^3])
subplot(2,1,2)
plot(A);
xlabel('��ʱk')
ylabel('AMDF')
title('�����źŵ�AMDF')
axis([0,320,0,3.5*10^5]);
