#character n-gram random text!
function mcsample(b)
       k = sum(values(b))
       n = rand(1:k)
       a = copy(b)
       while(n >= a[argmin(a)])
       a[argmin(a)] += k
       end
       return argmin(a)
end

text = read("/Users/Suibeom/Downloads/model-zoo-master/text/char-rnn/storyo.txt")
text = String(text)
text = replace(text,r"\n"=>"")
n=6
subs = [text[k:k+n] for k in 1:length(text)-n]
ngrams = Dict()

for i in subs
#This line tries to do two steps in one; first get the dictionary for
#the subword i[1:n-1]. If there's no dictionary for that subword yet,
#then store one! Then get that dictionary you just stored and
#put '1' in it.
get!(ngrams, i[1:n-1], Dict())[i[n]]=get(get(ngrams,i[1:n-1],Dict()),i[n],0)+1

end

starts = [i[1:n-1] for i in filter(x->x[1:2]==". ", subs)]
a = rand(starts)
s = a
t = a
for i in 1:1000
       global t = t*mcsample(ngrams[t])
       global s = s*t[n]
       t = t[2:n]

end
println(s)
