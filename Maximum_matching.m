%% �������ܣ�ͨ��ʹ���������㷨�����û��������ز�����

clear all

%% �����д�� text �ļ�
% fid0 = fopen('C:\Users\Administrator\Desktop\DOWN500\D=2\AVE_R_D.txt','a');                                                                                                          % д�� DUE �û�����������֮��
% 
% fid1 = fopen('C:\Users\Administrator\Desktop\DOWN500\D=2\AVE_SUM_capacity.txt','a');                                                                                          % д�� ϵͳ�������������֮��


%% ��ʼ������ģ�д����±�����ֵΪ0
AVE_R_D1                                                  =                         0;                                      
AVE_SUM_capacity1                                  =                         0;    
ratio                                                               =                     0;
sum_sum1  =0;
a=0;
b=0;
C=0;
C2=0;







for loop=1:100                                                                                                                                                                         % ѭ�� 1000 �Σ�ȡƽ��ֵ

    
%% ��������ȫ�ֱ����� n �Ƿ����û��ĸ����� t ��D2D�û��ĸ���
global n t 

n                                                                =                          20;                                                                                                                          % �����û��ĸ���
t                                                                 =                          20;                                                                                                                          % ����DUE�ĸ���

%% ���� GP_method �����������������㷨�Ķ���ͼƥ���Ȩֵ
Weight_matrix                                           =                         zeros(t,2*n);
RD                                                             =                         zeros(t,2*n);
RC                                                             =                         zeros(t,2*n);                                    
for DUE=1:t
    for CUE=1:n
        
        [Solution_up,Solution_down,Need_RC_up,Need_RC_down,R_CU_UP,R_CU_DOWN,Need_RD_up,Need_RD_down] = GP_method(CUE, DUE); %����һ��һ��ƥ�䣬�õ�ƥ���Ĺ���ֵ
        
        Weight_matrix(DUE,CUE*2-1 )             =                        Solution_up;
        %Weight_matrix(DUE,CUE*2 )                =                        Solution_down;      
        RD(DUE,CUE*2-1)                               =                        Need_RD_up;
        %RD(DUE,CUE*2)                                  =                        Need_RD_down;
        RC(DUE,CUE*2-1)                               =                        Need_RC_up;
        %RC(DUE,CUE*2)                                  =                        Need_RC_down;        
    end
end


%% test for Hungarian_Algorithm
% costMat                                                     =                        [5 4 1 2; 3 2 3 2; 3 1 1 5; 4 3 1 2]; 
% Max_value                                                 =                        max(max(costMat));
% costMat                                                     =                        Max_value - costMat;
% [assignment,cost]                                       =                        Hungarian_Algorithm1(costMat);

%% ʹ���������㷨������û���ѵ�ƥ��ֵ
costMat                                                     =                        Weight_matrix;
Max_value                                                 =                        max(max(costMat));
costMat                                                     =                        Max_value - costMat;
[assignment,cost]                                       =                        Hungarian_Algorithm1(costMat);
AAA                                                           =                        assignment;

%% ��ƥ�����õ��ľ��󣬸�ԭ�õ�D2D�û������������
R_D_sum                                                   =                         0;
for i=1:t
    if AAA(1,i)~=0
        R_D_sum                                               =                         R_D_sum + RD(i,AAA(1,i));
    end
end

ACCESS = 0;
for i=1:t
    if AAA(1,i)~=0
        if RD(i,AAA(1,i)) ~= 0
        	 ACCESS           =     ACCESS +1;
        end
    end
end

% for x=1:t
%      if  AAA(1,x)>2n
%          AAA(1,x)=0;
%      end
% end
%  

 
      
%% R_D_sum �Ƿ�������� DUE �û�����������֮��
R_D_sum;

AVE_R_D1                                                  =                         AVE_R_D1 + R_D_sum;
AVE_R_D                                                  =                         AVE_R_D1/10;

%% ��ƥ�����õ���ֵ����ԭ�õ�
R                                                                =                        zeros(t,2*n);
R_sum                                                        =                        sum(R_CU_UP)+sum(R_CU_DOWN);                                        % �ܵ���������Ϊ��������������������������֮��


sum_sum1                              =       sum_sum1 +      R_sum;                  

sum_sum                               =         sum_sum1/10;


for DUE=1:t
    for CUE=1:n
        if assignment(1,DUE)==CUE*2-1                                                                                                                                  % ���DUE�����˷����û�������·�����ز�
            R( DUE,CUE*2-1)                            =                        1;                                                                                             % �Ƚ�ƥ��֮ǰ���������ʼ������ټ���ƥ���Ժ�ϵͳ�����������                                                                                         
            R_sum                                            =                         R_sum +Weight_matrix(DUE,CUE*2-1)  ;
            a=Weight_matrix(DUE,CUE*2-1);
        end
        if assignment(1,DUE)==CUE*2                                                                                                                                     % ���DUE�����˷����û�������·�����ز�                          
            R( DUE,CUE)                                   =                        1;     
            R_sum                                            =                         R_sum +Weight_matrix(DUE,CUE)  ;  
            b=Weight_matrix(DUE,CUE);
        end
    end
end

for i=1:t
    a=Weight_matrix(i,assignment(1,i));
   C=C+a;
end


C1=C/10;


need=sum_sum+C1;


for i=1:t
    b=RD(i,assignment(1,i));
   C2=C2+b;
end

DD=C2/100

%% R_sum ���Ƿ�������� ϵͳ����������֮��




R_sum;

AVE_SUM_capacity1                                      =                      AVE_SUM_capacity1 +  R_sum;
AVE_SUM_capacity                                      =                      AVE_SUM_capacity1/10;


ratio1                                                             =                    ACCESS/t;
ratio                                                               =                    ratio+ratio1 ;
%ratio                                                               =                    ratio/100 


end



% fprintf (fid0,'%f\n',AVE_R_D);
% fclose (fid0) ;
% 
% fprintf (fid1,'%f\n',AVE_SUM_capacity);
% fclose (fid1) ;














