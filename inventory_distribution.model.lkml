connection: "looker-private-demo"

# include: "/views/distribution_centers.view"
# include: "/views/inventory_items.view"
# include: "/views/products.view"


include: "/views/*.view"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#

datagroup: every_four_datagroup {
  max_cache_age: "4 hours"
  interval_trigger: "4 hours"
  label: "four hour refresh"
  description: "Interval trigger set for every four hours to catch new updates"
}

explore:  inventory_items{
  label: "Inventory Items"
  join: products {
    type: inner
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
  join: distribution_centers {
    type: inner
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  persist_with: every_four_datagroup
    sql_always_where: ${orders.created_date} >= '2020-01-01' ;;
  join: orders {
    relationship: many_to_one
    sql_on: ${order_items.order_id} = ${orders.order_id};;
  }
  join: users {
    type: inner
    relationship: many_to_one
    sql_on: ${orders.user_id} = ${users.id} ;;
    fields: [users.id, users.first_name, users.last_name, users.age]
  }
}


explore: users {
  label: "Users Detail"
  always_filter: {
    filters: [users.country: "United States"]
  }
  join: orders {
    type: left_outer
    view_label: "User Orders"
    relationship: many_to_one
    sql_on: ${users.id} = ${orders.user_id} ;;
  }
}





# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
