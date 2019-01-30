# mac-installer

## How to use
You can install repeatedly and configurate the $choice variable.
```bash
curl -sSL https://raw.githubusercontent.com/yangjunsss/mac-installer/master/install.sh | bash
```

## How to use with Proxy and self-certificate
```bash
curl -sSL --proxy-user USER[:PASSWORD] --proxy [PROTOCOL://]HOST[:PORT] --insecure https://raw.githubusercontent.com/yangjunsss/mac-installer/master/install.sh | bash -s -- --proxy-user USER[:PASSWORD] --proxy [PROTOCOL://]HOST[:PORT] --insecure
```