function price = DwnOutPutCN(S,K,r,T,sigma,q,Sb,Smax,dS,N)
dt = T/N;
M = round((Smax-Sb)/dS);
dS = (Smax-Sb)/M;
StockGrid = linspace(Sb,Smax,M+1);
FiniteMesh = zeros(M+1,N+1);
% Boundary condition at T and 0
FiniteMesh(:,N+1)=max(K-StockGrid,0);
FiniteMesh(1,:)=0;
FiniteMesh(M+1,:)=0;
% Coefficients
multiple = StockGrid(2:M)/dS;
alpha=0.25*dt*(sigma^2*(multiple.^2) - (r-q)*multiple);
beta=-0.50*dt*(sigma^2*(multiple.^2) + r);
gamma=0.25*dt*(sigma^2*(multiple.^2) + (r-q)*multiple);
% LU decomposition
M1 = -diag(alpha(2:M-1),-1)+ diag(1-beta(1:M-1))- diag(gamma(1:M-2),1);
[L U] = lu(M1);
M2 = diag(alpha(2:M-1),-1)+ diag(1+beta(1:M-1))+ diag(gamma(1:M-2),1);
% Solve sequence of linear systems
for j = N: -1 : 1
%   LUX=M2F; UX=L\M2F; X=U\(L\M2F)
    FiniteMesh(2:M,j) = U \ (L \ M2*FiniteMesh(2:M,j+1) );
end
price = interp1(StockGrid,FiniteMesh(:,1),S);


