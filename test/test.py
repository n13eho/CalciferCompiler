import os
path = os.getcwd()
pathin  =os.path.join(path,"testsetin")
pathout =os.path.join(path,"testsetout")
testsetin = os.listdir(pathin)
testsetout = os.listdir(pathout)

if len(testsetin) != len(testsetout):
    print("You testset is not completely!")
else:
    for id in range(len(testsetin)):
        testin = testsetin[id]
        testout = testsetout[id]
        os.system("../src/calcifer " +os.path.join(pathin,testin))
        if os.system("diff "+ os.path.join(pathout,testout) + " ans.txt") :
            print("ERROR on"+ testin)
        else :
            print("PASS on"+ testin)    