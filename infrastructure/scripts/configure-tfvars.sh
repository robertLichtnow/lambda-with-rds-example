rm ./infrastructure/terraform.tfvars

echo "dbname     = \"${DB_NAME}\"" >> ./infrastructure/terraform.tfvars
echo "dbuser     = \"${DB_USER}\"" >> ./infrastructure/terraform.tfvars
echo "dbpassword = \"${DB_PASSWORD}\"" >> ./infrastructure/terraform.tfvars