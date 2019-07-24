dim fx$(255)
cls
shell "ls *.txt"
shell "ls *.tif"
shell "ls *.tiff"
input "TXT/TIF>",pdf$
rem shell "pdftoppm "+pdf$+" "+left$(pdf$,len(pdf$)-4)
print left$(pdf$,len(pdf$)-4)
shell "ls *.txt | grep txt > tmp.list"
open "tmp.list" for input as #1
c=0
do
c=c+1
if not (eof(1)) then input #1,ot$
rem shell "convert -compress none "+ot$+" "+left$(ot$,len(ot$)-4)+".tiff"
fx$(c)=left$(ot$,len(ot$)-4)+".txt"
loop until (eof(1))
close #1
rem shell "rm *.ppm"
shell "rm tmp.list"
shell "ls *.csv"
input "Send To Fax File>",fax$
input "From Fax>",fm$
rem for i=1 to c
rem f$=f$+" "+fx$(i)
rem next i
print "Sending, please any key to execute fax..."
sleep
open fax$ for input as #2
d=0
do
if not (eof(2)) then
input #2, fdx$
shell "efax -c 1,5,0,0,0,1,0,0 -d /dev/ttyS0 -l "+fm$+" -t " +fdx$+ " " +pdf$
tm=int(rnd*10)+15

d=d+1
color 14
print str$(d)+">sent to "+fdx$+" and waiting for "+str$(tm)+" seconds before next send."
sleep tm
color 7
end if
loop until (eof(2))
close #2
