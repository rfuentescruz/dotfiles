#!/bin/bash
#
# Low-Battery warning
#

BATTERY='/sys/class/power_supply/BAT0'

REM=`grep "POWER_SUPPLY_ENERGY_NOW" $BATTERY/uevent | awk -F= '{ print $2 }'`
FULL=`grep "POWER_SUPPLY_ENERGY_FULL_DESIGN" $BATTERY/uevent | awk -F= '{ print $2 }'`
STATUS=`grep "POWER_SUPPLY_STATUS" $BATTERY/uevent | awk -F= '{ print $2 }'`
PERCENT=`echo $(( $REM * 100 / $FULL ))`

if [ $STATUS != 'Charging' ] && [ $PERCENT -le "20" ]; then
    DISPLAY=:0.0 /usr/bin/notify-send -u critical -t 2000 "Low battery" "$PERCENT% remaining"
    /usr/bin/paplay /usr/share/sounds/ubuntu/notifications/Rhodes.ogg
fi

if [ $STATUS == 'Charging' ] && [ $PERCENT -ge "75" ]; then
    DISPLAY=:0.0 /usr/bin/notify-send -u normal -t 2000 "Charging OK" "Battery now at $PERCENT%"
    /usr/bin/paplay /usr/share/sounds/ubuntu/notifications/Rhodes.ogg
fi
