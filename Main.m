%% Define the inputs 
% The Diffusion matrix:
D=

% The Source matrix:
S=

% The Cross Section matrix 
C=

% The mesh spacing
h=

%% Input Testing
% Call function input_test
proceed=input_test(D,S,C,h);

%% Matrix Formation for system Ax=B
% Call function matrix_function
[A,B]=matrix_formation(D,S,C,h);

%% Iterative Methods for solving Ax=B
% Pick one

% Gauss-Seidel (Faster Convergence)
tic
solution = Gauss_Seidel(A,B,x)
toc

% Jacobi (Veeeeeeery slow convergence :( )
tic
solution = Jacobi(A,B,x)
toc

