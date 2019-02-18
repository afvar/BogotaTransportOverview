## Connection and download the tables

#install.packages("DBI")
#install.packages("dplyr", dependencies = T)
#install.packages("bindrcpp")
#install.packages("stringr")
library(DBI)
library(dplyr)
library(stringr)


cn <- dbConnect(odbc::odbc(), 
                 Driver = "{SQL Server Native Client 11.0}",
                 Server = "(LocalDb)\\BogTrPoll",
                 Database = "BogTrPoll",
                 MultipleActiveResultSets = "True",
                 user = "ReadUserBTP",
                 password = "Reader123$")


tab_names <- as.vector(as.matrix(dbGetQuery(cn, "SELECT TABLE_NAME 
                                                 FROM BogTrPoll.INFORMATION_SCHEMA.TABLES
                                                 WHERE TABLE_TYPE = 'BASE TABLE'
                                                 ORDER BY TABLE_NAME")))

prnc_tab_names <- c("ENCUESTAS", "ETAPAS", "PERSONAS", "VEHICULOS", "VIAJES")

f_keys <- as.tbl(dbGetQuery(cn, "SELECT 
                                 CONSTRAINT_NAME, 
                                 TABLE_NAME AS TRG_TAB, 
                                 COLUMN_NAME, 
                                 (SELECT COUNT(CONSTRAINT_NAME) 
                                  FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS A 
                                  WHERE A.CONSTRAINT_NAME=B.CONSTRAINT_NAME) AS N
                                 FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS B
                                 WHERE TABLE_CATALOG = 'BogTrPoll' AND CONSTRAINT_NAME LIKE '%fk%'")) %>%
            mutate(SRC_TAB = toupper(str_split(CONSTRAINT_NAME,"_", simplify = T)[,3])) %>%
            select(COLUMN_NAME, N, TRG_TAB, SRC_TAB)


gen_tabs <- function(x, fk, con){
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
  for(i in 1:length(x)){
    length_required <- dbGetQuery(con, paste0("SELECT COUNT(*) FROM ", x[i]))
    dbtables_list[[i]] <- data.frame(col1 = rep(0, length_required))
    for(j in 1:nrow(gen_tab_colnames_list[[i]])){
      dbtables_list[[i]] <- data.frame(dbtables_list[[i]], 
                                       dbGetQuery(con, paste0("SELECT ", gen_tab_colnames_list[[i]][j, 1], 
                                                              " FROM ",x[i])), stringsAsFactors = F)
    }
  }
  names(dbtables_list) <- x
  dbtables_list <<-lapply(dbtables_list, function(y){y <- as.tbl(y); y[,-1]})
  
  if(nrow(filter(fk, TRG_TAB %in% x)) != nrow(fk)) stop("Can´t join it")
  
  # for(i in 1:length(dbtables_list)){
  #   src_tabs <- fk %>% filter(TRG_TAB == names(dbtables_list)[i])
  #   if(nrow(src_tabs) > 0){
  #     for(j in 1:nrow(src_tabs)){
  #       if(src_tabs[j,2]==1){
  #         new_cols <- as.tbl(dbGetQuery(con, paste0("SELECT B.*", 
  #                                                   " FROM ",  as.character(src_tabs[j, 3]), " AS A LEFT JOIN ", 
  #                                                   as.character(src_tabs[j, 4]), " AS B ",
  #                                                   "ON A.", as.character(src_tabs[j, 1]),
  #                                                   " = B.ID_", as.character(src_tabs[j,4]))))
  #         new_cols <- select(new_cols, -c(paste0("ID_",as.character(src_tabs[j,4]))))
  #         names(new_cols) <- sapply(names(new_cols), paste, as.character(src_tabs[j,4]))
  #         bind_cols(dbtables_list[[i]], new_cols)
  #       }
  #       
  #     }
  #   }
  # }
}
gen_tabs(tab_names, f_keys, cn)


dbDisconnect(cn)

## Data Cleaning
