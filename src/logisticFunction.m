function f = logisticFunction(x)
%LOGISTICFUNCTION Compute the value of the logistic function of x,
%where x is a real number or a vector.

f = 1.0 ./ (1.0 + exp(-x));

end
