function [C] = matrix_align_and_glue(A,B)
%This function take matrix A and B, remove overlap, and return as one
%matrix


% Find offset
k2=0;
diff1 = 1;

% Drop the right side in the interval
for k=1:length(A),
    diff2 = abs(A(k,1)-B(1,1));
    if diff2<diff1
        diff1=diff2;
        k2=k;
    end
end
C = zeros([(k2+length(B)) 2]);


% Append arrays into k3
for k3=1:k2,
    C(k3,1) = A(k3,1);
    C(k3,2) = A(k3,2);
end

% Add offset
for k4=1:length(B),
    C(k2+k4,1) = B(k4,1);
    C(k2+k4,2) = B(k4,2);
end

end


function [C] = array_append(A,B) %Combines matrixes

C = zeros([(length(A)+length(B)) 2]);
% Append arrays into k3
for i=1:length(A),
    C(i,1) = A(i,1);
    C(i,2) = A(i,2);
end

end