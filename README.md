# SNMPshutdown

Esse script foi desenvolvido para ser utilizado no Nobreak APC SMX3000LV com placa AP9630. A execução do script pode ser feita pelo CRON.


Pacote necessário CENTOS7:

net-snmp-utils


Lógica de funcionamento:

Esse script monitora o Nobreak via SNMP, caso o valor da AC lido via SNMP esteja abaixo do mínimo especificado e o tempo estimado de operação em modo de bateria lido via SNMP esteja abaixo do valor mínimo especificado, o servidor será desligado.


Variáveis que precisam ser ajustadas

NOBREAKIP		#Endereço IP do Nobreak

COMMUNITY		#Community SNMP do Nobreak

ACIN_OID		#OID - AC na entrada

TIME_OID		#OID - Tempo estimado em modo de Bateria

ACIN_LOW		#(Volt) Valor mínimo aceitável na entrada AC - Ver datasheet

TIME_LOW		#(Centisegundo) Valor mínimo aceitável do tempo restante em modo de bateria


Definindo as variáveis:

ACIN_LOW:

Recomendo que seja consultado o datasheet do Nobreak, o SMX3000LV informa que o menor valor aceitável na entrada AC é 70 volts.

SMX3000LV - ACIN_LOW=70


TIME_LOW:

TIME_LOW = [ TEMPO_DESLIGAMENTO x FS x 6000 ]

TEMPO_DESLIGAMENTO = Tempo em que o servidor ou VM leva para desligar. (Em minutos)

FS = Fator de segurança, precisa ser igual ou maior que 1.1 (FS => 1.1)

6000 = Conversão do tempo para centisegundo


Exemplo de TIME_LOW:

Considerando que o tempo médio para desligamento do servidor seja de 10 minutos com um fator de segurança de 20%:

TIME_LOW = [ 10 x 1.2 x 6000 ] 

TIME_LOW = 72000 centisegundos


Exemplo de configuração no CRON para execução a cada 5 minutos.

*/5 * * * * usuario /opt/SNMPshutdown/SNMPshutdown.sh
