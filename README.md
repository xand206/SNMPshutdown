# SNMPshutdown

Esse script monitora via SNMP o nível de tensão na entrada do Nobreak e o tempo estimado do módulo de bateria.
Nobreak testado APC SMX3000LV + AP9630

O script pode ser configurado para executar no CRON com o intervalo de tempo desejado.

NBRK - Endereço IP da placa de gerência do Nobreak.

COMM - Community SNMP.

ACIN - Consulta SNMP referente a tensão de entrada no Nobreak.

TIME - Consulta SNMP referente ao tempo de operação estimado do banco de baterias.


O script faz duas comparações, caso as duas condições forem verdadeiras, o host inicia o desligamento.

Condições para desligamento
TIME for inferior a 30 Minutos.
ACIN for inferior a 50 Volts.
