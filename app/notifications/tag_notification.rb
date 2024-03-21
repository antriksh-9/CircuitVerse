# frozen_string_literal: true

class TagNotification < Noticed::Base
    deliver_by :database, association: :noticed_notifications
  
    def message
      tagged_user = params[:tagged_user]
      t("users.notifications.tag_notif", user: tagged_user.name)
    end
  
    def icon
      "far fa-user-tag"
    end
  end
  