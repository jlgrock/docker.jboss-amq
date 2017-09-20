Due to desired hardening of images, it is suggested, even in containers, not to have clear text passwords.  To accomidate this, we are using multiple hardening techniques.

AMQ Hardening instructions are from the following location:
https://access.redhat.com/documentation/en-US/Red_Hat_JBoss_A-MQ/6.2/pdf/Security_Guide/Red_Hat_JBoss_A-MQ-6.2-Security_Guide-en-US.pdf

# Encrypting Properties in your user.properties file
This uses the base class Strong (SHA-256) encryption, so it is similar to encrypting the properties in your application, but uses the org.jasypt.util.password.StrongPasswordEncryptor class.

```
JBossA-MQ:admin@root> la -l | grep -i org.apache.karaf.shell.commands
[  23] [Active     ] [Created     ] [       ] [   30] mvn:org.apache.karaf.shell/org.apache.karaf.shell.commands/2.4.0.redhat-620133

JBossA-MQ:admin@root> dynamic-import 25
Enabling dynamic imports on bundle org.apache.karaf.shell.commands [25]

JBossA-MQ:admin@root> e = (new org.jasypt.util.password.StrongPasswordEncryptor)
org.jasypt.util.password.StrongPasswordEncryptor@eea625e

JBossA-MQ:admin@root> $e setpassword "MasterPass"

JBossA-MQ:admin@root> h1 = ($e encryptPassword "admin")
2b4hCTZrQ7/9OoN0jvjPhQ==

JBossA-MQ:admin@root> dynamic-import 23
Disabling dynamic imports on bundle org.apache.karaf.shell.commands [23]
```

# Encrypting Properties in your Application 

run the command
`$JBOSS_HOME/bin/client`

Then, when the AMQ CLI starts up, run the following:

```
JBossA-MQ:admin@root> la -l | grep -i org.apache.karaf.shell.commands
[  23] [Active     ] [Created     ] [       ] [   30] mvn:org.apache.karaf.shell/org.apache.karaf.shell.commands/2.4.0.redhat-620133

JBossA-MQ:admin@root> dynamic-import 25
Enabling dynamic imports on bundle org.apache.karaf.shell.commands [25]

JBossA-MQ:admin@root> e = (new org.jasypt.encryption.pbe.StandardPBEStringEncryptor)
org.jasypt.encryption.pbe.StandardPBEStringEncryptor@eea665e

JBossA-MQ:admin@root> $e setpassword "MasterPass"

# Note, this can be any algorithm, we are using
JBossA-MQ:admin@root> $e setAlgorithm PBEWITHHMACSHA224ANDAES_256

JBossA-MQ:admin@root> h1 = ($e encrypt "admin")
XeyZrLKonkcf7svTi5xRC+1ppCcLJUu+34fOZIcCoaY=

JBossA-MQ:admin@root> $e decrypt $h1
admin

JBossA-MQ:admin@root> dynamic-import 23
Disabling dynamic imports on bundle org.apache.karaf.shell.commands [23]
```

