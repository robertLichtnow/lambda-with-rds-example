import { diContainer } from "~/di-container";
import { HealthController } from "~/modules/server-health/infrastructure/controllers/HealthController";

diContainer.bind(HealthController).toSelf();