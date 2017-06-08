import sys, re, random


with open(sys.argv[1], 'r')  as f:
    for line in f:
        window = int(sys.argv[3])
        field = re.match('(\S+)\s+(\S+)\s+(\S+)', line)
        len = int(field.group(1))
        start = int(field.group(2))
        end = int(field.group(3))
        segs = int(len/window)
        percent = float(sys.argv[4])
        initPer = 1
        bestper = 0
        windowNum = 0
        windowStart = []
        windowRandom = None

        #keep number of segments that give length closest to percentage
        for i in range(segs):
            if abs(percent - ((i + 1)*float(window))/len) < initPer:
                initPer = abs(percent - ((i + 1)*float(window))/len)
                bestPer = ((i + 1)*float(window))/len
                windowNum = i + 1

        #define the beginning of each window
        for i in range(segs):
             windowStart.append(start + window*i)

        #randomly choosing the windows
        windowRandom = random.sample(windowStart, windowNum)
        windowRandom.sort()

        #building the hybrids
        startPos = 0
        windowSwitch = False
        anyWindowStart = 0
        with open(sys.argv[2], 'r')  as f:
            for line in f:
                #output header
                if re.match('##', line):
                    print(line.rstrip())
                elif re.match('#', line):
                    header = re.match('((\S+\s+){9})', line)
                    print(header.group(1), "Hybrid", sep = "")
                #output body
                else:
                    #initialize
                    field = re.match('(\S+\s+(\S+)\s+(\S+\s+){7})(\S+)\s+(\S+)', line)
                    if startPos == 0:
                        startPos = int(field.group(2))
                        anyWindowStart = startPos
                        if startPos in windowRandom:
                            windowSwitch = True
                            print(field.group(1), field.group(4), sep = "")
                        else:
                            print(field.group(1), field.group(5), sep = "")
                    #extend
                    else:
                        #within window
                        position = int(field.group(2))
                        if position < anyWindowStart + window:
                            if windowSwitch:
                                print(field.group(1), field.group(4), sep = "")
                            else:
                                print(field.group(1), field.group(5), sep = "")
                        #change to next window
                        elif position >= anyWindowStart + window:
                            anyWindowStart = anyWindowStart + window
                            if anyWindowStart in windowRandom:
                                windowSwitch = True
                                print(field.group(1), field.group(4), sep = "")
                            else:
                                windowSwitch = False
                                print(field.group(1), field.group(5), sep = "")
