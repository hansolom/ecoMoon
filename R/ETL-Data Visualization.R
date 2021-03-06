


# add bloomberg, quandl pulls
# Add function to webscrape BEA and BLS datasets
# Include some links

fred.api.key <-function(key){fredr_set_key(key)}
quandl.api.key <-function(key){Quandl.api_key(key)}



eco.quarterly <-function(fred.keys,key.rename, shape){
 shape <-ifelse(missing(shape),'w',shape)

 if(shape == 'l'){
   fred.keys <-append('USRECQM', fred.keys)
   df <-data.frame(map_dfr(fred.keys,fredr))
   df[df$series_id=='USRECM'] <-'recession'
   df$Quarter <-paste(quarters(as.Date(df[,1])), format(df[,1], '%y'), sep=" ")
   return(df)
 } else{
    fred.keys <-append('USRECQM', fred.keys)
    df <-data.frame(map_dfr(fred.keys,fredr))
    df <-stats::reshape(df, idvar='date', timevar='series_id', direction='wide')
    key.rename <-append('recession', key.rename)
    key.rename <-append('date', key.rename)
    colnames(df) <-key.rename
    df <-df[order(as.Date(df[,1], format="%d/%m/%Y")),]
    rownames(df) <-df$date
    df$Quarter <-paste(quarters(as.Date(df[,1])), format(df[,1], '%y'), sep=" ")
    return(df)
 }
}



