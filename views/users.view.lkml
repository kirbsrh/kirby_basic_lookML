# The name of this view in Looker is "Users"
view: users {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `looker-private-demo.thelook.users` ;;
  drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    description: "primary key for user"
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Age" in Explore.

  dimension: age {
    description: "age of user"
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_tier {
    description: "age tier that user belongs to"
    type: tier
    tiers: [0, 10, 20, 30, 40, 50, 60, 70, 80]
    style: integer
    sql: ${TABLE}.age ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_age {
    description: "sum of age"
    type: sum
    sql: ${age} ;;  }
  measure: average_age {
    description: "average age"
    type: average
    sql: ${age} ;;  }

  measure: average_female_age {
    description: "average age of female users"
    type: average
    filters: [is_female: "yes"]
    sql: ${age} ;;
  }

  dimension: city {
    description: "city associated with user"
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    description: "country associated with user"
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    description: "email for user"
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    description: "user first name"
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    description: "gender of user"
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: is_female {
    type:  yesno
    sql: ${gender} = 'Female' ;;
  }

  dimension: womens_day_cohort {
    case: {
      when: {
        sql: ${TABLE}.is_female ;;
        label: "Include"
        }
      else: "Exclude"
      }
    }


  dimension: last_name {
    description: "last name of user"
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: latitude {
    description: "latitude of user"
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    description: "longitude of user"
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: user_location {
    description: "loction of user for mapping purposes using lat and long data"
    type: location
    sql_latitude: ${TABLE}.latitude;;
    sql_longitude: ${TABLE}.longitude ;;
  }

  dimension: state {
    description: "state associated with user"
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: traffic_source {
    description: "traffic source associated with user"
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    description: "zipcode for user"
    type: zipcode
    sql: ${TABLE}.zip ;;
  }
  measure: count {
    type: count
    drill_fields: [id, last_name, first_name, orders.count, order_items.count, traffic_source, is_female]}
  }
