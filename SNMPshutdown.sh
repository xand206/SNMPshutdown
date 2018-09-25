#!/bin/bash
NBRK="172.16.10.20"
COMM="public"
ACIN=$(snmpget -v2c -c $COMM $NBRK 1.3.6.1.4.1.318.1.1.1.3.2.1.0 | awk '{ print $4 }') # OID referente a tensão AC na entrada
TIME=$(snmpget -v2c -c $COMM $NBRK 1.3.6.1.4.1.318.1.1.1.2.2.3.0 | tr -d "()" | awk '{ print $4 }') # OID referente ao tempo restante em modo de bateria
if [ $ACIN -le 50 ]  && [ $TIME  -le 180000 ] 
then
	shutdown -h now
fi
unset ACIN
unset TIME
unset NBRK
unset COMM
