function W = randomWeights(input_dim, output_dim)

epsilon_init = 0.12;
W = rand(output_dim, 1 + input_dim) * 2 * epsilon_init - epsilon_init;

end
