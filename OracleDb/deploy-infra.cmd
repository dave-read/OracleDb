call azure group create -n Oracle-12c-infra -l northcentralus
call azure group deployment create -f oracle-infra.json -e oracle-infra.parameters.json Oracle-12c-infra Oracle-12c-infra