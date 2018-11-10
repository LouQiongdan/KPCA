 load('D:\Lqd_CX\日常降维学习算法\自己写的\KPCA_lqd\data\haberman.mat');
 Data=data(:,1:3);
 target=data(:,4);
 train_target=target(1:245,:);
 test_target=target(246:end,:);
 train_target= train_target';
 test_target=test_target';
 l=2;
 kernal_type='rbf';
 sigmaORb= 2.5;
 [ goal_dataSets ] = KPCA_from_lqd( Data,l,kernal_type,sigmaORb );
 train_data=goal_dataSets(1:245,:);
 test_data=goal_dataSets(246:end,:);
 
Num=10;
Smooth=0.01;
[Prior,PriorN,Cond,CondN]=MLKNN_train(train_data,train_target,Num,Smooth);
[HL1,~,~,~,~,~,Pre_Labels1]=MLKNN_test(train_data,train_target,test_data,test_target,Num,Prior,PriorN,Cond,CondN);
