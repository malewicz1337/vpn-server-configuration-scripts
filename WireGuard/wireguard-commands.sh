#!/bin/bash

readonly CFOLDER=/etc/wireguard/clients
readonly THISFILE=$(basename $0)

# Check if "jq" command exists
if ! command -v jq &> /dev/null; then
    echo "jq is not installed. Please install it and try again."
    exit 1
fi

# Check if "curl" command exists
if ! command -v curl &> /dev/null; then
    echo "curl is not installed. Please install it and try again."
    exit 1
fi

# =================================================

main () {
  # Check for root privileges
  [[ $USER == root ]] || { echo "Root privileges required. Try: sudo $THISFILE"; return 1; }

  # Find Wireguard interface
  if=$(wg show interfaces)
  [[ $if =~ $'\n' ]] && { echo "WARNING: multiple Wireguard interfaces detected"; }
  read -r INTERFACE <<<$if; readonly INTERFACE
  echo "Using interface $INTERFACE"

  case $1 in
    a*)
      add_new_peer $2
      ;;
    s*)
      show_peer_conf $2
      ;;
    d*)
      delete_peer $2
      ;;
    l*)
      list_peers
      ;;
    *)
      usage
      ;;
  esac
}

# =================================================

usage () {
cat <<USAGE
$THISFILE [add|show <peer>|del <peer>|list]
a[dd]  : add a new peer
s[how] : show peer configuration
d[el]  : delete peer
l[ist] : list peers
<peer> is peer public key as shown by list command
USAGE
}

build_peer_list () {
  PEERLIST=':'$(wg show $INTERFACE peers | awk '{printf $1":"}')
}

check_peer_exists () {
  local pk=$1
  build_peer_list
  [[ $PEERLIST =~ ":${pk}:" ]] || { echo "Cannot find peer $pk"; return 1; }
}

show_peer_conf () {
  local pk=$1
  check_peer_exists $pk || return 1
  local clientfile="$CFOLDER/$user_id.conf"
  [[ -r $clientfile ]] || { echo "Cannot read $clientfile"; return 1; }
  qrencode -t ANSIUTF8 < $clientfile
  cat $clientfile
  echo -e "---------\n"
  wg show $INTERFACE | awk '$0=="peer: '${pk}'"{f=1; print; next} /^peer:/{f=0} f'
}

delete_peer () {
  local pk=$1
  check_peer_exists $pk || return 1
  wg set $INTERFACE peer $pk remove && {
    wg-quick save ${INTERFACE}
    # clientfile="$CFOLDER/$user_id.conf"
    # rm -f $clientfile
    echo "Removed peer $pk"
  } || { echo "Cannot remove peer $pk"; return 1; }
}

list_peers () {
  wg show $INTERFACE |\
    awk '/^peer:/{
            f=1
            print "# '$THISFILE' show '\''"$2"'\''"
            print "# '$THISFILE' del '\''"$2"'\''"
            print
            next
            }
          f'
}

add_new_peer () {
  local user_id=$1
  # Generate peer keys
  PRIVATE_KEY=$(wg genkey)
  PUBLIC_KEY=$(echo ${PRIVATE_KEY} | wg pubkey)
  PRESHARED_KEY=$(wg genpsk)

  # Read server key from interface
  SERVER_PUBLIC_KEY=$(wg show ${INTERFACE} public-key)

  local MASK="/24"
  
  
    # awk -F'/' '{split($1, ip, "."); print ip[1]"."ip[2]"."ip[3]"."1+ip[4]}' 

  # Get next free peer IP (This will break after x.x.x.255)
#  PEER_ADDRESS=$(wg show ${INTERFACE} allowed-ips |\
#    cut -f 2 |\
#    awk -F'[./]' '{print $1"."$2"."$3"."1+$4}' |\
#    sort -t '.' -k 1,1 -k 2,2 -k 3,3 -k 4,4 -n | tail -n1)${MASK}

   PEER_ADDRESS=$(wg show ${INTERFACE} allowed-ips |\
     cut -f 2 |\
     awk -F'[./]' '{print $1"."$2"."$3"."1+$4"/"$5}' |\
     sort -t '.' -k 1,1 -k 2,2 -k 3,3 -k 4,4 -n | tail -n1)

  # Try to guess nameserver
  NAMESERVER=$(ip -j addr show $INTERFACE | jq -r '.[0].addr_info[0].local')
  nslookup google.com $NAMESERVER > /dev/null || {
    NAMESERVER=$(nslookup bogusname | awk '/^Server:/{print $2}')
    [[ ! $NAMESERVER =~ ^127 ]] && nslookup google.com $NAMESERVER > /dev/null || NAMESERVER="8.8.8.8, 8.8.4.4"
  }
  echo "Guessed nameserver: $NAMESERVER"

  LISTENPORT=$(wg show ${INTERFACE} listen-port)
  ENDPOINT=$(curl -s ipinfo.io | jq -r '.ip')

  # Add peer
  wg set ${INTERFACE} peer ${PUBLIC_KEY} preshared-key <(echo ${PRESHARED_KEY}) allowed-ips ${PEER_ADDRESS} || {
    echo "Cannot add peer ${PEER_ADDRESS} with public key ${PUBLIC_KEY}"
    return 1
  }
  wg-quick save ${INTERFACE}

  # Generate peer config
  read -r -d$'\x04' CONFIG << END_OF_CONFIG
[Interface]
Address = ${PEER_ADDRESS}
PrivateKey = ${PRIVATE_KEY}
DNS = ${NAMESERVER}
[Peer]
PublicKey = ${SERVER_PUBLIC_KEY}
PresharedKey = ${PRESHARED_KEY}
AllowedIPs = 0.0.0.0/0, ::/0
Endpoint = ${ENDPOINT}:${LISTENPORT}
PersistentKeepalive = 25
END_OF_CONFIG

  # Save added peer config
  clientfile="$CFOLDER/$user_id.conf"
  mkdir -p $CFOLDER
  touch $clientfile
  chmod +r $clientfile
  echo "$CONFIG" >${clientfile}

  # Show added peer config
  show_peer_conf ${PUBLIC_KEY}
}

# =================================================

main "$@"
