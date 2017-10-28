from collections import defaultdict

def readFile(fn):
 f = open(fn,"r")
 for line in f:
  line = line.strip().rstrip(",")
  record = frozenset(line.split(','))
  yield record

def returnItemSetTL(data_iter):
 _itemSet = set()
 TransactionList = []
 for record in data_iter:
  trans = frozenset(record)
  TransactionList.append(trans)
  for item in trans:
   _itemSet.add(frozenset([item]))
 return _itemSet,TransactionList  

def returnItemWithMinSupport(itemSet,TransactionList,ms,freqSet):
 localSet = defaultdict(int)
 _itemSet = set()
 for item in itemSet:
  for trans in TransactionList:
   if item.issubset(trans):
    localSet[item]+=1
    freqSet[item]+=1
 for item,count in localSet.items():
  support = float(count)/float(len(TransactionList))
  if support>=minSupport:
   _itemSet.add(item)
 return _itemSet     

def joinSet(itemSet,length):
 return set([i.union(j) for i in itemSet for j in itemSet if len(i.union(j))==length])

def getSupport(freqSet,item,TransactionList):
 return float(freqSet[item])/float(len(TransactionList))

def runApriori(data_iter,ms,mc):
 itemSet,TransactionList = returnItemSetTL(data_iter)

 freqSet = defaultdict(int)
 largeSet = {}
 oneCSet = returnItemWithMinSupport(itemSet,TransactionList,ms,freqSet)
 k=2
 currentLSet = oneCSet
 print "L1"
 print currentLSet
 while(currentLSet!=set([])):
  largeSet[k-1]=currentLSet
  currentLSet = joinSet(currentLSet,k)
  print "L",k
  print currentLSet
  currentCSet = returnItemWithMinSupport(currentLSet,TransactionList,ms,freqSet)
  currentLSet = currentCSet
  k+=1 
 items = []
 for key,value in largeSet.items():
  items.extend([(tuple(item),getSupport(freqSet,item,TransactionList)) for item in value])
 print items
 max_value = 0
 for item,support in sorted(items,key=lambda(item,support):support):
  if max_value<len(item):
   max_value=len(item)
 for item,support in sorted(items,key=lambda(item,support):support):
  if max_value==len(item):
    print item


if __name__=='__main__':
 inFile = readFile("dataset.csv")
 minSupport = 0.6
 minConfidence = 1
 runApriori(inFile,minSupport,minConfidence)

