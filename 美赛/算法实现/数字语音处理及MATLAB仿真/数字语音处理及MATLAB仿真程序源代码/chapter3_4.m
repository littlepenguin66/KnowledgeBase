% ����3.4��nengliang.m
fid=fopen('zqq.txt','rt');          %���������ļ�
x=fscanf(fid,'%f');
fclose(fid);

%����N=50��֡��=50ʱ����������
s=fra(50,50,x)               
s2=s.^2;                    %һ֡�ڸ����������
energy=sum(s2,2)            %��һ֡����
subplot(2,2,1)               %���廭ͼ�����Ͳ��� 
plot(energy)                %��N=50ʱ����������ͼ
xlabel('֡��')               %������
ylabel('��ʱ���� E')         %������
legend('N=50')              %���߱�ʶ
axis([0,1500,0,2*10^10])      %����������귶Χ
%����N=100��֡��=100ʱ����������
s=fra(100,100,x)            
s2=s.^2;
energy=sum(s2,2)            
subplot(2,2,2)              
plot(energy)                %��N=100ʱ����������ͼ
xlabel('֡��')
ylabel('��ʱ���� E')
legend('N=100')
axis([0,750,0,4*10^10])       %����������귶Χ
%����N=400��֡��=400ʱ����������
s=fra(400,400,x)            
s2=s.^2;
energy=sum(s2,2)
subplot(2,2,3)               
plot(energy)                %��N=400ʱ����������ͼ
xlabel('֡��')
ylabel('��ʱ���� E')
legend('N=400')
axis([0,190,0,1.5*10^11])        %����������귶Χ
%����N=800��֡��=800ʱ����������
s=fra(800,800,x)             
s2=s.^2;
energy=sum(s2,2)
subplot(2,2,4)               
plot(energy)                 %��N=800ʱ����������ͼ
xlabel('֡��')
ylabel('��ʱ���� E')
legend('N=800')
axis([0,95,0,3*10^11])        %����������귶Χ

