
library("googlesheets")
library("hms")
library("ggmap")

# requires auth on my acct
findit <- gs_ls("Waukegan Crime")
gs <- gs_key(findit$sheet_key)
df <- gs_read(gs)

for(i in 1:nrow(df)){
  if(!is.na(df$lat[i])) next
  loc <- geocode(paste(df$`Location Description`[i], " near ",
                       df$Location[i], " Waukegan IL"))
  gs_edit_cells(ss=gs, ws="Sheet1", input=loc$lat, anchor=paste0("G", (i+1)))
  Sys.sleep(.3)
  gs_edit_cells(ss=gs, ws="Sheet1", input=loc$lon, anchor=paste0("H", (i+1)))
  Sys.sleep(.3)
}





