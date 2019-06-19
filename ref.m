%% ref.m -- an executable m-file for solving a boundary-value problem
% Automatically created in CHEBGUI by user pmzmi1.
% Created on June 18, 2019 at 13:38.

%% Problem description.
% Solving
%   0.01*u'' = sin(pi*x),
% for x in [0, 1], subject to
%   u(0) = 0,
%   u(1)  = 1.

%% Problem set-up.
% Define the domain.
dom = [0, 1];

% Assign the differential equation to a chebop on that domain.
N = chebop(@(x,u) diff(u,2), dom);

x = chebfun('x',dom);
% Set up the rhs of the differential equation so that N(u) = rhs.
rhs = 100*x*sin(pi.*x);

% Assign boundary conditions to the chebop.
N.bc = @(x,u) [u(0); u(1)-1];

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
%u = solvebvp(N, rhs, options);
uref = N\rhs;

%% Plot the solution.
figure(1)
plot(u, 'LineWidth', 2)
title('Final solution'), xlabel('x'), ylabel('u')