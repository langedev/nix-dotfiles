// import { Switch } from "./modules/workspace-switch.js";
import { notificationPopup } from "./modules/notifications/notificationPopup.ts"

export default {
    style: App.configDir + '/modules/notifications/style.css',
    windows: [
        notificationPopup()
    ]
}
