stty -F /dev/ttyACM0 9600 cs8 -cstopb
sleep 0.1
echo "z" > /dev/ttyACM0
sleep 1
gphoto2 --capture-image-and-download --filename 1.cr2

sleep 3

stty -F /dev/ttyACM0 9600 cs8 -cstopb
sleep 0.1
echo "g" > /dev/ttyACM0
sleep 1
gphoto2 --capture-image-and-download --filename 2.cr2

sleep 3

stty -F /dev/ttyACM0 9600 cs8 -cstopb
sleep 0.1
echo "g" > /dev/ttyACM0
sleep 1
gphoto2 --capture-image-and-download --filename 3.cr2

cd mydepth/
./getdm
cd ..
mv dm.ppm matlab/data

./dcraw -w -H 0 -q 3 1.cr2
./dcraw -w -H 0 -q 3 2.cr2
./dcraw -w -H 0 -q 3 3.cr2
./dcraw -w -H 0 -q 3 -4 -T 1.cr2
./dcraw -w -H 0 -q 3 -4 -T 2.cr2
./dcraw -w -H 0 -q 3 -4 -T 3.cr2

cd align
./align 2301 943 2508 1151

cd ..

mv align/1.tiff matlab/data
mv align/2.tiff matlab/data
mv align/3.tiff matlab/data

rm 1.cr2
rm 2.cr2
rm 3.cr2
rm 1.ppm
rm 2.ppm
rm 3.ppm
rm 1.tiff
rm 2.tiff
rm 3.tiff 
