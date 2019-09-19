Master_Key = [-1, -1, 1, -1, -1, 0, -1, -1, -1, 0, 1, -1, 1, -1, 0, 0, -1, -1, -1, 1, 0, -1, -1, 0, 0, -1, 0, -1, 1, 1, 1, 0, 0, 0, 1, -1, 1, 0, 1, 0, 1, 1, 0, 1, -1, 1, 0, -1, 0, 1, 0, 1, -1, 1, 0, 1]
file = open("Keys.txt", "w")
for i in range(2**20):
    if i%1000000==0:
        print(i)
    tmp = list('{:0>20}'.format(format(i,"b")))
    done = 0
    mkey = [Master_Key[j] for j in range(56)]
    for j in range(56):
        if Master_Key[j]==-1:
            mkey[j] = int(tmp[done])
            done=done+1
    for zz in mkey:
        file.write(str(zz))
    file.write("\n")
file.close()