clc
clear
format long
syms X Y;
f = X-Y+(2*X^2)+(2*X*Y)+Y^2;

% Initial Guess:
x(1) = 0;
y(1) = 0;
% Gradient Computation:
df_dx = diff(f, X);
df_dy = diff(f, Y);
g0 = [subs(df_dx,[X,Y], [x(1),y(1)]) subs(df_dy, [X,Y], [x(1),y(1)])];
d = -(g0); % Search Direction
for i = 1:5
I = [x(i),y(i)];
syms t
% z=I-(t*g0);%search direction
g = subs(f, [X,Y], [x(i)+d(1)*t,y(i)+t*d(2)]);
dg_dt = diff(g,t);
    t = solve(dg_dt, t);
x(i+1) = I(1)+t*d(1) % New x value
y(i+1) = I(2)+t*d(2) % New y value
g_o = [subs(df_dx,[X,Y], [x(i),y(i)]) subs(df_dy, [X,Y], [x(i),y(i)])];
    i = i+1;
    g_1 = [subs(df_dx,[X,Y], [x(i),y(i)]) subs(df_dy, [X,Y], [x(i),y(i)])]; % Updated Gradient
    d=-(g_1);
end
Iter = 1:i;
X_coordinate = x';
Y_coordinate = y';
Iterations = Iter';
T = table(Iterations,X_coordinate,Y_coordinate);
% Plots:
fcontour(f, 'Fill', 'On');
hold on;
plot(x,y,'*-r');
% Output:
fprintf('Initial Objective Function Value: %d\n\n',subs(f,[X,Y], [x(1),y(1)]));
fprintf('Number of Iterations for Convergence: %d\n\n', i);
fprintf('Point of Minima: [%d,%d]\n\n', x(i), y(i));
fprintf('Objective Function Minimum Value after Optimization: %d\n\n', subs(f,[X,Y], [x(i),y(i)]));
disp(T)