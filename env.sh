#!/usr/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
OFF='\033[0m'

clear
echo "Networking"
ifconfig -a|grep 'inet\|flags'
read -p "Servicable network interface [eth0]: " NIC
NIC=${NIC:-eth0}
ifconfig $NIC
if [ $? -ne 0 ]; then
 echo -e "${RED}$NIC not found, exiting${OFF}"
 exit 1
fi

clear
echo "Software (zip file) location"
read -p "Oracle Database zip file [/tmp/LINUX.X64_180000_db_home.zip]: " ORACLE_SW
ORACLE_SW=${ORACLE_SW:-/tmp/LINUX.X64_180000_db_home.zip}
if [ ! -f $ORACLE_SW ]; then
 echo -e "${RED}$ORACLE_SW not found, exiting${OFF}"
 exit 1
fi

clear
echo "Security"
read -p "Oracle account [oracle]: " O_USER
O_USER=${O_USER:-oracle}

read -p "Oracle account's password [oracle123]: " O_PASS
O_PASS=${O_PASS:-oracle123}

read -p "(DB) SYS password [SysPassword1]: " SYS_PASS
SYS_PASS=${SYS_PASS:-SysPassword1}

read -p "(DB) SYSTEM password [SysPassword1]: " SYSTEM_PASS
SYSTEM_PASS=${SYSTEM_PASS:-SysPassword1}

read -p "(DB) PDBADMIN password [PdbPassword1]: " PDBADMIN_PASS
PDBADMIN_PASS=${PDBADMIN_PASS:-PdbPassword1}

clear
echo "Installation location"
read -p "\$ORACLE_APP_ROOT (The root directory that will hold oracle database and oraInventory binaries) [/opt/app]: " ORACLE_APP_ROOT
ORACLE_APP_ROOT=${ORACLE_APP_ROOT:-/opt/app}

read -p "\$ORACLE_BASE (oracle database root directory) [\$ORACLE_APP_ROOT/oracle]: " ORACLE_BASE
ORACLE_BASE=${ORACLE_BASE:-\$ORACLE_APP_ROOT/oracle}

read -p "\$ORACLE_HOME (oracle database home directory) [\$ORACLE_BASE/product/18.0.0/dbhome_1]: " ORACLE_HOME
ORACLE_HOME=${ORACLE_HOME:-\$ORACLE_BASE/product/18.0.0/dbhome_1}

read -p "Oracle database files directory [/ora/db001]: " ORACLE_DB
ORACLE_DB=${ORACLE_DB:-/ora/db001}

read -p "Location of auto generated scripts during installation [/tmp]: " SCRIPT_DIR
SCRIPT_DIR=${SCRIPT_DIR:-/tmp}

read -p "Location of oratab [/etc/oratab]: " ORATAB
ORATAB=${ORATAB:-/etc/oratab}

clear
echo "Oracle Database"
read -p "\$ORACLE_SID - Database database name or container instance name for apex [cdb1]: " CDB
CDB=${CDB:-cdb1}

read -p "Database container name for apex [pdb1]: " PDB
PDB=${PDB:-pdb1}

echo "NIC=${NIC}
O_USER=${O_USER}
O_PASS=${O_PASS}
SYS_PASS=${SYS_PASS}
SYSTEM_PASS=${SYSTEM_PASS}
PDBADMIN_PASS=${PDBADMIN_PASS}
ORACLE_APP_ROOT=${ORACLE_APP_ROOT}
ORACLE_BASE=${ORACLE_BASE}
ORACLE_HOME=${ORACLE_HOME}
ORACLE_DB=${ORACLE_DB}
ORACLE_SW=${ORACLE_SW}
SCRIPT_DIR=${SCRIPT_DIR}
ORATAB=${ORATAB}
PDB=${PDB}
CDB=${CDB}" > `dirname $0`/env

if [ $? -eq 0 ]; then
 echo "**************************************************************"
 echo "*** env saved in `dirname $0`/env *"
 echo "**************************************************************"
else
 echo "`dirname $0`/env saved failed";
fi
