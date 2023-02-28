# Secret key configuration

Setup a secret key for this instance: 

!!! Example ""

      ```bash
      cat > /etc/cortex/secret.conf << _EOF_
      play.http.secret.key="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n 1)"
      _EOF_
      ```

      Then, in the file `/etc/cortex/application.conf`, replace the line including `play.http.secret.key=` by:

      ```yaml title="/etc/cortex/application.conf"
      [..]
      include "/etc/cortex/secret.conf"
      [..]
      ```

