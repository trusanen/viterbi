function dnavec = parsedna(str)
% PARSEDNA - This function parses a string of DNA and returns an integer 
% representation of it, where
%   "A" = 1
%   "C" = 2
%   "G" = 3
%   "T" = 4
%
% Topias Rusanen, Nov 2015,
% topias.rusanen@helsinki.fi

% Make the string uppercase
str = upper(str);

% Initialize the DNA vector
dnavec = zeros(size(str));

% Initialize the map {A, C, G, T} -> {1, 2, 3, 4}
map = containers.Map({'A','C','G','T'},[1,2,3,4]);

% Loop over every letter in string str and assign correct values in the DNA
% vector.
for iii=1:length(str)
    try
        dnavec(iii) = map(str(iii));
    catch
        error(['Invalid DNA sequence! The letter at index ' int2str(iii) ' is not one of the following: A, C, G, T.'])
    end
end

end