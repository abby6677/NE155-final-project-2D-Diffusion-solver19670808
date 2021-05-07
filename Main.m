%% time recording 
tStart=cputime;

%% Define the inputs 
% The Diffusion matrix:
D=[0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5
   0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5
   0.5 0.5 0.4 0.4 0.5 0.5 0.4 0.4 0.5 0.5
   0.5 0.5 0.4 0.4 0.5 0.5 0.4 0.4 0.5 0.5
   0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5
   0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5
   0.5 0.5 0.4 0.4 0.5 0.5 0.4 0.4 0.5 0.5
   0.5 0.5 0.4 0.4 0.5 0.5 0.4 0.4 0.5 0.5
   0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5
   0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5];

% The Source matrix:
S=[1 1 1 1 1 1 1 1 1 1;
   1 1 1 1 1 1 1 1 1 1;
   1 1 2 2 1 1 2 2 1 1;
   1 1 2 2 1 1 2 2 1 1;
   1 1 1 1 1 1 1 1 1 1;
   1 1 1 1 1 1 1 1 1 1;
   1 1 2 2 1 1 2 2 1 1;
   1 1 2 2 1 1 2 2 1 1;
   1 1 1 1 1 1 1 1 1 1;
   1 1 1 1 1 1 1 1 1 1;]; 

% The Cross Section matrix 
C=[0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7;
   0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7;
   0.7 0.7 0.8 0.8 0.7 0.7 0.8 0.8 0.7 0.7;
   0.7 0.7 0.8 0.8 0.7 0.7 0.8 0.8 0.7 0.7;
   0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7;
   0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7;
   0.7 0.7 0.8 0.8 0.7 0.7 0.8 0.8 0.7 0.7;
   0.7 0.7 0.8 0.8 0.7 0.7 0.8 0.8 0.7 0.7;
   0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7;
   0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7;];

% The mesh spacing
e=3;
d=2;

%% Input Testing
% Call function input_test
proceed=input_test(D,S,C,e,d);

%% Matrix Formation for system Ax=b
% Call function matrix_function
[A,B]=matrix_formation(D,S,C,e,d);

%% Iterative Methods for solving Ax=b
N=size(D); n=N(1);
x=ones([n*n,1]);

% Gauss-Seidel
tic
solution1 = Gauss_Seidel(A,B,x);
toc

% Jacobi
tic
solution2 = Jacobi(A,B,x);
toc

%% Solution matrix formation and plotting
figure;
mesh=solution_plotting(solution1);
[x,y]=meshgrid(0:d:d*(n-1),0:e:e*(n-1));
surf(x,y,mesh)
print('solution','-dpng')

%% Display inputs and outputs
disp('With the inputs of diffusion matrix,');
D
disp('the cross section matrix,');
C
disp('and the source matrix,')
S
disp(['along with the mesh spacings e=',num2str(e),'and d=',num2str(d),','])
disp('we find the solution through this 2D diffusion equation solution, we find the solution to be')
mesh

%% version control
%code name, version number, author name(s), date and time of execution
ver
disp('It is now')
now=datetime('now','Timezone','local')
disp('Running the solver has taken')
time=cputime-tStart
dbstack('-completenames')
author='This solver is created by Yun-Hsuan Lee.';
disp(author)
%publish('main.m','pdf')