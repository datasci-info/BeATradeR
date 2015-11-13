f = function(x,y) c(x,y)
f(1,2)
do.call(f,list(3,4))
do.call(f,list(y=3,x=4))

g = function(...) list(...)
g(a=1,b=10,c=31,12,321)
do.call(g, list(a=1,b=10,c=31,12,321))