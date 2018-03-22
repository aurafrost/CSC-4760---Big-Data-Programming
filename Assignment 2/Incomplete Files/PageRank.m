function PageRank

dbstop if error; clear; clc; close all;

dDecayFactor = 0.85;

mAdjacencyMatrix = [
0 1 0 0 0;
0 0 1 1 0;
0 0 0 1 0;
1 0 0 0 1;
0 0 1 0 0;
];
nNumOfNodes = size(mAdjacencyMatrix,1);
mIdentifyMatrix = eye(nNumOfNodes, nNumOfNodes);
vAllOneVector = ones(nNumOfNodes, 1);

% Change the adjacency matrix
% If one node has no outgoing edges, then add one edge from this node to
% any other nodes.
vNodeDegree_Raw = sum(mAdjacencyMatrix,2);
for nIdx = 1:nNumOfNodes
    if vNodeDegree_Raw(nIdx) == 0
        mAdjacencyMatrix(nIdx,:) = ones(1,nNumOfNodes);
    end
end

% Node degree matrix
vNodeDegree = sum(mAdjacencyMatrix,2);
mNodeDegreeMatrix = diag(vNodeDegree);
mNodeDegreeMatrixInv = pinv(mNodeDegreeMatrix);

% Compute the node transition probability matrix.
mNodeTransProbMatrixP = mNodeDegreeMatrixInv * mAdjacencyMatrix;

vPRVector = (1 - dDecayFactor) * inv(mIdentifyMatrix - dDecayFactor * mNodeTransProbMatrixP') * vAllOneVector / nNumOfNodes;

vIterationVector = vAllOneVector / nNumOfNodes;
for nIdx = 1:30
    vIterationVector = dDecayFactor * mNodeTransProbMatrixP' * vIterationVector + (1 - dDecayFactor) * vAllOneVector / nNumOfNodes;
end

sum(vIterationVector)
vIterationVector

figure;
end
