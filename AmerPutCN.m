function price = AmerPutCN(S,K,r,T,sigma,q,Smax,dS,N,weight,tolerance)
dt = T/N;
M = round(Smax/dS);
StockGrid = linspace(0,Smax,M+1);
% Boundary condition for American Put at S
ValueZero = K;
ValueSmax = 0;
% Boundary condition for American Put at T
Intrinsic = max(K-StockGrid,0);
% Coefficients
i = 1:M-1;
alpha=0.25*dt*(sigma^2*(i.^2) - (r-q)*i);
beta=-0.50*dt*(sigma^2*(i.^2) + r);
gamma=0.25*dt*(sigma^2*(i.^2) + (r-q)*i);
% SOR matrix decomposition
M2 = diag(alpha(2:M-1),-1)+ diag(1+beta(1:M-1))+ diag(gamma(1:M-2),1);
adjust = zeros(M-1,1);
adjust(1)= alpha(1)* (ValueZero + ValueZero);
adjust(M-1)= alpha(M-1)* (ValueSmax + ValueSmax);
%Iterative Method
pastx = zeros(M-1,1);
newx = zeros(M-1,1);
% Solve backward through time
pastx(:) = Intrinsic(2:M);
for j=N:-1:1
    b = M2*pastx(:) + adjust;
    iTx = pastx;
    error = realmax;
    while tolerance < error
            newx(1)=iTx(1)+(weight/(1-beta(1)))*(b(1) - (1-beta(1))*iTx(1) + gamma(1)*iTx(2));
            newx(1) = max(Intrinsic(2),newx(1));
        for k=2:M-2
            newx(k)=iTx(k)+(weight/(1-beta(k)))*(b(k)+alpha(k)*newx(k-1)-(1-beta(k))*iTx(k)+gamma(k)*iTx(k+1));
            newx(k) = max(Intrinsic(k+1),newx(k));
        end
            newx(M-1)=iTx(M-1)+(weight/(1-beta(M-1)))*(b(M-1)+alpha(M-1)*newx(M-2)-(1-beta(M-1))*iTx(M-1));
            newx(M-1) = max(Intrinsic(M),newx(M-1));
        error = norm(newx-iTx);
        iTx = newx;
    end
    pastx=newx;
end
solution = [ValueZero; newx ; ValueSmax];
price = interp1(StockGrid,solution,S);