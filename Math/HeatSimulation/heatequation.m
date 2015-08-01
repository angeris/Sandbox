N = 1000;

U = zeros(N, N);
dU = zeros(N, N);

h = 1/N;
h2 = h.^2;
dt = .0001;

for i=1:N
    for j=1:N
        U(i,j) = 100*(1/(1+2*(N/4-i)^2+(N/4-j)^2) + ...
            1/(1+2*(3*N/4-i)^2+(3*N/4-j)^2));
    end
end

U(:, 1) = 0;
U(:, end) = 0;
U(1, :) = 0;
U(end, :) = 0;

loops = 100;

F(loops) = struct('cdata',[],'colormap',[]);

for S=1:loops
    for i=2:N-1
        for j=2:N-1
            dU(i,j) = (U(i+1, j) + U(i-1, j) + U(i, j+1) + U(i, j-1) ...
                - 4*U(i, j))/h;
        end
    end
    imagesc(log10(max(U, 1e-5)), [-5 inf]), colorbar;
    F(S) = getframe;
    U = U + dU*dt;
end

movie(F)