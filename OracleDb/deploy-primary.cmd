REM azure group create -n OracleDB -l "West US2"
azure group deployment create -f oracle.json -e oracle.primary-site.parameters.json OracleDB OracleDB