#!/bin/bash
NOBREAKIP="172.16.10.20"                                #Endereço IP do Nobreak
COMMUNITY="public"                                      #Community SNMP do Nobreak
ACIN_OID="1.3.6.1.4.1.318.1.1.1.3.2.1.0"                #OID - AC na entrada
TIME_OID="1.3.6.1.4.1.318.1.1.1.2.2.3.0"                #OID - Tempo estimado em modo de Bateria
ACIN_LOW=70                                             #(Volt) Valor mínimo aceitável na entrada AC - Ver datasheet
TIME_LOW=180000                                         #(Centisegundo) Valor mínimo aceitável do tempo restante em modo de bateria
LOG="/var/log/snmpshutdown.log"                         #Arquivo de log
DATE=$(date '+%Y-%m-%d %H:%M:%S')                       #Padrão de Data

#INICIO
ACIN_READ=$(snmpget -v2c -c $COMMUNITY $NOBREAKIP $ACIN_OID | awk '{ print $4 }')               #Valor lido no SNMP
TIME_READ=$(snmpget -v2c -c $COMMUNITY $NOBREAKIP $TIME_OID | tr -d "()" | awk '{ print $4 }')  #Valor lido no SNMP

#LOG
echo $DATE "Input Voltage:" $ACIN_READ "Runtime Remaining:" $(bc <<< "$TIME_READ / 6000") "min"  >> $LOG

if [ -n "$ACIN_READ" ] && [ -n "$TIME_READ" ]                                   #Verifica se as variáveis são nulas 
then
        if [ $ACIN_READ -le $ACIN_LOW ]  && [ $TIME_READ -le $TIME_LOW ]        #Compara a leitura SNMP com os valores mínimos
        then
                echo "Iniciando desligamento por falta de energia" | wall
                shutdown -h +5
        fi
else
        echo "Erro de leitura SNMP" >> $LOG
fi
#FIM
