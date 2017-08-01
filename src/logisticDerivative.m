function g = logisticDerivative(z)

g = logisticFunction(z) .* (1 - logisticFunction(z));

end