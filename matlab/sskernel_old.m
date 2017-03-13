function [optW, C, W] = sskernel(x,W,str)
% [optW, C, W] = sskernel(x,W,str)
%
% Function `sskernel' returns an optimal bandwidth (standard deviation) 
% of the Gauss density function used in kernel density estimation.
% Optimization principle is to minimize expected L2 loss function between 
% the kernel estimate and an unknown underlying density function. 
% An assumption made is merely that samples are drawn from the density
% independently each other.
%
% The optimal bandwidth is obtained as a minimizer of the formula, 
% sum_{i,j} \int k(x - x_i) k(x - x_j) dx  -  2 sum_{i~=j} k(x_i - x_j), 
% where k(x) is the kernel function. 
%
% For more information, visit 
% http://2000.jukuin.keio.ac.jp/shimazaki/res/kernel.html
%
% Original paper:
% Hideaki Shimazaki and Shigeru Shinomoto
% Kernel Bandwidth Optimization in Spike Rate Estimation 
% Journal of Computational Neuroscience 2010
% http://dx.doi.org/10.1007/s10827-009-0180-4
%
% Example usage:
% optW = sskernel(x); ksdensity(x,'width',optW); 
%
% Statistics Toolbox is required to execute ksdensity. 
% If it is not available, define the Gauss function as
% `Gauss = @(s,w) 1/sqrt(2*pi)/w*exp(-s.^2/2/w^2);'.
% Computing `mean( Gauss(x-s,optW) )' provides a kernel density estimate at s.
%
% Input argument
% x:    Sample data vector. 
% W (optinal): 
%       A vector of kernel bandwidths.
%       The optimal bandwidth is selected from the elements of W.  
%       Default value is W = logspace(log10(2*dx),log10((x_max - x_min)),50).
%       * Do not search bandwidths smaller than a sampling resolution of data.
% str (optional):	
%       String that specifies the kernel type.
%       This option is reserved for future extention.
%       Default str = 'Gauss'.
%
% Output argument
% optW: Optimal kernel bandwidth.
% W:    Kernel bandwidths examined. 
% C:    Cost functions of W.
%
% See also SSHIST
%
% Copyright (c) 2009 2010, Hideaki Shimazaki All rights reserved.
% http://2000.jukuin.keio.ac.jp/shimazaki

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters Settings
x = reshape(x,1,numel(x));

str = 'Gauss';

if nargin < 2
    x_min = min(x);
    x_max = max(x);

    buf = sort(abs(diff(sort(x))));
    dx = min(buf(logical(buf ~= 0)));
    Wmin = 2*dx; Wmax = 1*(x_max - x_min);
    W = logspace(log10(Wmin),log10(Wmax),50);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute a Cost Function
N_total = length(x);

tau = triu( ones(N_total,1)*x - x'*ones(1,N_total), 1);
idx = triu( ones(N_total,N_total), 1);
TAU = tau(logical(idx)) .^2;

C = zeros(1,length(W));

for k = 1: length(W)
	w = W(k);
	C(k) = N_total/w + 1/w*sum(sum(2*exp(-TAU/4/w/w) - 4*sqrt(2)*exp(-TAU/2/w/w) )); 
end

C = C/2/sqrt(pi);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Optimal Bin Size Selection
[optC,nC]=min(C); optW = W(nC);
