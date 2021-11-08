clc;
clear all;
close all;



I=imread('C:\Users\harsh\Documents\MATLAB\baboon.tiff');
I=imresize(I,[512,512]);



[R,C,Z]=size(I);
if Z==3
    I=rgb2gray(I);
end

Iorig=I;

n=512;
I=double(I);
% figure;imshow(I,[]);title('Original Image');
a=checkerboard(n);
% outlier=findOutlier(I(i,j));
count=((R*C)-((2*R)+(2*(C-2))))/2;
peArr=double(zeros(count,1));
k=1;
% for i=2:R-1
%     for j=2:C-1
%         if a(i,j)==0
%             sum0=double(I(i-1,j))+double(I(i,j-1))+double(I(i+1,j))+double(I(i,j+1));
%             pred=round((sum0/4));
%             pe=pred-I(i,j);
%             peArr(k)=pe;
%             k=k+1;
%         end
%     end
% end
%figure;histogram(peArr);title('Prediction errors before histogram shifting');
% h=histogram(peArr,1);
% mini=min(peArr(:));
%histogram shifting
% I1=I;
% peArr1=double(zeros(count,1));
% k1=1;
% for i=2:R-1
%     for j=2:C-1
%         if a(i,j)==0
%             sum1=double(I1(i-1,j))+double(I1(i,j-1))+double(I1(i+1,j))+double(I1(i,j+1));
%             pred1=round((sum1/4));
%             pe1=pred1-I1(i,j);
%             if pe1>0 %if prediction error is greater than 0
%                 I1(i,j)=I1(i,j)-1; %decrease the original pixel value by 1
%                 pe2=pred1-(I1(i,j)); %prediction error increases by 1.histogram is shifted to right by 1
%                 peArr1(k1)=pe2;
%                 k1=k1+1;
%             elseif pe1<0 %if prediction error is less than 0
%                 I1(i,j)=I1(i,j)+1; %increase the original pixel value by 1
%                 pe2=pred1-(I1(i,j)); %prediction error decreases by 1.histogram is shifted to left by 1
%                 peArr1(k1)=pe2;
%                 k1=k1+1;
%             else %if prediction error is 0, do not alter the pixel
%                 peArr1(k1)=pe1;
%                 k1=k1+1;
%             end
%         end
%     end
% end
%messsage embedding
% H1=imhist(peArr1);
% [Height,peak]=max(H1);
% figure;imhist(H1);title('After histogram Shifting');
% [maxi,freq]=mode(peArr1); %returns the prediction error which occured more
% D=randi([0,1],1,freq);
% idx=1;
% IS=I1;
% for i=2:R-1
%     for j=2:C-1
%         if a(i,j)==0
%             sum2=double(IS(i-1,j))+double(IS(i,j-1))+double(IS(i+1,j))+double(IS(i,j+1));
%             pred2=round(sum2/4);
%             err=pred2-IS(i,j);
%             if err==0 %if prediction error=0, use that pixel for data hiding
%                 DB=D(1,idx); %process one at a time
%                 if DB==1
%                     IS(i,j)=IS(i,j)+1; %add one to the pixel 
%                 end
%                 idx=idx+1;
%             end
%         end
%     end
% end
% % disp(Height);
% figure;imshow(IS,[]);title('Stego Image');
% %message extraction
%if the pre;diction error is 1 in stegeo image, extract 1, else extract 0
% EM=zeros(1,freq);
% K2=1;
% IR=IS;
% for i=2:R-1
%     for j=2:C-1
%         if a(i,j)==0
%             s_sum=double(IR(i,j-1))+double(IR(i-1,j))+double(IR(i,j+1))+double(IR(i+1,j));
%             s_pred=round(s_sum/4);
%             s_err=s_pred-IR(i,j);
%             if(s_err==0) %if prediction error is 0, extract 0 from the pixel
%                 EM(1,K2)=0;
%                 K2=K2+1;
%             elseif(s_err==-1) %if prediction error is -1, extract 1 from that pixel
%                 EM(1,K2)=1;
%                 K2=K2+1;
%                 IR(i,j)=IR(i,j)-1;
%             elseif(s_err>0) %if prediction error is >1, increase the original pixel value by 1 to recover the original image
%                 IR(i,j)=IR(i,j)+1;
%             else %if prediction error is <1, decrease the original pixel value by 1 to recover the original image
%                 IR(i,j)=IR(i,j)-1;
%             end
%         end
%     end
% end
% figure;imshow(IR,[]);title('Image after messsage extraction');
% ER=freq/(R*C);  %Embedding rate
% BER=sum(abs(D-EM))/freq;    %bit error rate
% PS=psnr(I,IR);  %peak signal to noise ratio
% len=length(srcFiles);
% q=1;
% RES=double(zeros(len,1));
% SSIM=ssim(I,IR);
% for i=1:len
%     RES(q)=SSIM;
%     q=q+1;
% end
%new prediction error algo
newArr=double(zeros(count,1));
newInd=1;
for i=2:R-1
    for j=2:C-1
        if a(i,j)==0
            d1=abs(I(i,j)-I(i-1,j));
            d2=abs(I(i,j)-I(i,j+1));
            d3=abs(I(i,j)-I(i+1,j));
            d4=abs(I(i,j)-I(i,j-1));
            max_diff=max([d1,d2,d3,d4]); %finding the pixel which has max diff with the center pixel
            if(max_diff==d1)
                newsum=double(I(i,j+1))+double(I(i+1,j))+double(I(i,j-1));
            elseif(max_diff==d2)
                newsum=double(I(i-1,j))+double(I(i+1,j))+double(I(i,j-1));
            elseif(max_diff==d3)
                newsum=double(I(i-1,j))+double(I(i,j+1))+double(I(i,j-1));
            else
                newsum=double(I(i-1,j))+double(I(i,j+1))+double(I(i+1,j));
            end
            newpred=round(newsum/3);
            newerr=newpred-I(i,j);
            newArr(newInd)=newerr;
            newInd=newInd+1;
        end
    end
end
%histogram shifting 
newI1=I;
newArr1=double(zeros(count,1));
newInd2=1;
for i=2:R-1
    for j=2:C-1
        if a(i,j)==0
            d1=abs(I(i,j)-I(i-1,j));
            d2=abs(I(i,j)-I(i,j+1));
            d3=abs(I(i,j)-I(i+1,j));
            d4=abs(I(i,j)-I(i,j-1));
            max_diff=max([d1,d2,d3,d4]); %finding the pixel which has max diff with the center pixel
            if(max_diff==d1)
                newsum=double(I(i,j+1))+double(I(i+1,j))+double(I(i,j-1));
            elseif(max_diff==d2)
                newsum=double(I(i-1,j))+double(I(i+1,j))+double(I(i,j-1));
            elseif(max_diff==d3)
                newsum=double(I(i-1,j))+double(I(i,j+1))+double(I(i,j-1));
            else
                newsum=double(I(i-1,j))+double(I(i,j+1))+double(I(i+1,j));
            end
            newpred1=round((newsum/3));
            newpe1=newpred1-newI1(i,j);
            if newpe1>0 %if prediction error is greater than 0
                newI1(i,j)=newI1(i,j)-1; %decrease the original pixel value by 1
                newpe2=newpred1-(newI1(i,j)); %prediction error increases by 1.histogram is shifted to right by 1
                newArr1(newInd2)=newpe2;
                newInd2=newInd2+1;
            elseif newpe1<0 %if prediction error is less than 0
                newI1(i,j)=newI1(i,j)+1; %increase the original pixel value by 1
                newpe2=newpred1-(newI1(i,j)); %prediction error decreases by 1.histogram is shifted to left by 1
                newArr1(newInd2)=newpe2;
                newInd2=newInd2+1;
            else %if prediction error is 0, do not alter the pixel
                newArr1(newInd2)=newpe1;
                newInd2=newInd2+1;
            end
        end
    end
end
%message embeding
[maxi2,freq2]=mode(newArr1); %returns the prediction error which occured more
D2=randi([0,1],1,freq2);
ind=1;
newIS=newI1;
for i=2:R-1
    for j=2:C-1
        if a(i,j)==0
            d1=abs(I(i,j)-I(i-1,j));
            d2=abs(I(i,j)-I(i,j+1));
            d3=abs(I(i,j)-I(i+1,j));
            d4=abs(I(i,j)-I(i,j-1));
            max_diff=max([d1,d2,d3,d4]); %finding the pixel which has max diff with the center pixel
            if(max_diff==d1)
                newsum=double(I(i,j+1))+double(I(i+1,j))+double(I(i,j-1));
            elseif(max_diff==d2)
                newsum=double(I(i-1,j))+double(I(i+1,j))+double(I(i,j-1));
            elseif(max_diff==d3)
                newsum=double(I(i-1,j))+double(I(i,j+1))+double(I(i,j-1));
            else
                newsum=double(I(i-1,j))+double(I(i,j+1))+double(I(i+1,j));
            end
            newpred2=round(newsum/3);
            newerr=newpred2-newIS(i,j);
            if newerr==0 %if prediction error=0, use that pixel for data hiding
                newDB=D2(1,ind); %process one at a time
                if newDB==1
                    newIS(i,j)=newIS(i,j)+1; %add one to the pixel 
                end
                ind=ind+1;
            end
        end
    end
end
%message extraction
newEM=zeros(1,freq2);
K3=1;
newIR=newIS;
for i=2:R-1
    for j=2:C-1
        if a(i,j)==0
            d1=abs(I(i,j)-I(i-1,j));
            d2=abs(I(i,j)-I(i,j+1));
            d3=abs(I(i,j)-I(i+1,j));
            d4=abs(I(i,j)-I(i,j-1));
            max_diff=max([d1,d2,d3,d4]); %finding the pixel which has max diff with the center pixel
            if(max_diff==d1)
                newsum=double(I(i,j+1))+double(I(i+1,j))+double(I(i,j-1));
            elseif(max_diff==d2)
                newsum=double(I(i-1,j))+double(I(i+1,j))+double(I(i,j-1));
            elseif(max_diff==d3)
                newsum=double(I(i-1,j))+double(I(i,j+1))+double(I(i,j-1));
            else
                newsum=double(I(i-1,j))+double(I(i,j+1))+double(I(i+1,j));
            end
            newpred3=round(newsum/3);
            newerr2=newpred3-newIR(i,j);
            if(newerr2==0) %if prediction error is 0, extract 0 from the pixel
                newEM(1,K3)=0;
                K3=K3+1;
            elseif(newerr2==-1) %if prediction error is -1, extract 1 from that pixel
                newEM(1,K3)=1;
                K3=K3+1;
                newIR(i,j)=newIR(i,j)-1;
            elseif(newerr2>0) %if prediction error is >1, increase the original pixel value by 1 to recover the original image
                newIR(i,j)=newIR(i,j)+1;
            else %if prediction error is <1, decrease the original pixel value by 1 to recover the original image
                newIR(i,j)=newIR(i,j)-1;
            end
        end
    end
end





        

