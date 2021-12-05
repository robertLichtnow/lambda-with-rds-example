require('dotenv').config();

const fileExtension = process.env.NODE_ENV === 'production' ? 'js' : 'ts';

module.exports = {
  name: "default",
  type: "mysql",
  host: process.env.TYPEORM_HOST,
  port: process.env.TYPEORM_PORT,
  username: process.env.TYPEORM_USERNAME,
  password: process.env.TYPEORM_PASSWORD,
  database: process.env.TYPEORM_DATABASE,
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