###########################

#Problem5_Sensory_analysis 

#get data 

###########################

# get data

url<-"http://www2.isye.gatech.edu/~jeffwu/wuhamadabook/data/Sensory.dat"

Sensory_raw<-read.table(url, header=F, skip=1, fill=T, stringsAsFactors = F)

Sensory_tidy<-Sensory_raw[-1,]

# Get all rows corresponding to the ones with the item number included

Sensory_tidy_a<-filter(.data = Sensory_tidy,V1 %in% 1:10) %>%
  
  rename(Item=V1,V1=V2,V2=V3,V3=V4,V4=V5,V5=V6)

#Get all rows without the item number, add number, remove blank column

Sensory_tidy_b<-filter(.data = Sensory_tidy,!(V1 %in% 1:10)) %>%
  
  mutate(Item=rep(as.character(1:10),each=2)) %>%
  
  mutate(V1=as.numeric(V1)) %>%
  
  select(c(Item,V1:V5))

# push data together and label columns

Sensory_tidy<-bind_rows(Sensory_tidy_a,Sensory_tidy_b)

colnames(Sensory_tidy)<-c("Item",paste("Person",1:5,sep="_"))

# reshape

Sensory_tidy<-Sensory_tidy %>% 
  
  gather(Person,value,Person_1:Person_5) %>% 
  
  mutate(Person = gsub("Person_","",Person)) %>%
  
  arrange(Item)

###########################