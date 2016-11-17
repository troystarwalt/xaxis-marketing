# Xaxis Internal

## Internal runs on:

```
Ruby Version (ruby 2.3.1-p112)
Rails Versions (5.0)
Bootstrap 4
```

## Simple Start
```
git clone git@github.com:Xaxis-Marketing/internal.git  (SSH)
cd
bundle install
--migrate if you haven't yet
rails s
```

## Add Ons
We have a couple of tools to monitor performance for the app.
```
Bullet # This keeps our N+1 queries to a minimum. You can view the logs in log/bullet.log
NewRelic # The dashboard is at /newrelic This is an all around tool to monitor performance of page loads and database calls. We are on a free app from Troy's account.
Rubocop # Looks at code and checks for style and errors.
```

## Future To Do
Setup Language Translations for Active Admin
IE:  
```
  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        # span I18n.t("active_admin.dashboard_welcome.welcome")
        # small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end
```
