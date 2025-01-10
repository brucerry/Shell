$srcArray = @(
    "C:\Users\user\Desktop\TFTP\*"
    "\\wsl.localhost\Ubuntu-24.04\home\bruce\share\ubt14.04"
    "\\wsl.localhost\Ubuntu-24.04\home\bruce\share\ubt16.04"
    "\\wsl.localhost\Ubuntu-24.04\home\bruce\share\ubt18.04"
    "\\wsl.localhost\Ubuntu-24.04\home\bruce\share\ubt22.04"
)
$dst = "my-destination-path"

foreach ($src in $srcArray)
{
    echo "#####################################"
    echo "Copy $src to $dst"
    echo "#####################################"
    echo ""

    $StartTime = $(get-date)
    cp -r -force -v $src $dst
    $elapsedTime = $(get-date) - $StartTime
    $totalTime = "{0:HH:mm:ss}" -f ([datetime]$elapsedTime.Ticks)

    echo ""
    echo "#####################################"
    echo "Total time spent: $totalTime"
    echo "Done"
    echo "#####################################"
    echo ""
}

pause
