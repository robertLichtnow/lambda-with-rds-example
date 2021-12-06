require('dotenv').config();

const fileExtension = process.env.NODE_ENV === 'production' ? 'js' : 'ts';

module.exports = {
  name: "default",
  type: "mysql",
  host: process.env.DB_HOST,
  port: parseInt(process.env.DB_PORT),
  username: process.env.DB_USERNAME,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_DATABASE,
  entities: [
    `./src/modules/**/infrastructure/typeorm/entities/*.${fileExtension}`
  ],
  migrations: [
    `./src/shared/infrastructure/typeorm/migrations/*.${fileExtension}`
  ],
  cli: {
    migrationsDir: "./src/shared/infrastructure/typeorm/migrations"
  }
}