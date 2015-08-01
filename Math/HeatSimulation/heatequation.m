N = 300;

U = zeros(N, N);
dU = zeros(N, N);

h = 1/N;
h2 = h.^2;
dt = .0003;
a = 1/5;

for i=1:N
    for j=1:N
        U(i,j) = 1000*(1/(1+a*((N/4-i)^2+(N/4-j)^2)) + ...
            1/(1+a*((3*N/4-i)^2+(3*N/4-j)^2)));
    end
end

U(:, 1) = 0;
U(:, end) = 0;
U(1, :) = 0;
U(end, :) = 0;

loops = 10000;

writerObj = VideoWriter('final.avi');
open(writerObj);

clear F;
F(loops) = struct('cdata',[],'colormap',[]);

for S=1:loops
    for i=2:N-1
        for j=2:N-1
            dU(i,j) = 2*(U(i+1, j) + U(i-1, j) + U(i, j+1) + U(i, j-1) ...
                - 4*U(i, j))/h;
        end
    end
    imagesc(U, [0, 10]), colorbar;
    F(S) = getframe;
    writeVideo(writerObj, getframe);
    U = U + dU*dt;
    disp(S)
end

close(writerObj);