module UserTagHelper
  class UserTagMarkdownRenderer < Redcarpet::Render::HTML
    include Rails.application.routes.url_helpers

    def preprocess(document)
      # Parse user mentions and replace them with links to user profiles
      document.gsub!(/@([\w\s]+)/) do |match|
        username = $1
        user = User.find_by(name: username)
        if user
          notify_tagged_user(user) # Trigger notification for tagged user
          "<a href='/users/#{user.uid}'>@#{username}</a>"
        else
          match # Leave the mention unchanged if the user doesn't exist
        end
      end
      document
    end
    def notify_tagged_user(user)
      # Trigger TagNotification for the tagged user
      TagNotification.with(tagged_user: user).deliver(user)
    end
  end
end
