Version="curl https://raw.githubusercontent.com/RunesRepoHub/GSCP/Dev/Docker/.env | sed 's/.\{8\}//'"

ver_path="/root/GSCP/Docker/.env"

web_path="/root/GSCP/Docker/Web"

pg_path="/root/GSCP/Docker/Database"

apt_path="/root/GSCP/Docker/API"

compose="/root/GSCP/Docker/Docker-compose.yaml"

version=$(cat "$ver_path" | awk '{ print substr( $0, 9 ) }')
ip_address=$(hostname -I | awk '{print $1}')

dockerdb=$(docker ps | grep -i cnc-mysql: | awk '{print $2}')
dockerweb=$(docker ps | grep -i cnc-web: | awk '{print $2}')

docker build -t gscp-web:$version "$web_path"
docker build -t gscp-pg:$version "$pg_path"
docker build -t gscp-node-api:$version "$apt_path"

docker compose -f "$compose" -p cnc-webgui down
docker compose -f "$compose" -p cnc-webgui up -d