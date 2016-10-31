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
rails s
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
