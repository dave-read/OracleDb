#!/bin/bash

SUBNET_NAME=GatewaySubnet
# First Vnet
RG1=vnet-westus
VNET1=vnet-primary
VNET1_PREFIX="10.1.2.0/24"
# Second Vnet
RG2=vnet-eastus
VNET2=vnet-dr
VNET2_PREFIX="10.2.2.0/24"
#
RG_GW=vnet-vpn-gateways
RG_GW_LOCATION=westus

set -x

#
# Check if Subnet Gateway already exists
# 
function gateway_subnet_exists() {
  local result=$(az network vnet subnet list --resource-group $1 --vnet-name $2  --query "[?name=='$SUBNET_NAME'].name | [0]")
  local rc=$?
  if [ $rc -ne 0 ];then
    echo "Command return error rc was $rc results was $result"
    return -1
  elif [ "$result"="$SUBNET_NAME" ];then
     #Subnet does exist
     return 1
  else
     #Subnet does not exists
     return 0
  fi
}
function ensure_resource_group() {

}

#------------------------------------------------------------------------
# main
#------------------------------------------------------------------------
#echo "creating resource group $RG_GW in location $RG_GW_LOCATION ..."
#az group create --location $RG_GW_LOCATION --name $RG_GW
#rg_create_rc=$?
#echo "creating resource group result $rg_create_rc" 

subnet_exists $RG1 $VNET1
subnet_exists_rc=$?
echo "subnet_exists_rc $subnet_exists_rc"
if [ $subnet_exists_rc -eq 0 ];then
  echo "creating subnet $SUBNET_NAME with prefix $VNET1_PREFIX in resource goup $GR1 vnet $VNET1"
  az network vnet subnet create --address-prefix $VNET1_PREFIX --name $SUBNET_NAME --resource-group $RG1 --vnet-name $VNET1
elif [ $subnet_exists_rc -eq 1 ];then
  echo "subnet $SUBNET_NAME already exists in resource goup $RG1 vnet $VNET1"
else
  echo "error checking subnet $SUBNET_NAME in resource goup $RG1 vnet $VNET1"
  exit
fi

subnet_exists $RG2 $VNET2
subnet_exists_rc=$?
echo "subnet_exists_rc $subnet_exists_rc"
if [ $subnet_exists_rc -eq 0 ];then
  echo "creating subnet $SUBNET_NAME with prefix $VNET2_PREFIX in resource goup $RG2 vnet $VNET2"
  az network vnet subnet create --address-prefix $VNET2_PREFIX --name $SUBNET_NAME --resource-group $RG2 --vnet-name $VNET2
elif [ $subnet_exists_rc -eq 1 ];then
  echo "subnet $SUBNET_NAME already exists in resource goup $RG2 vnet $VNET2"
else
  echo "error checking subnet $SUBNET_NAME in resource goup $RG2 vnet $VNET2"
  exit
fi


