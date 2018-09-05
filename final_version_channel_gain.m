function [GAIN_C_UP,GAIN_C_DOWN,GAIN_D2BS,GAIN_BS2D,GAIN_D_UP,GAIN_D_DOWN,GAIN_C2D,GAIN_D2C]  =  final_version_channel_gain()

%���빦�ܣ������ŵ�ģ���������ŵ�����
%�����������Scenerioλ����Ϣ�����ľ�����Ϣ
%�������������ĸ����ŵ�����

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   TEST_ final_version��2018-05-23   ���м���������ݾ���ȷ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% GAIN_C2D        ::     ��ά����   ����  (����C,���ز�K��)                           
% GAIN_D2BS      ::     ��ά����   ����  (�鲥��D,���ز�K��)
% GAIN_D            ::     ��ά����   ����  (�鲥��D��,�Խ��ն�L�����ز�K��)              
% GAIN_C2D        ::     ��ά����   ����  (����C�����鲥��Di�У����ն�L�����ز�K��)      

global n t num_mlti K 

[DIS_C2D,DIS_Di2Dj,DIS_D,DIS_D2BS,DIS_C2BS] = final_version_Scenario()   ;                                                     % ����scenario���������������û�֮��ľ���

%% ���þ���DIS_C2BS�����ɷ����û�����վ���ŵ����棬�����Ѿ��ٶ������û��Ѿ�Ԥ�ȷ�����ŵ�
GAIN_C2BS                           =                            zeros(n,K);                                                                                % n��K�ľ���ÿ�������û���ÿ�����ز�������ŵ�����
G1                                         =                            10^(-2);                                                                                   % path loss constant
alpha1                                   =                            3;                                                                                             % path loss exponent 
for j=1:n
    beta1                                 =                            exprnd(1,1,K);                                                                           % ��˥�� ���Ӿ�ֵΪ1��ָ���ֲ� 
    gamma1                            =                            lognrnd(0,10^(0.8),1,K);                                                            % ��˥�� ���ӱ�׼��Ϊ8dB�Ķ�����̬�ֲ�  
    GAIN_C2BS(j,:)                   =                            G1*(beta1.*(gamma1)*DIS_C2BS(1,j)^(-alpha1));
end
for j=1:n
    for k=1:K
        if  GAIN_C2BS(j,k)>1e-4
            GAIN_C2BS(j,k)          =                            1e-8 + (9e-12-1e-12).*rand(1);
        end
    end
end
% for j=1:n
%     for k=1:K
%         if  GAIN_C2BS(j,k)<1e-11
%             GAIN_C2BS(j,k)          =                            1e-11 + (9e-12-1e-12).*rand(1);
%         end
%     end
% end

GAIN_C_UP                           =                             GAIN_C2BS(1,:);
GAIN_C_DOWN                    =                             GAIN_C2BS(2,:);

%% ���þ���DIS_D2BS�������鲥���ͷ������վ��D2D�û��ĸ��ŵ��ŵ�����
GAIN_BS2D                           =                            zeros(t,K);                                                                                 % t��K�ľ���ÿ���鲥�鷢�Ͷ˵���վ���ŵ�����
G2                                         =                            10^(-2);                                                                                   % path loss constant
alpha2                                   =                            3;                                                                                             % path loss exponent 
beta2                                    =                             exprnd(1,K,t);                                                                           % ��˥�� ���Ӿ�ֵΪ1��ָ���ֲ� 
gamma2                               =                             lognrnd(0,10^(0.8),K,t);                                                            % ��˥�� ���ӱ�׼��Ϊ8dB�Ķ�����̬�ֲ�  
NEWDIS_D2BS                     =                             repmat(DIS_D2BS, K , 1 );
GAIN_BS2D                          =                             G2*(beta2.*(gamma2.*NEWDIS_D2BS.^(-alpha2)))';




%% ���þ���DIS_D2BS�������鲥���ͷ�����鲥�鷢�Ͷ˶Ի�վ��ɵĸ���
GAIN_D2BS                           =                            zeros(t,K);                                                                                 % t��K�ľ���ÿ���鲥�鷢�Ͷ˵���վ���ŵ�����
G2                                         =                            10^(-2);                                                                                   % path loss constant
alpha2                                   =                            3;                                                                                             % path loss exponent 
beta2                                     =                            exprnd(1,K,t);                                                                           % ��˥�� ���Ӿ�ֵΪ1��ָ���ֲ� 
gamma2                                =                            lognrnd(0,10^(0.8),K,t);                                                            % ��˥�� ���ӱ�׼��Ϊ8dB�Ķ�����̬�ֲ�  
NEWDIS_D2BS                      =                            repmat(DIS_D2BS, K , 1 );
GAIN_D2BS                           =                            G2*(beta2.*(gamma2.*NEWDIS_D2BS.^(-alpha2)))';


%% ���þ���DIS_D�������鲥���ڲ������Ͷ˵����ն�֮��ľ��룬ͨ�ŵĽ�����ЧӦ�����ǵ���������ŵ�����
G3                                          =                           10^(-2);                                                                                    % path loss constant
alpha3                                    =                            3;                                                                                             % path loss exponent 
beta3                                      =                           exprnd(1,t,max(num_mlti),K);                                                     % ��˥�� ���Ӿ�ֵΪ1��ָ���ֲ� 
max(num_mlti);
gamma3                                 =                           lognrnd(0,10^(0.8),t,max(num_mlti),K);                                      % ��˥�� ���ӱ�׼��Ϊ8dB�Ķ�����̬�ֲ�  
GAIN_Dindex                          =                           G3*beta3.*gamma3;
D_alpha                                   =                          DIS_D.^(-alpha3);
%D_alpha(D_alpha==inf)         =                          0;
for Y=1:t
    for X=1:max(num_mlti)
        for k=1:K
        GAIN_D_UP(Y,X,k)=GAIN_Dindex(Y,X,k)*D_alpha(Y,X);
        end
    end
end

%% ���þ���DIS_D�������鲥���ڲ������Ͷ˵����ն�֮��ľ��룬ͨ�ŵĽ�����ЧӦ�����ǵ���������ŵ�����
G3                                          =                           10^(-2);                                                                                    % path loss constant
alpha3                                    =                            3;                                                                                             % path loss exponent 
beta3                                      =                           exprnd(1,t,max(num_mlti),K);                                                     % ��˥�� ���Ӿ�ֵΪ1��ָ���ֲ� 
max(num_mlti);
gamma3                                 =                           lognrnd(0,10^(0.8),t,max(num_mlti),K);                                      % ��˥�� ���ӱ�׼��Ϊ8dB�Ķ�����̬�ֲ�  
GAIN_Dindex                          =                           G3*beta3.*gamma3;
D_alpha                                   =                          DIS_D.^(-alpha3);
%D_alpha(D_alpha==inf)         =                          0;
for Y=1:t
    for X=1:max(num_mlti)
        for k=1:K
        GAIN_D_DOWN(Y,X,k)=GAIN_Dindex(Y,X,k)*D_alpha(Y,X);
        end
    end
end


%% ���þ���DIS_C2D,���ɷ����û���D2D���ն˸��ŵ��ŵ����棬DIS_C2D����ά���󣬱�ʾ�����û����鲥����ն˵ľ���
G5                                          =                           10^(-2);                                                                                    % path loss constant
alpha5                                    =                           3;                                                                                              % path loss exponent 
beta5                                      =                           exprnd(1,n,t);                                                  % ��˥�� ���Ӿ�ֵΪ1��ָ���ֲ� 
gamma5                                 =                           lognrnd(0,10^(0.8),n,t);                                   % ��˥�� ���ӱ�׼��Ϊ8dB�Ķ�����̬�ֲ� 
GAIN_C2D_index                    =                           G5*(beta5.*gamma5);
GAIN_C2D(:,:)                         =                           GAIN_C2D_index(:,:).*(DIS_C2D.^(-alpha5));


G6                                          =                           10^(-2);  
alpha6                                    =                           3;  
beta6                                      =                           exprnd(1,n,t);                                                  % ��˥�� ���Ӿ�ֵΪ1��ָ���ֲ� 
gamma6                                 =                           lognrnd(0,10^(0.8),n,t);                                   % ��˥�� ���ӱ�׼��Ϊ8dB�Ķ�����̬�ֲ� 
GAIN_D2C_index                    =                           G6*(beta6.*gamma6);
GAIN_D2C(:,:)                         =                           GAIN_D2C_index(:,:).*(DIS_C2D.^(-alpha6));
%end

