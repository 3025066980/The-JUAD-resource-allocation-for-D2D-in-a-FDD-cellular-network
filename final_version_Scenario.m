function [DIS_C2D,DIS_Di2Dj,DIS_D,DIS_D2BS,DIS_C2BS] = final_version_Scenario()
 
%���빦��  ��   ��������û��ĵ���λ����Ϣ�����������ĸ��־�����Ϣ
%�������  ��   n-�����û�����
%                     t-D2D�鲥��ĸ���
%�������  ��   �����û�֮��ľ��룬���������ŵ�����

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   TEST_final_version��2018-04-08   ���м���������ݾ���ȷ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% DIS_C2D          ::     ��ά����   ����  (C��BS)                           
% DIS_D2BS        ::     ��ά����   ����  (D��BS)
% DIS_D              ::     ��ά����   ����  (D��l)              
% DIS_Di2Dj        ::     ��ά����   ����  (Di��Dj��l)   
% DIS_C2D          ::     ��ά����   ����  (C��D��l)  

global n t num_mlti K Rreqj 

% cla reset

%%  ���²�������Ҫ�ڷ���ʵ���п��ܸĶ��Ĳ������ط���������Ա������ı�****************************************************************************************************

%************************ �û�������Ϣ*******************************************
n                          =                          20;                          %�����û��ĸ���
Rreqj                    =                          6* ones(n,1);          % �����û��������͵�������������
t                           =                          20;                          %����D2D�鲥��ĸ���
K                           =                          20;

%num_mlti              =                          [3,3,4,4,5];                  %ÿһ��D2D�鲥���ڣ��м���D2D receiver������Ĭ��ÿ����ӵ���ĸ������û�
num_mlti            =                           1*ones(1,t);




%************************ �û�������Ϣ*******************************************
r                           =                           500;                             % ��վ�İ뾶
r_DG                     =                           5;                              % ����D2D�鲥��ģ��뾶����Ҫע����ǣ���������ֱ�Ǳߵĳ���
%**********************************************************************************

%% ***********************************************************************************************************************************************************************

x                           =                           2*r*rand(1,n)-r;             %�������x������
y                           =                           2*r*rand(1,n)-r;             %�������y������
location                    =                           x.^2+y.^2;
index1                      =                           find(location>r.^2);         %���ݹ��ɶ����ҵ����������ʣ���x��yֵ�����û���λ�ã��ڻ�վ��ĵ�
len1                        =                           length(index1) ;             %����index1��ά��
x(index1)                   =                           [];                          %����������Ļ�վ��ĵ㣬�ÿ�
y(index1)                   =                           [];
while len1                                                                           %���len��Ϊ0�������ڲ����������ĵ㣬��Ҫ���������µĵ�
    xt                      =                           2*r*rand(1,len1)-r;          %len����ȱ�ٵ�ĸ�������������ȱ�ٵĵ㼴��
    yt                      =                           2*r*rand(1,len1)-r;
    index2                  =                           find(xt.^2+yt.^2>r.^2);
    len1                    =                           length(index2);
    xt(index2)              =                           [];
    yt(index2)              =                           [];
    x                       =                           [x xt];                      %���µ����������ĵ�Ž���������
    y                       =                           [y yt];
end
x;                                                                                   %�����û�����λ�õ�xֵ
y;                                                                                   %�����û�����λ�õ�yֵ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����D2D�鲥���λ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dx                          =                            2*r*rand(1,t)-r;            %D2D�û����Ͷ�����λ�õ�xֵ
dy                          =                            2*r*rand(1,t)-r;
index3                      =                            find(dx.^2+dy.^2>r.^2);
len2                        =                            length(index3);
dx(index3)                  =                            [];
dy(index3)                  =                            [];
while len2
    xt                      =                            2*r*rand(1,len2)-r;
    yt                      =                            2*r*rand(1,len2)-r;
    index4                  =                            find(xt.^2+yt.^2>r.^2);
    len2                    =                            length(index4);
    xt(index4)              =                            [];
    yt(index4)              =                            [];
    dx                      =                            [dx xt];
    dy                      =                            [dy yt];
end

%TODO:ÿ����ӵ�н����û��ĸ����ǲ�ͬ�ģ�8,10,6,6,��������
%Χ����ÿһ�����Ͷˣ�ӵ�в�ͬ��Ŀ�Ľ��նˣ����鲥�����û��ĸ����ǲ���ͬ�ģ���4,5,6,7��
alternate_t                 =                            t; 
linkdx                      =                            zeros(t,max(num_mlti));
linkdy                      =                            zeros(t,max(num_mlti));
for group=1:t
    new_linkdx              =                            dx(group)+r_DG*2^0.5*ones(1,num_mlti(group));
    new_linkdy              =                            dy(group)+r_DG*2^0.5*ones(1,num_mlti(group)); 
    for userl=1:num_mlti(group)
        linkdx(group,userl)      =                           new_linkdx(1,userl);
        linkdy(group,userl)      =                           new_linkdy(1,userl);
    end
end
 linkdx;
 linkdy;
%%%%%%%%%%%%%%%%%%%%%%%%%%�����ǻ�ͼ���ݣ�����Fig.1����ͨ��ϵͳ����ͼ%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x0                          =                            0;                          %����Բ������ı߿�
y0                          =                            0;
r                           =                            500;
theta                       =                            0:pi/50:2*pi;
x1                          =                            x0+r*cos(theta);
y1                          =                            y0+r*sin(theta);

%  ��ͼ����
% plot(x0,y0,'sk',x,y,'v')
% hold on  
% for group=1:t
%     plot(dx(group),dy(group),'r*')
%     hold on 
%     for num=1:num_mlti(group)
%         plot(linkdx(group,num),linkdy(group,num),'*r')  
%         hold on 
%     end
% end
% plot(x1,y1,'-k')
% hold on
% legend('BS','CU','DTx','DRx');
% axis equal

%%%%%%%%%%%%%%%%%%%%%%%%%%��������û�֮��ľ��룬�����ŵ������ģ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DIS_C2D                      =                            [];                         %��ά���󣬱�ʾ�����û���ÿ��D2D�鲥���ÿһ�����ն˵�λ�ã�������������û����鲥�����û��ĸ���
DIS_Di2Dj                    =                            [];                         %��ά���󣬱�ʾD2D�鲥�鷢�Ͷ˵������鲥����ն˵ľ��룬��������D2D�鲥��֮�以��ĸ��� 
DIS_D                          =                            [];                         %��ά���󣬱�ʾD2D�鲥���ڣ����Ͷ˵����ն˵ľ�����Ϣ����������D2Dͨ�ŵĽ�����ЧӦ�������ŵ�����
DIS_D2BS                    =                            [];                         %��ά���󣬱�ʾÿһ��D2D�鲥��ķ��Ͷ˶Ե���վ�ľ��룬��������D2D�����з����û��ĸ���
DIS_C2BS                    =                            [];                         %��ά���󣬱�ʾÿ�������û�������վ��λ�ã��������ɷ����û����ŵ�����

%sym cindex;                                                                         % ��ʾcellular user
%sym dindex;                                                                         % ��ʾD2D group
%sym lindex;                                                                          % ��ʾl user in D2D group  
for cindex=1:n 
    for dindex=1:t
        for lindex=1:num_mlti(dindex)
            DIS_C2D(cindex,dindex,lindex)    = sqrt(  (x(1,cindex)-linkdx(dindex,lindex))^2 + (y(1,cindex)-linkdy(dindex,lindex))^2   );
        end
    end
end
%size(DIS_C2D)                                                                        % ���Ծ����С                                                            
%D=DIS_C2D(1,5,:)                                                                  % ���Ծ���������Ϊ��������

%sym igroup                                                                            % ��i��D2D�鲥��
%sym jgroup                                                                            % ��j���鲥��
%sym luser                                                                               % ��j���鲥���еĵ�l���û�                       
for igroup=1:t
    for jgroup=1:t
        for luser=1:num_mlti(jgroup)
            DIS_Di2Dj(igroup,jgroup,luser)   = sqrt(  (dx(1,igroup)-linkdx(jgroup,luser))^2 +  (dy(1,igroup)-linkdy(jgroup,luser))^2  );
        end
    end
end
%size(DIS_Di2Dj)                                                                        % ���Ծ����С                                                            
%D=DIS_Di2Dj(3,3,:)                                                                  % ���Ծ���������Ϊ��������

%sym igroup                                                                              % ��i��D2D�鲥��
%sym luser                                                                                 % ��j���鲥���еĵ�l���û�                 
for igroup=1:t
    for luser=1:num_mlti(igroup)
        DIS_D(igroup,luser)                 =  sqrt( (dx(1,igroup)-linkdx(igroup,luser))^2 +  (dy(1,igroup)-linkdy(igroup,luser))^2  );
    end
end
%size(DIS_D)                                                                               % ���Ծ����С                                                            
%D=DIS_D(5,:)                                                                            % ���Ծ���������Ϊ��������

for igroup=1:t
    DIS_D2BS(1,igroup)                      =   sqrt( dx(1,igroup)^2   +   dy(1,igroup)^2     );
end
%DIS_D2BS                                                                            %���Ծ���������Ϊ��������

for cindex=1:n
    DIS_C2BS(1,cindex)                      =   sqrt(  x(1,cindex)^2   +    y(1,cindex)^2     );
end
%DIS_C2BS                                                                            %���Ծ���������Ϊ��������




