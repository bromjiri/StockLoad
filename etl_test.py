import glob

def fileNameIndex(pathFileMask='', iStartEnd=[]):
    o = []
    for f in glob.glob(pathFileMask):
        print(f)
        fn = f.split('\x5C')[-1] #file name
        print(fn)
        o.append(fn[iStartEnd[0]:iStartEnd[1]])
    print(o)
    return sorted(o)[-1]


dt = fileNameIndex(r'etlt030_sftp217_Feedo_ExportData/20*T*.dat', [0,8])
print(dt)