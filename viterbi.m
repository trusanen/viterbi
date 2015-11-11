function [path,V,Bs] = viterbi(T,Q,p,y)
%VITERBI - An implementation of the Viterbi algorithm to find the most
%likely hidden states of a Hidden Markov Model.
%   T is the state transition matrix
%   Q is the observation probability matrix
%   p is a vector containing priors
%   y is a vector containing the observations
%
% The algorithm assumes, that if there are N observations, Ns states and 
% Ny actions, then the length of y is N, the length of p is Ns, T is a 
% Ns x Ns matrix and Q is a Ny x Ns matrix.
%
% Topias Rusanen, Nov 2015
% topias.rusanen@helsinki.fi

% Obtain the number of observations, number of states and number of unique 
% actions from the observation and prior vectors.
N = length(y);
Ns = length(p);
Ny = length(unique(y));

% Check assumptions
if(~isrow(y) && ~isrow(y'))
    error('Invalid observation vector!')
elseif(~isrow(p) && ~isrow(p'))
    error('Invalid prior vector!')
elseif(size(T) ~= [Ns Ns])
    error('Invalid transition matrix T!')
elseif(size(Q) ~= [Ny Ns])
    error('Invalid observation probability matrix Q!')
end

% Initialize the matrices V and Bs. V holds the cumulative probability
% sum and Bs the most likely paths on every iteration
V = zeros(N, Ns);
Bs = zeros(N, Ns);

% Calculate the initial probabilites using the priors
for iii = 1:Ns
    V(1,iii) = log(p(iii)) + log(Q(y(1),iii));
    Bs(1,iii) = iii;
end

% Find most probable state transitions, first loop over all observations
for ttt = 2:N
    % Loop over all current states
    for iii = 1:Ns
        Pmax = -Inf;
        % Loop over all previous states and calculate the cost inflicted 
        % from moving from state jjj to iii and producing the correct 
        % observation
        for jjj = 1:Ns
            prob = V(ttt-1, jjj) + log(T(iii,jjj)) + log(Q(y(ttt),iii));
            % Store the state with largest probability
            if(prob > Pmax)
                Pmax = prob;
                Smax = jjj;
            end
        end
        % Record the cumulated probabilities for each state and the most
        % likely previous state
        V(ttt,iii) = Pmax;
        Bs(ttt,iii) = Smax;
    end
end

% Final state of the most probable path
[M,I] = max(V(N,:));
path(N) = I;

% Backtrack to find most probable path
for ttt = N-1:-1:1
    path(ttt) = Bs(ttt+1, path(ttt+1));
end

end

