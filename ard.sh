stty -F /dev/ttyACM0 9600 cs8 -cstopb
sleep 0.1
echo "z" > /dev/ttyACM0
sleep 0.3
gphoto2 --capture-image-and-download --filename 1.cr2

sleep 2

stty -F /dev/ttyACM0 9600 cs8 -cstopb
sleep 0.1
echo "g" > /dev/ttyACM0
sleep 0.3
gphoto2 --capture-image-and-download --filename 2.cr2

sleep 2

stty -F /dev/ttyACM0 9600 cs8 -cstopb
sleep 0.1
echo "g" > /dev/ttyACM0
sleep 0.3
gphoto2 --capture-image-and-download --filename 3.cr2

./dcraw -w -H 0 -q 3 1.cr2
./dcraw -w -H 0 -q 3 2.cr2
./dcraw -w -H 0 -q 3 3.cr2
./dcraw -w -H 0 -q 3 -4 -T 1.cr2
./dcraw -w -H 0 -q 3 -4 -T 2.cr2
./dcraw -w -H 0 -q 3 -4 -T 3.cr2

cd align
./align 1000 1000 2000 2000