% ����7.1��train_codebook.m
clear all
codebook_size=6;%�����С
codebook_dimen=7;%M:����ά��
signal_num=100;%�μ�ѵ�������ĸ���
circle_num=20;%����ѵ��ѭ����������ѡ�����������ʧ����Ϊ�����������Ͳ�ʹ�øñ���
fid=fopen('lbg_7.txt','rt');          %���������ļ�lbg_7.txt
input=fscanf(fid,'%f');%�����������ļ��е����ݸ���input
fclose(fid);
num=size(input/codebook_dimen);%���������ݴ�С

x=input(1000:1000+signal_num*codebook_dimen);
  %ȡ�����������ļ���1000��1500��(500/codebook_dimen=100=signal_num)�����ݣ���Ϊѵ������

s=zeros(codebook_size,codebook_dimen);%��ʼ����ʼ����
train_signal=zeros(signal_num,codebook_dimen);
final_codebook=zeros(codebook_size,codebook_dimen);%��ʼ����������
y_center=zeros(codebook_size,codebook_dimen);  %��ʼ������������
r=1;
for i=1:signal_num
    for j=1:codebook_dimen
     train_signal(i,j)=x(r);
     r=r+1;
    end
end  
%ѡ���ʼ����
for i=1:codebook_size
    for j=1:codebook_dimen
    s(i,j)=train_signal(i*5,j); %ÿ��5������ȡһ������������s������Ϊ��ʼ���� 
    end
end
number=zeros(signal_num,1);

D=50000;%��ʼƽ��ʧ��
j2=0;
xiangdui__distort_value=50000;
 for j1=1:circle_num;%�ó���ѭ������circle_num�ν���
  while(xiangdui__distort_value>0.0000001)%�����ʧ��С��0.000001ʱ�������� 
   j2=j2+1;%��������ʧ��Ϊѭ������������j2�ɼ�¼��ѭ������
   
   %-----����ѵ������������������飬����������������������ѵ�����������������------
   for j=1:signal_num    % signal_num��ѵ�������ĸ���
       for k=1:codebook_size     
            A=0;
            for m=1:codebook_dimen
                A=A+(train_signal(j,m)-s(k,m))^2;%����ѵ�������뵱ǰ�������ĵľ���
            end
           d(k)=A;
      end
        dm=min(d);%�ҳ�ѵ�����������е�ǰ���������Сֵ
        %-----�ҳ���ѵ������j������С�����������
        for  n=1:codebook_size
          if d(n)==dm
             p=n;
          end
        end 
     number(j)=p;
      %-----�ҳ���ѵ������j������С���������������
   end
   %-----����ѵ������������������飬����������������������ѵ����������������Ž���------
   N1=zeros(codebook_size,1);%N1��ÿ�������������������
   %-----���������Ĺ���------
   for t=1:codebook_size
        y=zeros(codebook_dimen,1);  %codebook_dimen:����ά��
        N=0;
        for j=1:signal_num  % signal_num��ѵ�������ĸ���
            if t==number(j);
               for m=1:codebook_dimen
                 y(m)=y(m)+train_signal(j,m);
               end
                N=N+1;%��������ÿ���������������
            end
        end 
        N1(t,1)=N;%����ÿ���������������
        if N1(t,1)>0
             for m=1:codebook_dimen
             y_center(t,m)=y(m)/N1(t,1);%��ÿ�����������
             s(t,m)=y_center(t,m);%��ѵ�����������ĸ��� s
             final_codebook(t,m)=y_center(t,m);
             end
        end
   end
   %-----���������Ľ���------
   
   %-----��ƽ��ʧ��------
   ave_distort(j2)=0;
   for n=1:signal_num
        for m=1:codebook_dimen
          ave_distort(j2)=ave_distort(j2)+(train_signal(n,m)-s(number(n),m))^2; %������ѵ���������������������ĵľ���
        end
   end
   ave_distort(j2)=ave_distort(j2)/signal_num;%�����j1��ѭ����ƽ��ʧ��
   %-----��ƽ��ʧ�����------
    
   xiangdui__distort(j2)=abs((D-ave_distort(j2))/D); %�����ʧ��
   D=ave_distort(j2);
   xiangdui__distort_value=xiangdui__distort(j2);
  end
 j1=circle_num;
 end
%��ѵ���õ�����д���ı��ļ�
 fid= fopen('ѵ���õ�����.txt','w');
       for t=1:codebook_size
           for m=1:codebook_dimen
              fprintf(fid,'%6.2f��', s(t,m)); 
           end
           fprintf(fid,'\n');
       end
       fclose(fid);
  
 
