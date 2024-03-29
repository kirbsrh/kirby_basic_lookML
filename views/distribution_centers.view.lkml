# The name of this view in Looker is "Distribution Centers"
view: distribution_centers {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `looker-private-demo.thelook.distribution_centers` ;;
  drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    description: "Primary key for the distribution center"
    type: string
    sql: ${TABLE}.id ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Latitude" in Explore.

  dimension: latitude {
    description: "latitude for the distribution center"
    type: number
    sql: ${TABLE}.latitude ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_latitude {
    description: "sum of latitude field"
    type: sum
    sql: ${latitude} ;;  }
  measure: average_latitude {
    description: "average of latitude field"
    type: average
    sql: ${latitude} ;;  }

  dimension: longitude {
    description: "longitude for the distribution center"
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: dc_location {
    description: "location field for map visualization, includes latitude and longitude"
    type: location
    sql_latitude: ${TABLE}.latitude ;;
    sql_longitude: ${TABLE}.longitude ;;
  }

  dimension: name {
    description: "name of distribution center"
    type: string
    sql: ${TABLE}.name ;;
  }
  measure: count {
    description: "count aggregation"
    type: count
    drill_fields: [id, name, products.count]
  }
}
