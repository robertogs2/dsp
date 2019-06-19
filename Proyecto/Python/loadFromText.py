import matplotlib.pyplot as plt
import csv
import numpy as np

def moving_average(a, n=3):
	ret = np.cumsum(a, dtype=float)
	ret[n:] = ret[n:] - ret[:-n]
	return ret[n-1:]/n

x = []
y = []

file1 = input('File name:')
file = '../Data/' + str(file1) + '.txt'
with open(file,'r') as csvfile:
	i = 0;
	plots = csv.reader(csvfile)
	for row in plots:
		x.append(10/441 * int(i))
		i+=1
		y.append(float(row[0])**2)
		if(i > 44100):
			break

y = moving_average(y, 1000)
y_max = max(y)
y = y/y_max
t = 0.7
"""count=0
for i in range(len(y)):
	if y[i] > t:
		y[i]=1
		count+=1
	else:
		y[i]=0

print(count)
"""
plt.plot(y, label=file1)
plt.xlabel('x')
plt.ylabel('y')
plt.title('Filter output')
plt.legend()
plt.show()