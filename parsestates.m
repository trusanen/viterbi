function statevec = parsestates(vec)
% PARSESTATES - This function parses a numerical vector of Hidden Markov 
% Model states and assigns a letter H or L to each state.
%   1 = "H"
%   2 = "L"
%
% Topias Rusanen, Nov 2015,
% topias.rusanen@helsinki.fi

% Initialize the state vector
statevec = zeros(size(vec));

% Initialize the map {1, 2} -> {H, L}
map = containers.Map([1,2], {'H','L'});

% Loop over every numerical state in vec and assign correct values in the 
% state vector.
for iii=1:length(vec)
    try
        statevec(iii) = map(vec(iii));
    catch
        error(['Invalid state sequence! The integer at index ' int2str(iii) ' is not one of the following: 1, 2.'])
    end
end

% Change the statevec into a string
statevec = char(statevec);

end