## Connection and download the tables

#install.packages("DBI")
#install.packages("dplyr", dependencies = T)
#install.packages("bindrcpp")
library(DBI)
library(dplyr)

cn <- dbConnect(odbc::odbc(), 
                 Driver = "{SQL Server Native Client 11.0}",
                 Server = "(LocalDb)\\BogTrPoll",
                 Database = "BogTrPoll",
                 MultipleActiveResultSets = "True",
                 user = "ReadUserBTP",
                 password = "Reader123$")

tab_names <- dbListTables(cn)
tab_names <- tab_names[1:which(tab_names == "trace_xe_action_map") - 1]

gen_tabs <- function(x, con){
  if(!is.vector(x)|!is.character(x)) stop("Need to be a character vector")
  
  gen_tab_colnames_list <- list()
  
  for(i in 1:length(x)){
    gen_tab_colnames_list[[i]] <- dbGetQuery(con, paste0("SELECT SC.name AS ColumnName ",
                                                         "FROM sys.columns AS SC LEFT JOIN sys.types AS ST ",
                                                         "ON SC.system_type_id = ST.system_type_id ",
                                                         "WHERE SC.object_id = (SELECT TOP 1 object_id ",
                                                                            "FROM sys.objects ",
                                                                            "WHERE name = '", x[i], "') ",
                                                                            "AND ST.name != 'sysname'"))
  }
  dbtables_list <- list()
  for(j in 1:length(x)){
    length_required <- dbGetQuery(con, paste0("SELECT COUNT(*) FROM ", x[j]))
    dbtables_list[[j]] <- data.frame(col1 = rep(0, length_required))
    for(k in 1:nrow(gen_tab_colnames_list[[j]])){
      dbtables_list[[j]] <- data.frame(dbtables_list[[j]], 
                                       dbGetQuery(con, paste0("SELECT ", gen_tab_colnames_list[[j]][k, 1], 
                                                              " FROM ",x[j])), stringsAsFactors = F)
    }
    dbtables_list[[j]] <- dbtables_list[[j]][,-1]
  }
  dbtables_list <<- dbtables_list
}
gen_tabs(tab_names, cn)

dbDisconnect(cn)

