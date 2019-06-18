import matplotlib.pyplot as plt
import csv

x = []
y = []

with open('../Data/out941.txt','r') as csvfile:
	i = 0;
	plots = csv.reader(csvfile)
	for row in plots:
		x.append(int(i))
		i+=1
		y.append(int(row[0]))
		if(i > 44100):
			break

plt.plot(x,y, label='Loaded from file!')
plt.xlabel('x')
plt.ylabel('y')
plt.title('Interesting Graph\nCheck it out')
plt.legend()
plt.show()