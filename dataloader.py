from root_numpy import root2array, tree2array
import root_numpy
import numpy as np
import argparse

parser = argparse.ArgumentParser(description='Convert ".tree" file to compressed numpy ".npz"')
parser.add_argument('--path', metavar='p', type=str,
                    help='Path to ".tree" file')
parser.add_argument('--output', metavar='o', type=str,
                    help='Output name')

args = parser.parse_args()

filename = args.path
trees = root_numpy.list_trees(filename)

array = []

for i in range(len(trees)):
    array.append(root2array(filename, trees[i]))
    np.savez(args.output, array, allow_pickle=True)




