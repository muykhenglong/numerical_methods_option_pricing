function price = EurPutImplicit(S,K,r,T,sigma,q,Smax,dS,N)
M = round(Smax/dS);
dt = T/N;
FiniteMesh = zeros(M+1,N+1);
StockGrid = linspace(0,Smax,M+1);
% Boundary condition at T and 0
FiniteMesh(:,N+1)=max(K-StockGrid,0);
Expire = N:-1:0;
FiniteMesh(1,:)=K*exp(-r*dt*Expire);
FiniteMesh(M+1,:)=0;
% Coefficients
step = 1:M-1;
a=0.5*dt*((r-q)*step - sigma^2*step.^2);
b=1 + dt*sigma^2*step.^2 + r*dt;
c=-0.5*dt*((r-q)*step + sigma^2*step.^2);
% LU decomposition
coeff = diag(a(2:M-1),-1)+diag(b(1:M-1))+ diag(c(1:M-2),1);
[L, U] = lu(coeff);
% Solve sequence of linear systems
adjust = zeros(M-1,1);
for j = N: -1 : 1
    adjust(1) = -a(1)*FiniteMesh(1,j);
    adjust(M-1) = -c(M-1)*FiniteMesh(M+1,j);
%   A\B = INV(A)*B
%   LUX=C; UX=L\C; X=U\(L\C)
    FiniteMesh(2:M,j) = U \ (L \ (FiniteMesh(2:M,j+1) + adjust));
end
price = interp1(StockGrid,FiniteMesh(:,1),S);
