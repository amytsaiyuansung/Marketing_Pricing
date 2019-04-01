library(data.table)
library(lubridate)

tran<-fread('E:/Spring term/MKT Analysis/transaction_table.csv')
product<-fread('E:/Spring term/MKT Analysis/product_table.csv')

# Map the week in 2017
tran_2017<-tran[year(tran$tran_dt)>2016,]
tran_2017$weeknumber<-isoweek(tran_2017$tran_dt)

# Calculate pormotion level
promotion<-tran_2017[,c(4,5,7,8,9,11,12,13)]
promotion$prom_level<-(-promotion$tran_prod_discount_amt/promotion$tran_prod_sale_qty)/promotion$prod_unit_price

promotion_2017<-promotion[,c(1,2,8,9)]

a<-aggregate(x=promotion_2017$prom_level, by = list(promotion_2017$prod_id, promotion_2017$store_id,promotion_2017$weeknumber), FUN=mean)


write.csv(a,file='E:/Spring term/MKT Analysis/promotionlevel.csv')