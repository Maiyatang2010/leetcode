function pca_reduce(class_num,pca_dim,part)
%load 'G:\\paras\\vec_pca.mat';
load(['G:\data_',num2str(part),'\vec_pca.mat']);
%path='G:\\data\\hanzi';

for k=1:class_num
    %load(strcat(path,num2str(k),'.mat'));
    path=strcat('G:\data_',num2str(part),'\hanzi',num2str(k),'.mat');
    load(path);
    feat_pca=feat_mat*vec_pca(:,1:pca_dim);
    save(strcat('G:\\data_',num2str(part),'_pca\\hanzi',num2str(k),'.mat'),'feat_pca');
end
clear all;