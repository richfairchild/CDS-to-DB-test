download_file.fun <- function(file_row, work_dir,datasets) {

#select the file id and name of the required dataset

fileid<-datasets[file_row,1]
filename<-datasets[file_row,2]
filename<-paste(filename,Sys.Date(),sep="_")
filetype<-datasets[file_row,3]

#build URL to get dataset receipt end point
#and extract receipt

baseurl<-"https://api.witanforcities.com/api/"
receipt.url<-paste0(baseurl,"files/",fileid,"/link")

r <- POST(receipt.url,add_headers(authorization=(auth_token),encode = "json"))

Sys.sleep(1) # just to delay so the api can give a response to be extracted
content.chr<-rawToChar(r$content)
content.list<- fromJSON(content.chr)
receipt<-content.list[1]

#call endpoint to retreive download URL

download.url<-paste0(baseurl,"receipts/",receipt)

r<- GET(download.url,add_headers(authorization=(auth_token),encode = "json"))

Sys.sleep(1) # just to delay so the api can give a response to be extracted
content.chr<-rawToChar(r$content)
content.list<- fromJSON(content.chr)
URL.id<- content.list[[1]]

#extract filename and ext then download data to working directory

wd <- work_dir
setwd(wd)

filename <-gsub(" ","_",filename)
file.url<-paste0(baseurl,URL.id)
download.path<-paste0(filename,".",filetype)

r<-GET(URL.id,write_disk(download.path, overwrite=TRUE))

return(list(file_url=URL.id,file_name=filename))

}
