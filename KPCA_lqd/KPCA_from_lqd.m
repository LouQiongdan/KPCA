function [ goal_dataSets ] = KPCA_from_lqd( data,l,kernal_type ,para)
%UNTITLED4 此处显示有关此函数的摘要
% Input:
    % data:the original data sets,whose dimensions we need to reduce. The dimension of the original data set is N*d
    % l:the number of data sets' dimensions after KPCA
    % kernal_type:the type of kernal functions,e.g.:linear,rbf,poly.the default is linear
    %para:para is the parameter.if kernal_type==rbf,the para denotes sigma,sigma>0;if kernal_type==poly,the para denotes b,b>=1;
    % sigma: sigma>0,which is the Gaussian'width
    %b:b>=1,which is the Poly's parameter
% Output:
    % goal_data:the goal data set after KPCA.The dimension of the goal data set is N*l
%   此处显示详细说明
sig=para;
b=para;
if ~exist('data','file')
    disp('Lack of data sets!!!');
    return;
end
if ~exist('l','var')
    l = size(data,1)/2;
end 
if ~exist('kernal_type','var')
    kernal_type = 'linear';
end
if strcmp(kernal_type,'rbf') 
    if ~exist('para','var')
        disp('the Gaussian function lacks of parameter ---- sigma !!!');
        return;
    elseif para <= 0
        disp('the (parameter) sigma must bigger than 0!!!');
        return;
    end
end
if strcmp(kernal_type,'poly')
    if ~exist('para','var')
        disp('the Poly function lacks of parameter ---- b !!!');
        return;
    elseif sig<1
        disp('the (parameter)b >= 1 must!!!');
        return;
    end
end

N = size(data,1);
kernal_matrix=zeros(N,N);
switch kernal_type
    case 'linear'
        kernal_matrix= data*(data');
    case 'rbf'
        sig=para;
        for i = 1:N
            for j=1:N
                kernal_matrix(i,j)=exp(-(norm(data(i,:)-data(j,:))^2)/(2*sig*sig))+eps;
            end
        end
    case 'poly'
        b=para;
        kernal_matrix=(data*(data')).^b;
end
Mean=mean(kernal_matrix,1);
kernal_matrix_centered=kernal_matrix-repmat(Mean,N,1);
[eigVec,eigVal]=eigs(kernal_matrix_centered,l,'lr');
for i = 1:l
    eigVec(:,i)=eigVec(:,i)/sqrt(eigVal(i,i));
end
goal_dataSets=kernal_matrix_centered*eigVec;
end

