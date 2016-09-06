function lda_reduce(class_num,lda_dim,part)
%load 'G:\\paras\\vec_lda.mat';
load(['G:\data_',num2str(part),'_pca\vec_lda.mat']);
%path='G:\\data_pca\\hanzi';


for k=1:class_num
    %load(strcat(path,num2str(k),'.mat'));
    path=strcat('G:\data_',num2str(part),'_pca\hanzi',num2str(k),'.mat');
    load(path);
    feat_lda=feat_pca*vec_lda(:,1:lda_dim);
    save(strcat('G:\\data_',num2str(part),'_lda\\hanzi',num2str(k),'.mat'),'feat_lda');
end
clear all;



%此处是使用经过PCA降维的数据
%{
function lda_reduce(class_num,lda_dim)
load 'G:\\paras\\vec_lda.mat';
path='G:\\data_pca\\hanzi';

for k=1:class_num
    load(strcat(path,num2str(k),'.mat'));
    feat_lda=feat_pca*vec_lda(:,1:lda_dim);
    save(strcat('G:\\data_lda\\hanzi',num2str(k),'.mat'),'feat_lda');
end
clear all;
%}


%此处是直接使用原始数据，未经过PCA降维
%{
function lda_reduce(class_num,lda_dim)
load 'G:\\paras\\vec_lda.mat';
path='G:\\data_weight\\hanzi';

for k=1:class_num
    load(strcat(path,num2str(k),'.mat'));
    feat_wlda=feat_weit*vec_lda(:,1:lda_dim);
    save(strcat('G:\\data_wlda\\hanzi',num2str(k),'.mat'),'feat_wlda');
end
clear all;
%}
