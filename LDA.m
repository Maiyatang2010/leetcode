%这里X包含全部的样本数据，且数据是按类聚簇的，每个簇的大小是snum_per_class
%{
function [vec_sort]=LDA(X,class_num,snum_per_class)
data_mean=zeros(class_num,size(X,2));
Sw=zeros(size(X,2));
Sb=zeros(size(X,2));
for i=1:class_num
    Start=(i-1)*snum_per_class+1;
    End=i*snum_per_class;
    current_mean=mean(X(Start:End,:));
    data_mean(i,:)=current_mean;
    for j=Start:End
        Sw=Sw+(X(j)-current_mean)'*(X(j)-current_mean);
    end
end

all_mean=mean(data_mean);
for i=1:class_num
    Sb=Sb+snum_per_class*((data_mean(i,:)-all_mean)'*(data_mean(i,:)-all_mean));
end

combine_mat=inv(Sb)*Sw;
[vec,lamda]=eig(combine_mat);
[lamda,index]=sort(lamda,'descend');
vec_sort=vec(:,index);
%}

%注意此处要load的data应该是经过PCA降维后的data,不是512维的raw data
%{
function LDA(class_num,pca_dim,part)
Sw=zeros(pca_dim);
data_mean=[];
path=strcat('G:\\data_',num2str(part),'_pca\\hanzi');
for k=1:class_num
    load(strcat(path,num2str(k),'.mat'));
    cur_mean=mean(feat_pca(1:120,:));
    data_mean(k,:)=cur_mean;
    feat_pca=bsxfun(@minus,feat_pca(1:120,:),cur_mean);
    for i=1:120
        Sw=Sw+feat_pca(i,:)'*feat_pca(i,:);
    end
end

Sb=zeros(pca_dim);
all_mean=mean(data_mean);
data_mean=bsxfun(@minus,data_mean,all_mean);
for k=1:class_num
    Sb=Sb+120*data_mean(k,:)'*data_mean(k,:);
end

combine_mat=inv(Sw)*Sb;
[vec_lda,lamda]=eig(combine_mat);
lamda=diag(lamda);
[lamda,index]=sort(lamda,'descend');
vec_lda=vec_lda(:,index);
vec_path=strcat('G:\data_',num2str(part),'_pca\vec_lda.mat');
save(vec_path,'vec_lda');
%save 'G:\\paras\\vec_lda.mat' vec_lda;
%save 'G:\\paras\\lamda_lda.mat' lamda;
clear all;
%}


%此处的是直接LDA,不使用经过pca的数据
function LDA(class_num,pca_dim)
Sw=zeros(pca_dim);
data_mean=[];
path='G:\data\hanzi';
for k=1:class_num
    load(strcat(path,num2str(k),'.mat'));
    cur_mean=mean(feat_mat(1:150,:));
    data_mean(k,:)=cur_mean;
    feat_mat=bsxfun(@minus,feat_mat(1:150,:),cur_mean);
    for i=1:150
        Sw=Sw+feat_mat(i,:)'*feat_mat(i,:);
    end
end

Sb=zeros(pca_dim);
all_mean=mean(data_mean);
data_mean=bsxfun(@minus,data_mean,all_mean);
for k=1:class_num
    Sb=Sb+150*data_mean(k,:)'*data_mean(k,:);
end

combine_mat=inv(Sw)*Sb;
[vec_lda,lamda]=eig(combine_mat);
lamda=diag(lamda);
[lamda,index]=sort(lamda,'descend');
vec_lda=vec_lda(:,index);
save 'G:\paras\vec_lda.mat' vec_lda;
clear all;
