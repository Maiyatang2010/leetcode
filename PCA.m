%function [vec_sort]=PCA(X,feature_dim_pca)
%{
%求均值
data_mean=mean(X);
X=bxsfun(@minus,X,data_mean);

%求协方差
data_cov=zeros(size(X,2),size(X,2));
len=size(X,1);
for i=1:size(X,1)
    data_cov=data_cov+X(i,:)'*X(i,:)
end
data_cov=data_cov/len;

%求特征根
[vec,lamda]=eig(data_cov);
[lamda,index]=sort(lamda,'descend');
vec_sort=vec(:,index);
%}
%由于上面的计算要加载全部的feat_mat，而整个文件的大小有1.5G左右，所以打算精简计算，同样将前150个样本作为训练样本
function PCA(class_num,part)
path=strcat('G:\data_',num2str(part),'\hanzi');
all_mean=zeros(1,448);

for k=1:class_num
    load(strcat(path,num2str(k),'.mat'));
    all_mean=all_mean+sum(feat_mat(1:120,:),1);
end
all_mean=all_mean/(120*class_num);
%all_mean=mean(data_mean(1:class_num,:));
cov=zeros(448);

for k=1:class_num
    load(strcat(path,num2str(k),'.mat'));
    feat_mat=bsxfun(@minus,feat_mat(1:120,:),all_mean);
    for i=1:120
        cov=cov+feat_mat(i,:)'*feat_mat(i,:);
    end
end
cov=cov/(class_num*120);
[vec_pca,lamda]=eig(cov);
lamda=diag(lamda);
[lamda,index]=sort(lamda,'descend');
vec_pca=vec_pca(:,index);
vec_path=strcat('G:\data_',num2str(part),'\vec_pca.mat');
save(vec_path,'vec_pca');
%save 'G:\\paras\\vec_pca.mat' vec_pca;
%save 'G:\\paras\\lamda_pca.mat' lamda;
%sum(lamda(1:256))/sum(lamda)