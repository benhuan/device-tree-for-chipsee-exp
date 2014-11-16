#!/bin/bash
dtb_file_path="/home/longqi/Dropbox/BBB/device-tree/LQ/am335x-boneblack.dtb"
dts_file_path="/home/longqi/Dropbox/BBB/device-tree/LQ/am335x-boneblack.dts"
target_board="root@192.168.7.2"
target_path="/boot/uboot/dtbs/"

echo "compile device tree "
dtc -@ -I dts -O dtb -o $dtb_file_path $dts_file_path
compile_res=$?
if [ $compile_res -eq 0 ]; then
  echo "compile sucess"
else 
  echo "compile failed !!!"
  exit
fi

echo "copying dtb file to target board"
scp $dtb_file_path $target_board:$target_path
copy_to_board_res=$?
if [ $copy_to_board_res -eq 0 ]; then
  echo "copy to board sucess"
else 
  echo "copy to board failed !!!"
  exit
fi

echo "rebooting target board"
ssh -t $target_board 'reboot'
