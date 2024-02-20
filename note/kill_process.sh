# grep PID of KEYWORD from scratch
kill $(ps | grep heaterCtl.sh | head -1 | cut -c 1-6)

# pgrep PID of KEYWORD
kill `pgrep -f heaterCtl.sh`

# awk PID of KEYWORD
# Note the [] around the first letter of the keyword. That's a useful trick to avoid matching the awk command itself.
kill $(ps | awk '/[h]eaterCtl.sh/{print $1}')

# pidof to get PID of KEYWORD
pidof KEYWORD

# pkill to kill by process name
pkill KEYWORD
