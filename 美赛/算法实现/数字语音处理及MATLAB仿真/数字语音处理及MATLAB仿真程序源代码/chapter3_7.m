% ����3.7��zhuoyinzixiangguan.m
fid=fopen('voice.txt','rt')
x=fscanf(fid,'%f');
fclose(fid);

s1=x(1:320);                                  %ѡ��һ��320���������
N=320;                                      %ѡ��Ĵ���

A=[];                                        %��N=320�ľ��δ�
for k=1:320;
sum=0;
for m=1:N-k+1;
sum=sum+s1(m)*s1(m+k-1);                     %���������
end
A(k)=sum;
end
for k=1:320
A1(k)=A(k)/A(1);   %��һ��A(k);
end

f=zeros(1,320);                                %��N=320�Ĺ�����
n=1;j=1;
   while j<=320
      f(1,j)=x(n)*[0.54-0.46*cos(2*pi*n/320)];
      j=j+1;n=n+1;
   end
B=[];
for k=1:320;
sum=0;
for m=1:N-k+1;
sum=sum+f(m)*f(m+k-1);
end
B(k)=sum;
end
for k=1:320
B1(k)=B(k)/B(1);%��һ��B(k)
end
s2=s1/max(s1);
figure(1)
subplot(3,1,1)
plot(s2)
title('һ֡�����ź�')
xlabel('������')
ylabel('��ֵ')
axis([0,320,-1,1]);
subplot(3,1,2)
plot(A1);
title('�Ӿ��δ�������غ���')
xlabel('��ʱ k')
ylabel('R(k)')
axis([0,320,-1,1]);
subplot(3,1,3)
plot(B1);
title('�ӹ�����������غ���')
xlabel('��ʱ k')
ylabel('R(k)')
axis([0,320,-1,1]);
