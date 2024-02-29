import numpy as np

def mkdir(path):
    import os
    path=path.strip()
    path=path.rstrip("\\")
    isExists=os.path.exists(path)
    if not isExists:
        os.makedirs(path) 
        return True
    else:
        return False

def write_dict(dir_name, index, val):
    f2 = open(dir_name,'a')
    f2.write(str(index) + '\t' + str(val) + '\n')
    f2.close()
    
    
def write_XYseq(dir_name, name, Xseq, Yseq):
    f2 = open(dir_name + '\\' + name + '.txt','w')
    for i in range(Xseq.shape[0]-1,-1,-1):
        f2.write(str(Xseq[i]) + ' ')
    f2.write('\n')
    for i in range(Yseq.shape[0]-1,-1,-1):
        f2.write(str(Yseq[i]) + ' ')
    f2.close()


def write_matrix3(dir_name, name, martix):
    f2 = open(dir_name + '\\' + name + '.txt','w')
    for i in range(martix.shape[0]):
        for j in range(martix.shape[1]):
            for k in range(martix.shape[2]):
                f2.write(str(martix[i,j,k])+' ')
            f2.write('\n')
    f2.close()


def write_Xseq(dir_name, name, Xseq, direct):
    f2 = open(dir_name + '\\' + name + '.txt','w')
    if direct=='col':
        for i in range(Xseq.shape[0]):
            f2.write(str(Xseq[i]) + '\n')
    elif direct=='row':
        for i in range(Xseq.shape[0]):
            f2.write(str(Xseq[i]) + ' ')   
    f2.close()
def write_nodes(dir_name, name, nodes):
    f2 = open(dir_name + '\\' + name + '.txt','w')
    for i in range(nodes.shape[0]):
        for j in range(nodes.shape[1]):
            f2.write(str(nodes[i,j])+' ')
        f2.write('\n')
    f2.close()
    
    
def write_NodesSet(dir_name, name, nodes_set):
    f2 = open(dir_name + '\\' + name + '.txt','w')
    for i in range(len(nodes_set)):
        if np.any(nodes_set[i])==0:
            continue
        f2.write(str(nodes_set[i][0])+' ')
        f2.write(str(nodes_set[i][1])+' ')
        f2.write(str(nodes_set[i][2]))
        f2.write('\n')
    f2.close()