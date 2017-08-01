function d = logisticDerivative(x)
%LOGISTICDERIVATIVE Compute the derivative of the logistic function at
%location x, where x is a real number or a vector.

d = logisticFunction(x) .* (1 - logisticFunction(x));

end