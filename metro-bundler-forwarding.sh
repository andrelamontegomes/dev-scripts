iex "netsh interface portproxy delete v4tov4 listenport=8081 listenaddress=127.0.0.1" | out-null;
$WSL_CLIENT = bash.exe -c "ifconfig eth0 | grep 'inet '";
$WSL_CLIENT -match '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}';
$WSL_CLIENT = $matches[0];
iex "netsh interface portproxy add v4tov4 listenport=8081 listenaddress=127.0.0.1 connectport=8081 connectaddress=$WSL_CLIENT"
