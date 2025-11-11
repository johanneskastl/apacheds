# ApacheDS Container

This container is designed to have an LDAP server that can be quickly launched for testing.  **NOTE:** This container is NOT designed for production use.

This container image is based on the ApacheDS container image by
[TremoloSecurity](https://github.com/TremoloSecurity/apacheds).

I decided to fork and play around with it in 2025, mostly because I had built a
[helm
chart](https://github.com/johanneskastl/helm-charts/blob/main/charts/apacheds/README.md)
for it and noticed that the image was outdated...

This includes the same fixes that I proposed in some pull requests in 2023.

## Environment Variables

| Variable | Description | Example |
| -------- | ----------- | ------- |
| APACHEDS_ROOT_PASSWORD | The password for `uid=admin,ou=system` | my_password_is_secure! |
| APACHEDS_TLS_KS_PWD | The password for the Java keystore used for ApacheDS' TLS listener | still_super_secure! |
| DN | The root suffix of the directory | dc=domain,dc=com |
| OBJECT_CLASS | The object class of the root suffix's object | domain |
| LDIF_FILE | The path (in the container) of the initial LDIF file, optional | /etc/apacheds/data.ldif |
| PRE_RUN_SCRIPT | *Optional* - A script can be run after initializing the directory before loading data |

## Volumes

| Path | Description |
| ---- | ----------- |
| /etc/apacheds | External apacheds configuration options for the container.  **MUST** contain a keystore called `apacheds.jks` that has an RSA keypair used for TLS in apacheds |
| /var/apacheds | *Optional* - Where all persistent data is stored.  If not included as a separate mount all data is ephemeral and will be lost when the container is destroyed |

## Licensing

As this image is based on the TremoloSecurity one, I keep the same license
(Apache 2.0).

## Author Information

I am Johannes Kastl, reachable via git@johannes-kastl.de
