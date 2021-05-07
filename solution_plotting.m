function mesh=solution_plotting(solution)
    N=size(solution);
    n=sqrt(N(1));
    mesh=zeros([n,n]);
    for i=1:n
        for j=1:n
            mesh(i,j)=solution((i-1)*n+j);
        end
    end
    