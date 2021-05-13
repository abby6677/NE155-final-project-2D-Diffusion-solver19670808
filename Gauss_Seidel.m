function solution = Gauss_Seidel(A,B,x)
    %Goal: Use Gauss-Seidel to find solution of system Ax=B,
    %the input x is the initial guess
    
    %Problem for Gauss-Seidel: sufficient (not necessary condition: 
    %A is diagonally dominant)
    
    %size of A
    N=size(A);
    n=N(1);
    
    %Gauss-Seidel Method
    itr=0;
    diff=1e-5;
    e=10;
    
    while e>diff
        x_old=x;
        for i=1:n
            sum=0;
            
            for j=1:i-1
                sum=sum+A(i,j)*x(j);
            end
            
            for j=i+1:n
                sum=sum+A(i,j)*x_old(j);
            end
            
            x(i)=(B(i)-sum)/A(i,i);
        end
        
        itr=itr+1;
        e=norm(x_old-x);
    end
    solution=x;
    
    %display
    numitr=['The number of iterations for GS is:',num2str(itr)];
    disp(numitr)