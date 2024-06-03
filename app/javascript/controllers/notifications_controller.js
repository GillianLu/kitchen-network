import { Application } from '@hotwired/stimulus'
import Notification from '@stimulus-components/notification'

console.log("Loading Notification Controller...")

const application = Application.start()
application.register('notification', Notification)