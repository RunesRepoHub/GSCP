source ~/GSCP/Core.sh

docker build -t gscp-web:$version "$web_path"
docker build -t gscp-pg:$version "$pg_path"
docker build -t gscp-node-api:$version "$apt_path"

docker compose -f "$compose" -p cnc-webgui down
docker compose -f "$compose" -p cnc-webgui up -d