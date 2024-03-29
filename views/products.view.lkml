# The name of this view in Looker is "Products"
view: products {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `looker-private-demo.thelook.products` ;;
  drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    description: "primary key of product"
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Brand" in Explore.

  dimension: brand {
    description: "name of brand"
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: category {
    description: "name of category"
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: cost {
    description: "cost of product"
    type: number
    sql: ${TABLE}.cost ;;
    value_format:"$#.00;($#.00)"
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_cost {
    description: "sum of cost"
    type: sum
    sql: ${cost} ;;
    value_format:"$#.00;($#.00)"}
  measure: average_cost {
    description: "average cost"
    type: average
    sql: ${cost} ;;
    value_format:"$#.00;($#.00)"}

  dimension: department {
    description: "department"
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: distribution_center_id {
    description: "id of distribution center"
    type: string
    sql: ${TABLE}.distribution_center_id ;;
  }

  dimension: name {
    description: "name of product"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: retail_price {
    description: "retail price for product"
    type: number
    sql: ${TABLE}.retail_price ;;
    value_format:"$#.00;($#.00)"
  }

  dimension: sku {
    description: "product SKU"
    type: string
    sql: ${TABLE}.sku ;;
  }
  measure: count {
    type: count
    drill_fields: [id, name, distribution_centers.name, distribution_centers.id, inventory_items.count, sku, category]
  }
}
