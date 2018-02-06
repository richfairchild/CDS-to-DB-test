download_file_list.fun <- function(file_count) {

#build URL to extract list of datasets available to user

count<-paste("count=",file_count,sep="") #set limit for files shown in response
index<-"index=0" #set starting point of file count
files.url<-"files?"
baseurl<-"https://api.witanforcities.com/api/"
url <- paste(baseurl,files.url,count,"&",index, sep= "") 

#query API for list of datasets

r<- GET(url,add_headers(authorization=(auth_token),encode = "json"))

#pass response and extract dataset metadata

content.chr<-rawToChar(r$content)
content.list<- fromJSON(content.chr)
dat <- content.list[[2]]

#extract columns of interest and rename cols

datasets <- dat[,c("kixi.datastore.metadatastore/id","kixi.datastore.metadatastore/name","kixi.datastore.metadatastore/file-type")]
colnames(datasets)<-c("id","name","file-type")

return(datasets)

}



