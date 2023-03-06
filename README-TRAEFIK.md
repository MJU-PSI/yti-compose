-- run setup-traefik.sh in src folder
./src/script/setup.sh dev


sudo mkdir -p /mnt/data/traefik
sudo mkdir -p /mnt/data/portainer
sudo touch /mnt/data/traefik/acme.json

docker swarm init

docker network create --driver overlay traefik-public

docker stack deploy -c traefik.yml traefik
-- docker stack rm traefik

docker stack deploy -c portainer.yml portainer
-- docker stack rm portainer

export POSTGRES_PASSWORD='#{PASSWORD}'
docker stack deploy -c postgres.yml postgres
-- docker stack rm postgresF

docker stack deploy -c groupmanagement.yml groupmanagement
-- docker stack rm groupmanagement

-- wait till groupmanagement starts
sudo src/script/init-admin-swarm.sh

docker stack deploy -c swarm-context-path.yml psi
-- docker stack rm psi
