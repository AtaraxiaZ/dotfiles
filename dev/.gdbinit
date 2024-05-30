# Prettier
set print null-stop on
set print pretty on
set print array on

# For xv6
set auto-load safe-path
add-auto-load-safe-path /home/zhe/Documents/courses/MIT6.1810-OS/xv6-labs-2023/.gdbinit

# call the refresh command each time you enter next command
define hook-next
    refresh
end
