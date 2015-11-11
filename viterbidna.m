function path = viterbidna(str)
% VITERBIDNA - This function calculates the most probable hidden sequence 
% of a simple DNA-encoding model using the Viterbi-algorithm. The function
% takes a DNA sequence as an input and returns a string representation of
% the most probable hidden sequence.
%
% Topias Rusanen, Nov 2015
% topias.rusanen@helsinki.fi

% Model parameters given in the task instructions. T is the transition
% matrix, Q is the observation probability matrix, p is the vector
% containing priors
p = [0.5 0.5]';

T = [
    0.5 0.4;
    0.5 0.6
    ];

Q = [
    0.2 0.3;
    0.3 0.2;
    0.3 0.2;
    0.2 0.3
    ];

% Parse the DNA string, also checks for errors in DNA sequence
dnavec = parsedna(str);

% Calculate the most probable path
path = viterbi(T, Q, p, dnavec);

% Parse the output, also check the state sequence
path = parsestates(path);
end
