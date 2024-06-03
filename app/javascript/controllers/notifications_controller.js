import { Application } from '@hotwired/stimulus'
import Notification from '@stimulus-components/notification'

const application = Application.start()
application.register('notification', Notification)