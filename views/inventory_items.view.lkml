# The name of this view in Looker is "Inventory Items"
view: inventory_items {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `looker-private-demo.thelook.inventory_items` ;;
  drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    description: "primary key for inventory items"
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Cost" in Explore.

  dimension: cost {
    description: "cost of inventory item"
    type: number
    sql: ${TABLE}.cost ;;
    value_format: "$#.00;($#.00)"
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_cost {
    description: "sum of cost"
    type: sum
    sql: ${cost} ;;
    value_format: "$#.00;($#.00)"
    }
  measure: average_cost {
    description: "average cost"
    type: average
    sql: ${cost} ;;
    value_format: "$#.00;($#.00)"}
  measure: max_cost {
    description: "maximum cost"
    type: max
    sql: ${cost} ;;
    value_format: "$#.00;($#.00)"
  }
  measure: min_cost {
    description: "minimum cost"
    type: min
    sql: ${cost} ;;
    value_format: "$#.00;($#.00)"
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_brand {
    description: "brand name"
    type: string
    sql: ${TABLE}.product_brand ;;
  }

  dimension: product_category {
    description: "category"
    type: string
    sql: ${TABLE}.product_category ;;
  }

  dimension: product_department {
    description: "department"
    type: string
    sql: ${TABLE}.product_department ;;
  }

  dimension: product_distribution_center_id {
    description: "id for distribution center"
    type: string
    sql: ${TABLE}.product_distribution_center_id ;;
  }

  dimension: product_id {
    description: "product id"
    type: number
    sql: ${TABLE}.product_id ;;
  }

  dimension: product_name {
    description: "product name"
    type: string
    sql: ${TABLE}.product_name ;;
  }

  dimension: product_retail_price {
    description: "retail price of product"
    type: number
    sql: ${TABLE}.product_retail_price ;;
    value_format: "$#.00;($#.00)"
  }

  dimension: product_sku {
    description: "SKU for product"
    type: string
    sql: ${TABLE}.product_sku ;;
  }

  dimension_group: sold {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.sold_at ;;
  }
  measure: count {
    type: count
    drill_fields: [id, product_name, products.name, products.id, order_items.count]
  }
  measure: distinct_products_sku {
    type: count_distinct
    sql: ${TABLE}.product_sku ;;
  }
}
