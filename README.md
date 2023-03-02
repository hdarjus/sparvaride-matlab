# Software package `sparvaride-matlab`

Matlab implementation of the main algorithm of the R package [`sparvaride`](hdarjus.github.io/sparvaride/) plus two utilitites for the generalized lower triangular (GLT) framework in our [working paper](https://arxiv.org/abs/2301.06354) by Sylvia Frühwirth-Schnatter, Darjus Hosszejni, and Hedibert Freitas Lopes.

The R package `sparvaride` implements the variance identification algorithm for sparse
factor analysis described in the paper "Cover It Up\! Bipartite Graphs
Uncover Identifiability in Sparse Factor Analysis" by Darjus Hosszejni
and Sylvia Frühwirth-Schnatter. The paper is available at
[arXiv](https://arxiv.org/abs/2211.00671).

## Functionality

There are three functions and two further Matlab files in this repository.

- `to_glt` rotates the input into GLT representation
  - a Matlab-default numeric tolerance is applied
  - this function is for *continuous* factor loadings matrices
  - the transpose of the factor loadings matrix is the input
  - further info in Section 3.3 of our [working paper](https://arxiv.org/abs/2301.06354.pdf)
- `is_identified_indicator` verifies the counting rule for the *sparsity pattern* of a factor loadings matrix
  - there is no numeric error involved in this algorithm
  - the sparsity pattern of the transpose of the factor loadings matrix is the input
  - further info in our [working paper](https://arxiv.org/abs/2211.00671), which is about what this algorithm is and why it works
- `is_identified` is the sequence of `to_glt` and `is_identified_indicator` on the sparsity pattern of the resulting GLT structure

## How to use

You need to have Matlab on your computer first.
Then, you have to download the `.m` files of this repository onto your computer and put them into your Matlab's working directory.
See `tests.m` in this repository for code examples.
Execute `run_tests.m` to run the unit tests.
