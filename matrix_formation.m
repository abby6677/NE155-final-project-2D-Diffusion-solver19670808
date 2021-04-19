function [A,B]=matrix_formation(D,S,C,h)
    %D=Diffusion matrix, S=Source matrix, C=Cross Section matrix, h=mesh spacing
    %The goal is to find A and B for Ax=B

    %find array size, which should be the same as the Diffusion matrix size
    N=size(D);
    n=N(1);
    
    %B matrix formation: reordering of S matrix
    B=S(n,:);
    for i=1:n-1
        B=[B,S(n-i,:)];
    end
    B=transpose(B);
    
    %Setting matrix A size
    x=linspace(0,(n-1)*h,n);
    y=linspace(0,(n-1)*h,n);
    A=zeros([n,n]);
    
    %
    

