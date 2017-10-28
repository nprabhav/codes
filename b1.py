def isAttack(board,row,col):
	for i in range(row):
		if board[i][col]==1:
			return True
	
	i=row-1
	j=col-1
	while((i>=0)and(j>=0)):
		if board[i][j]==1:
			return True
		i=i-1
		j=j-1
	
	i=row-1
	j=col+1
	while((i>=0)and(j<8)):
		if board[i][j]==1:
			return True
		i=i-1
		j=j+1

	return False

def solve(board,row):
	i=0
	while(i<8):
		if(not isAttack(board,row,i)):
			board[row][i]=1
			if(row==7):
				return True
			else:
				if(solve(board,row+1)):
					return True
				else:
					board[row][i]=0
		i=i+1
	if(i==8):
		return False			
def printboard(board):
	for i in range(8):
		for j in range(8):
			print board[i][j],
		print
board=[[0 for x in range(8)]for x in range(8)]

z=input("Enter positon of Queen :")
board[0][z]=1
solve(board,1)
print
print "Queens Problem Solved ^_^ "
print
print "Board Configuration :"
printboard(board)






