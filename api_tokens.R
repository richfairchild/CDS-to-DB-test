
api_tokens.fun <- function(name,pwd) {
  
  
  ##Login to CDS API using credentials and retrieve API tokens
  
  #set up URL and message body
  
  baseurl<-"https://api.witanforcities.com/api/"
  login.url <- "login"
  url <- paste0(baseurl,login.url)
  
  body<- list(username=(name), password = (pwd))
  
  
  #query API for tokens
  
  r <- POST(url, body = body, encode = "json")
  
  #convert content from Unicode, then to a list, then df
  
  content.chr<-rawToChar(r$content)
  content.list<- fromJSON(content.chr)
  df <- do.call(what = "rbind", args = lapply(content.list, as.data.frame))
  
  #extract tokens
  
  auth_token<-as.character(df[1,1])
  refresh_token<-as.character(df[1,2])
  
  return(list(auth=auth_token,refresh=refresh_token))
  
}







