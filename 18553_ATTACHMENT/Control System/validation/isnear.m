function equal = isnear(A, B, varargin)

if (length(varargin) >= 1)
    tolerance = varargin{1};
else
    equal = isequal(A, B);
    return
end

equal = true;
if (size(A) ~= size(B))
    equal = false;
else
    abs_diff = abs(A - B);
    if any(abs_diff(:) > tolerance)
        equal = false;
    end
end

end
