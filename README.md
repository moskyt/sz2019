```
Team
  name:string
  uid:string
  number:integer
  district:integer
  stage:string
  ts_registered:datetime   
  ts_rules_submitted:datetime
  ts_about_submitted:datetime
  ts_departed:datetime   
  ts_arrived:datetime
  participants_json:text
  points:integer
  points_about:integer
  points_rules:integer
  preference_departure:string / sooner later
  preference_hotspot:integer
  departure:string / revnice-1629-1705 kytin-1630-1732
  trail:string / zelena zluta
  hotspot:integer
  points_dinner:integer
  points_cleanup:integer
```  
  
bundle exec rails g model team name:string uid:string number:integer district:integer stage:string ts_registered:datetime    ts_rules_submitted:datetime ts_about_submitted:datetime ts_departed:datetime ts_arrived:datetime participants_json:text points:integer points_about:integer points_rules:integer preference_departure:string preference_hotspot:integer departure:string trail:string hotspot:integer points_dinner:integer points_cleanup:integer
  ```  
  