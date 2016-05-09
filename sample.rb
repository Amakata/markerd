# coding: UTF-8
require 'gviz'
Graph do
  node :customer, shape: 'record', label: '{\l顧客:customer_entity\l|\l顧客ID\l|顧客番号\l顧客名\l}', fontsize: 10
  node :customeraddress, shape: 'record', label: '{\l顧客住所:customeraddress\n|\n顧客住所ID\n|\n顧客ID\n市区町村\n}', fontsize: 10

  add customeraddress: :customer
  edge :customeraddress_customer, arrowhead: 'dot', headlabel: 'n-m  '
  save(:nodes, :png)
end
