# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.our_welcome.welcome")
        small I18n.t("active_admin.our_welcome.small_msg")
      end
    end

    columns do
      column do
        panel "Recent Posts" do
          ul do
            Post.order("created_at DESC").last(5).map do |post|
              li link_to(post.title, admin_post_path(post))
              li post.author
              hr
            end
          end
        end
      end

      column do
        panel "Info" do
          para "Welcome to your dashboard."
          span current_admin_user.email
          hr
          para class: "subtitle" do
            "Note: If you see a robot, that means that the file or image you uploaded was bad. Please try again!"
          end
        end
      end
    end
  end
end
