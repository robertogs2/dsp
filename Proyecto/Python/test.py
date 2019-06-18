a = [0,1,1,1,0,1,1,1,0,1,1,1,0]

delta = 0
on = False
prev = 0;
for i in a[1:]:
	print(abs(prev-i))
	delta += abs(prev-i)
	prev = i
	

print(delta/2)