# Wazuh notification gmail

## Gebruik dit command voor packages (klik op "no configurations")

```sh
apt-get update && apt-get install postfix mailutils libsasl2-2 ca-certificates libsasl2-modules
```

## Zet het volgende in de "/etc/postfix/main.cf", maak de file aan als die er niet is.

```sh
relayhost = [smtp.gmail.com]:587
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options = noanonymous
smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
smtp_use_tls = yes
smtpd_relay_restrictions = permit_mynetworks, permit_sasl_authenticated, defer_unauth_destination
```
## Stel het e-mailadres van de afzender en het wachtwoord in. Vervang <USERNAME> en <PASSWORD> door je eigen gegevens.

```sh
echo [smtp.gmail.com]:587 <USERNAME>@gmail.com:<PASSWORD> > /etc/postfix/sasl_passwd
postmap /etc/postfix/sasl_passwd
chmod 400 /etc/postfix/sasl_passwd
```
### **!!! Let op:** Het wachtwoord moet een app-wachtwoord zijn. App-wachtwoorden kunnen alleen worden gebruikt met accounts waarop 2-stapsverificatie is ingeschakeld.!!!
https://myaccount.google.com/u/2/apppasswords?rapt=AEjHL4M6fXW8Ck5LQFDPTQgcCttgJ-w2LisRkc_OYpDJir-pDmG5uM0hGR_JchdMw-N_1w3CT8irp11hDRGoRPkHgx_5krtpOnS1XF57U8P-Le_w1nRyU7U
```sh
echo [smtp.gmail.com]:587 wazuh2wt@gmail.com:gclqapvhzxhyuhdv > /etc/postfix/sasl_passwd
postmap /etc/postfix/sasl_passwd
chmod 400 /etc/postfix/sasl_passwd
```
## Beveilig je wachtwoord-databasebestand.
```sh
chown root:root /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
chmod 0600 /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
```
## Restart Postfix
```sh
systemctl restart postfix
```
## Voer de volgende opdracht uit om de configuratie te testen. Vervang you@example.com door je eigen e-mailadres. Controleer daarna of je deze test-e-mail ontvangt.

```sh
echo "Test mail from postfix" | mail -s "Test Postfix" -r "you@example.com" you@example.com
```

## Configureer e-mailmeldingen in het Wazuh-serverbestand `/var/ossec/etc/ossec.conf` als volgt:

```xml
<global>
  <email_notification>yes</email_notification>
  <smtp_server>localhost</smtp_server>
  <email_from><USERNAME>@gmail.com</email_from>
  <email_to>you@example.com</email_to>
</global>
```

## Herstart de Wazuh-manager om de wijzigingen toe te passen.

```sh
systemctl restart wazuh-manager
```
