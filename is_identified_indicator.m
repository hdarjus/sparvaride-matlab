function identified=is_identified_indicator(delta)
%% Turn adjacency matrix to directed graph
n_factors=size(delta,1);
n_observations=size(delta,2);
n_bipartite_edges=sum(delta,'all');
% start node is at index 1
% then the nodes for the factors
% then the nodes for the observations
% finally the sink/target node
s=zeros(1,n_factors + n_bipartite_edges + n_observations);  % start of edges
t=zeros(size(s));  % targets of edges
w=zeros(size(s));  % weight of edges
% edges from the start node to the factor nodes
s(1:n_factors)=1;
t(1:n_factors)=1+(1:n_factors);
w(1:n_factors)=2*n_factors+1;
% edges between factors and observations
edge_positions=find(delta);
s(1+n_factors:n_bipartite_edges+n_factors)=...
    mod(edge_positions-1,n_factors)+2;
t(1+n_factors:n_bipartite_edges+n_factors)=...
    fix((edge_positions-1)/n_factors)+2+n_factors;
w(1+n_factors:n_bipartite_edges+n_factors)=intmax;
% edges between observations and the sink/target node
s(1+n_bipartite_edges+n_factors:size(s,2))=...
    1+n_factors+(1:n_observations);
t(1+n_bipartite_edges+n_factors:size(t,2))=...
    2+n_factors+n_observations;
w(1+n_bipartite_edges+n_factors:size(w,2))=n_factors;
% create graph
network=digraph(s,t,w);
% to plot this network, execute
%plot(network,'EdgeLabel',network.Edges.Weight,'Layout','layered');

%% Run max-flow--min-cut algorithm
mf=maxflow(network,1,2+n_factors+n_observations);
identified=mf==n_factors*(2*n_factors+1);
end