# osctrl Docker prod environment

This directory contains all the necessary configs to setup the osctrl Docker prod environment. There a couple of manual steps that are required before having a fully functional deployment:

1. Generate TLS/SSL termination certificate and private key
2. Generate JWT secret for API tokens

## Generate TLS/SSL termination certificate and private key

Follow these steps to generate a self-signed certificate that is going to be used for the osctrl deployment:

1. `cp conf/tls/openssl.cnf.example conf/tls/openssl.cnf`
2. `BASE_DOMAIN=<DOMAIN> openssl req -x509 -new -nodes -days <X - ex: 365) -keyout conf/tls/osctrl.key -out conf/tls/osctrl.crt -config conf/tls/openssl.cnf`
   1. Replace `<DOMAIN>` with an a domain like `osctrl.example.com`
   2. ![docker_openssl_generate](../../.img/docker_openssl_generate.png)

## Generate JWT secret

You can generate a random enough JWT secret to be used with the `osctrl-api` and `osctrl-admin` components using one of the following commands:

1. `uuidgen | shasum -a 256 | awk '{print $1}'`
   1. ![docker_uuid_gen](../../.img/docker_uuid_gen.png)
2. `vim .env` and set `JWT_SECRET`

## Set .env

1. `cp .env.example .env`
2. `vim .env` and set:
   1. osctrl
      1. `OSCTRL_VERSION` - define the version of osctrl to use
      2. `JWT_SECRET` - define the JWT secret (see instructions above)
      3. `OSCTRL_USER` - define username for osctrl admin user
      4. `OSCTRL_PASS` - define password for osctrl admin user
   2. osquery
      1. `OSQUERY_VERSION` - define the version of Osquery for test instance
   3. NGINX
      1. `NGINX_VERSION` - define the version of NGINX to use
   4. Postgres
      1. `POSTGRES_VERSION` - define the version of Postgres to use
      2. `POSTGRES_DB_NAME` - define the name of the database for osctrl
      3. `POSTGRES_DB_USERNAME` - define the username to conenct to osctrl database
      4. `POSTGRES_DB_PASSWORD` - define the password to conenct to osctrl database
   5. Save and exit
3. `docker-compose build`
   1. Build Docker images
4. `docker-compose up`
   1. Spin up osctrl Docker stack

## Login into osctrl

1. Open a browser to `https://127.0.0.1:8443/login`
2. Login
   1. Enter `<OSCTRL_USER>` for username
   2. Enter `<OSCTRL_PASS>` for password

## References

- [What is osctrl?](https://osctrl.net/)
- [osctrl-api](https://osctrl.net/openapi/doc.html)

### Docker

- [How to create new users in a Docker container?](https://net2.com/how-to-create-new-users-in-docker-container/)
- [Is mkdir -p totally safe when creating folder already exists](https://unix.stackexchange.com/questions/242995/is-mkdir-p-totally-safe-when-creating-folder-already-exists)
- [Meaning of ampersand (&) in docker-compose.yml file](https://stackoverflow.com/questions/45805380/meaning-of-ampersand-in-docker-compose-yml-file)
- [ChooseYourSIEMAdventure/docker-compose-splunk.yml](https://github.com/CptOfEvilMinions/ChooseYourSIEMAdventure/blob/main/docker-compose-splunk.yml)
- [Interactive shell using Docker Compose](https://stackoverflow.com/questions/36249744/interactive-shell-using-docker-compose)
- [Advanced Dockerfiles: Faster Builds and Smaller Images Using BuildKit and Multistage Builds](https://www.docker.com/blog/advanced-dockerfiles-faster-builds-and-smaller-images-using-buildkit-and-multistage-builds/)
- [Using openssl to get the certificate from a server](https://stackoverflow.com/questions/7885785/using-openssl-to-get-the-certificate-from-a-server)
- [osquery flags](https://osquery.readthedocs.io/en/stable/installation/cli-flags/)
- [mkcert is a simple tool for making locally-trusted development certificates](https://github.com/FiloSottile/mkcert)
