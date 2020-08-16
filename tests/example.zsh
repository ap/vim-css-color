# XXX  #0f0 should show up green
# XXX   f00 should not show up red
# FIXME ff0 should show up yellow but are known not to

echo '#0f0'
echo ##0f0
echo \#ff0
echo #f00
echo ##0f0
echo # #0f0
cmd '#0f0'
cmd "#0f0"
cmd \#ff0
cmd #f00
cmd ##0f0
cmd # #0f0
#f00
##0f0 XXX
# #0f0 XXX
# XXX #0f0 XXX
cat << ''
#0f0

