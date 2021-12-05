import { diContainer } from "~/di-container";
import { HealthController } from "~/modules/server-health/infrastructure/controllers/health-controller";

diContainer.bind(HealthController).toSelf();