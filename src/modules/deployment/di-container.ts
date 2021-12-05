import { diContainer } from "~/di-container";
import { RunMigrationsController } from "~/modules/deployment/infrastructure/controllers/run-migrations-controller";

diContainer.bind(RunMigrationsController).toSelf();