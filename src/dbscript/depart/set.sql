SET GLOBAL group_concat_max_len=1024000;
SET SESSION group_concat_max_len=1024000;
show variables like "group_concat_max_len";

set global max_connections=1000;