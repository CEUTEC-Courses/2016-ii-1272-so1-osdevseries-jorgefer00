#!/bin/bash

while true; do
dialog --title "OSDev Jorge Fernandez" \
--cancel-label "Salir" \
--menu "Por favor seleccione un tutorial a correr en BOCHS" 15 55 3 \
1 "Tutorial 3" \
2 "Tutorial 4" \
3 "Tutorial 6" 2>temporal

if [ "$?" = "0" ]
then
	seleccion=$(cat temporal)
	rm -rf temporal
	if [ $seleccion = "1" ]
	then
		cd tutorial3&&bochs -f bochsrc.txt
		cd ..
	fi
	if [ $seleccion = "2" ]
	then
		echo "Correr Tutorial 4"
	fi
	if [ $seleccion = "3" ]
	then
		echo "Correr Tutorial 6"
	fi
else
	rm -rf temporal
	clear
	break
fi
done
