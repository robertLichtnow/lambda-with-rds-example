import { Column, MigrationInterface, QueryRunner, Table } from 'typeorm';

export class AddPeopleTable1638745756147 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(new Table({
      name: 'people',
      columns: [
        {
          name: 'id',
          type: 'VARCHAR(32)',
          isPrimary: true,
          default: 'UUID()'
        },
        {
          name: 'name',
          type: 'VARCHAR'
        },
        {
          name: 'email',
          type: 'VARCHAR',
          isUnique: true,
        },
        {
          name: 'created_at',
          type: 'timestamp',
          default: 'NOW()'
        }
      ],
    }));
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropTable('people');
  }
}
