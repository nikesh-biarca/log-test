#!/bin/bash -xe
#
# Script to reproduce devstack-gate run.
#
# Prerequisites:
# - Fresh install of Ubuntu Trusty, with basic internet access
# - Must have python-dev, build-essential, and git installed from apt
# - Must have virtualenv installed from pip
# - Must be run as root
#

exec 0</dev/null

declare -x DEVSTACK_GATE_TEMPEST_ALL="0"
declare -x DEVSTACK_GATE_TEMPEST_FULL="0"
declare -x DEVSTACK_GATE_TEMPEST_ALL_PLUGINS="0"
declare -x ZUUL_PROJECT="openstack-dev/ci-sandbox"
declare -x DEVSTACK_GATE_IRONIC_BUILD_RAMDISK="1"
declare -x DEVSTACK_GATE_SAHARA="0"
declare -x DEVSTACK_GATE_TEMPEST_NOTESTS="0"
declare -x DEVSTACK_CINDER_SECURE_DELETE="0"
declare -x DEVSTACK_GATE_SMOKE_SERIAL="0"
declare -x DEVSTACK_PROJECT_FROM_GIT=""
declare -x DEVSTACK_GATE_IRONIC_DRIVER="pxe_ssh"
declare -x OVERRIDE_ZUUL_BRANCH="master"
declare -x ZUUL_BRANCH="master"
declare -x ZUUL_VOTING="1"
declare -x ZUUL_URL="http://jenkinsci/p/"
declare -x DEVSTACK_GATE_PROJECTS_OVERRIDE=""
declare -x DEVSTACK_CINDER_VOLUME_CLEAR="none"
declare -x DEVSTACK_GATE_FEATURE_MATRIX="features.yaml"
declare -x DEVSTACK_GATE_TEMPEST="1"
declare -x DEVSTACK_GATE_UNSTACK="0"
declare -x ZUUL_CHANGE="335024"
declare -x DEVSTACK_GATE_INSTALL_TESTONLY="0"
declare -x DEVSTACK_GATE_TOPOLOGY="aio"
declare -x DEVSTACK_GATE_PUBLIC_NETWORK_GATEWAY="192.168.6.1"
declare -x DEVSTACK_GATE_NETCONSOLE=""
declare -x DEVSTACK_GATE_NOVA_API_METADATA_SPLIT="0"
declare -x DEVSTACK_GATE_NEUTRON_DVR="0"
declare -x DEVSTACK_GATE_TIMEOUT="110"
declare -x DEVSTACK_GATE_REMOVE_STACK_SUDO="1"
declare -x DEVSTACK_GATE_CELLS="0"
declare -x DEVSTACK_GATE_MQ_DRIVER="rabbitmq"
declare -x DEVSTACK_GATE_TEMPEST_HEAT_SLOW="0"
declare -x DEVSTACK_GATE_IRONIC="0"
declare -x DEVSTACK_GATE_FLOATING_RANGE="192.168.6.144/29"
declare -x DEVSTACK_GATE_CLEAN_LOGS="1"
declare -x DEVSTACK_GATE_TEMPEST_DISABLE_TENANT_ISOLATION="0"
declare -x DEVSTACK_GATE_CEILOMETER_BACKEND="mysql"
declare -x ZUUL_CHANGES="openstack-dev/ci-sandbox:master:refs/changes/24/335024/1"
declare -x DEVSTACK_GATE_EXERCISES="0"
declare -x DEVSTACK_GATE_VIRT_DRIVER="libvirt"
declare -x DEVSTACK_GATE_TROVE="0"
declare -x DEVSTACK_GATE_TEMPEST_LARGE_OPS="0"
declare -x DEVSTACK_GATE_ZEROMQ="0"
declare -x DEVSTACK_GATE_POSTGRES="0"
declare -x DEVSTACK_GATE_TIMEOUT_BUFFER="10"
declare -x ZUUL_REF="refs/zuul/master/Z3b10cc7141ed4cc6a509afacfa0b5bf9"
declare -x DEVSTACK_GATE_FIXED_RANGE="10.1.0.0/20"
declare -x ZUUL_CHANGE_IDS="335024,1"
declare -x DEVSTACK_GATE_LIBVIRT_TYPE="qemu"
declare -x DEVSTACK_GATE_TEMPEST_STRESS_ARGS=""
declare -x DEVSTACK_GATE_TEMPEST_STRESS="0"
declare -x DEVSTACK_GATE_GRENADE=""
declare -x DEVSTACK_GATE_TEMPEST_REGEX=^(?=""
declare -x DEVSTACK_GATE_NEUTRON="0"
declare -x DEVSTACK_GATE_CONFIGDRIVE="1"
declare -x ZUUL_PIPELINE="check"
declare -x ZUUL_COMMIT="7e610cb0dba13300417797f18d1c2981d2f9c1ee"
declare -x ZUUL_PATCHSET="1"
declare -x DEVSTACK_GATE_REQS_INTEGRATION="0"
declare -x ZUUL_UUID="4d89100f877e4b16b3ed30f6f3f9d0f1"

mkdir -p workspace/kaminario-dsvm-tempest-full-FC
cd workspace/kaminario-dsvm-tempest-full-FC
export WORKSPACE=`pwd`

if [[ ! -e /usr/zuul-env ]]; then
  virtualenv /usr/zuul-env
  /usr/zuul-env/bin/pip install zuul
fi

cat > clonemap.yaml << IEOF
clonemap:
  - name: openstack-infra/devstack-gate
    dest: devstack-gate
IEOF

/usr/zuul-env/bin/zuul-cloner -m clonemap.yaml --cache-dir /opt/git git://git.openstack.org openstack-infra/devstack-gate

cp devstack-gate/devstack-vm-gate-wrap.sh ./safe-devstack-vm-gate-wrap.sh
./safe-devstack-vm-gate-wrap.sh

