
upload_to_api.fun <- function(file_location, size_of_file, name_of_file) {


#build URL and generate receipt ID - re-run for each dataset to be uploaded

baseurl<-"https://api.witanforcities.com/api/"
receipt.url<-"files/upload"
url<- paste(baseurl,receipt.url,sep="")

r <- POST(url,add_headers(authorization=(auth_token),encode = "json"))#Extract the receipt ID from response

content.chr<-rawToChar(r$content)
Sys.sleep(1) # just to delay so the api can give a response to be extracted
content.list<- fromJSON(content.chr)
Sys.sleep(1) # just to delay so the api can give a response to be extracted
receipt.id<-content.list[[1]]

#Get new data upload url
#Build URL and retreive URL

receipt.id.url<-paste("receipts/",receipt.id, sep="")
url<- paste(baseurl,receipt.id.url,sep="")
r<- GET(url,add_headers(authorization=(auth_token),encode = "json"))

#extract new uri and file id

content.chr<-rawToChar(r$content)
Sys.sleep(1) # just to delay so the api can give a response to be extracted
content.list<- fromJSON(content.chr)
Sys.sleep(1) # just to delay so the api can give a response to be extracted
uri<-content.list[[1]]
file.id<-content.list[[2]]

#upload file

r<- PUT(uri,body = upload_file(give_file_location))

#create and upload metadata
#set metadata attributes

header<-"TRUE"
size<-give_size_of_file
name<-give_name_of_file
filetype<-"csv"

#convert metadata to required json format

body<- list("kixi.datastore.metadatastore/header"=(header),"kixi.datastore.metadatastore/size-bytes"=(size),"kixi.datastore.metadatastore/name"= (name),"kixi.datastore.metadatastore/file-type"=(filetype))

#create URL and upload metadata

url.meta<- paste(baseurl,"files/", file.id,"/metadata",sep="")

r<- PUT(url.meta,add_headers("authorization"=(auth_token), "Content_Type"=("application/json")),encode = "json", body = body)


}
