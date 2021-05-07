function [A,B]=matrix_formation(D,S,C,e,d)
    %D=Diffusion matrix, S=Source matrix, C=Cross Section matrix, h=mesh spacing
    %The goal is to find A and B for Ax=B

    %% find array size, which should be the same as the Diffusion matrix size
    N=size(D);
    n=N(1);
    
    %% Finding the elements of vector b
    %update S(i,j) under finite voludme method
    
    %Note: Different from in the notes, when looking for the value on top, we
    %need j-1 instead of j+1; vice versa
    
    S_old=S;
    V=e*d/4;
    for i=2:n-1
        for j=2:n-1
            S(i,j)=(S_old(i,j)+S_old(i+1,j)+S_old(i+1,j-1)+S_old(i,j-1))*V;
        end
    end
        
    %% Finding the elements of matrix A
    %for points within the mesh (not at boundaries)
    %aL/aR/aB/aT records the left/right/bottom/top contributions
    
    %Note: Different from in the notes, when looking for the value on top, we
    %need j-1 instead of j+1; vice versa
    
    aL=zeros([n,n]); aR=zeros([n,n]); aB=zeros([n,n]); aT=zeros([n,n]);
    aC=zeros([n,n]);
    for i=2:n-1
        for j=2:n-1
            aL(i,j)=-(D(i,j)+D(i,j-1))*e/(2*d);
            aR(i,j)=-(D(i+1,j)+D(i+1,j-1))*e/(2*d);
            aB(i,j)=-(D(i,j)+D(i+1,j))*d/(2*e);
            aT(i,j)=-(D(i,j-1)+D(i+1,j-1))*d/(2*e);
            aC(i,j)=(C(i,j)+C(i+1,j)+C(i+1,j-1)+C(i,j-1))*V-(aL(i,j)+aR(i,j)+aB(i,j)+aT(i,j));        
        end
    end
    
    %% Boundary Conditions
    % Vacuum b.c. on bottom(j=n) and left(i=1) surfaces
    % Reflective b.c. on top(j=1) and right(i=n) surfaces
    % Regard top-left, bottom-left, and bottom-right corners as part of
    % vacuum b.c.
    
    % At the left boundary, where i=1,
    for j=1:n
        aC(1,j)=1;
        S(1,j)=0;
    end
    % At the bottom boundary, where j=n
    for i=1:n
        aC(i,n)=1;
        S(i,n)=0;
    end
    
    % At the right boundary, where i=n
    for j=2:n-1
        aL(n,j)=-(D(n,j)+D(n,j-1))*e/(2*d);
        aB(n,j)=-D(n,j)*d/(2*e);
        aT(n,j)=-D(n,j-1)*d/(2*e);
        aC(n,j)=(C(n,j)+C(n,j-1))*V-(aL(n,j)+aB(n,j)+aT(n,j));
        S(n,j)=(S_old(n,j)+S_old(n,j-1))*V;
    end
    
    % At the top boundary, where j=1
    for i=2:n-1
        aL(i,1)=-D(i,1)*e/(2*d);
        aR(i,1)=-D(i+1,1)*e/(2*d);
        aB(i,1)=-(D(i,1)+D(i+1,1))*d/(2*e);
        aC(i,1)=(C(i,1)+C(i+1,1))*V-(aL(i,j)+aR(i,j)+aB(i,j));
        S(i,1)=(S_old(i,j)+S_old(i+1,j))*V;
    end
    
    % At the top-right corner, (n,1)
    aL(n,1)=-D(n,1)*e/(2*d);
    aB(n,1)=-D(n,1)*d/(2*e);
    aC(n,1)=C(n,1)*V-(aL(n,1)+aB(n,1));
    S(n,1)=S_old(n,1)*V;
    
    %% Vector b formation
    B=S(1,:);
    for i=2:n
        B=[B,S(i,:)];
    end
    B=transpose(B);

    %% Matrix A Formation
    A=zeros([n*n,n*n]);
    % The diagonal of A should be elements of aC
    for i=1:n
        for j=1:n
            for ind=n*(j-1)+1:n*(j-1)+n
                A(ind,ind)=aC(i,j);
            end
        end
    end
    % The first lower diagonal of A should be elements of aL
    for i=2:n
        for j=1:n
            for ind=n*(j-1)+1:n*(j-1)+(n-1)
                A(ind+1,ind)=aL(i,j);
            end
        end
    end
    % The nth lower diagonal of A should be elements of aB
    for i=1:n
        for j=1:n-1
            for ind=n*(j-1)+1:n*(j-1)+n
                A(ind+n,ind)=aB(i,j);
            end
        end
    end
    % The first upper diagonal of A should be elements of aR
    for i=1:n-1
        for j=1:n
            for ind=n*(j-1)+1:n*(j-1)+(n-1)
                A(ind,ind+1)=aR(i,j);
            end
        end
    end
    % The nth upper diagonal of A should be elements of aT
    for i=1:n
        for j=2:n
            for ind=n*(j-2)+1:n*(j-2)+n
                A(ind,ind+n)=aT(i,j);
            end
        end
    end
