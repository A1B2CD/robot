function out = transformationMatrix(R,p)
out     = [R, p;
         [0 0 0 1]];
end