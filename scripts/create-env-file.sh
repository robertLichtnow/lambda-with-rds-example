# This should be achieved through AWS store parameter later

rm .env

echo "DB_HOST=\"${APP_DB_HOST}\"" >> .env
echo "DB_USERNAME=\"${APP_DB_USERNAME}\"" >> .env
echo "DB_PASSWORD=\"${APP_DB_PASSWORD}\"" >> .env
echo "DB_DATABASE=\"${APP_DB_DATABASE}\"" >> .env
echo "DB_PORT=\"${APP_DB_PORT}\"" >> .env