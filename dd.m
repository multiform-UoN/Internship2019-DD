%% ref.m -- an executable m-file for solving a boundary-value problem
% Automatically created in CHEBGUI by user pmzmi1.
% Created on June 18, 2019 at 13:38.

%% Problem description.
% Solving
%   0.01*u'' = sin(pi*x),
% for x in [0, 1], subject to
%   u(0) = 0,
%   u(1)  = 1.


ref

%% Problem set-up.
% Define the domain.
dom = [0, 2];
x = chebfun('x',dom);

%% Parameters
eps = 0.01;
dir1 = 1;
phi = (1-tanh(3*(x-1)/eps))/2;


%% ODE
% Assign the differential equation to a chebop on that domain.
N = chebop( @(x,u) diff(phi*diff(u)) - eps^-3 * (1-phi)*(u-dir1) , dom);

% Set up the rhs of the differential equation so that N(u) = rhs.
rhs = phi*100*x*sin(pi.*x);

% Assign boundary conditions to the chebop.
N.bc = @(x,u) [u(0); feval(diff(u),2)];

%% Setup preferences for solving the problem.
% Create a CHEBOPPREF object for passing preferences.
% (See 'help cheboppref' for more possible options.)
options = cheboppref();

% Print information to the command window while solving:
options.display = 'iter';

% Option for tolerance.
options.bvpTol = 5e-13;

% Option for damping.
options.damping = false;

% Specify the discretization to use. Possible options are:
%  'values' (default)
%  'coeffs'
%  A function handle (see 'help cheboppref' for details).
options.discretization = 'values';

% Option for determining how long each Newton step is shown.
options.plotting = 0.1;

%% Solve!
% Call solvebvp to solve the problem.
% (With the default options, this is equivalent to u = N\rhs.)
u = solvebvp(N, rhs, options);
%u = N\rhs;

%% Plot the solution.
figure(1)
plot(u, 'LineWidth', 2)
title('Final solution'), xlabel('x'), ylabel('u')

%% Errors
uu = chebfun(u, [0,1])
norm(uu - uref)/norm(uref)

m = length(u);


