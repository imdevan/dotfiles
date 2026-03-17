# https://www.nushell.sh/book/aliases.html#list-all-loaded-aliases

# Query app.db
def q [query: string] { open app.db | query db $query }

def tables [] {
  open app.db 
  | query db "select name from sqlite_master where type='table'" 
  | each { |table| 
      let table_name = $table.name
      let row_count = (open app.db | query db $"select count\(*) as count from ($table_name)" | get count.0)
      {
        table: $table_name, 
        rows: $row_count
      }
    } 
  | table -i false
}

alias items = open app.db | query db "select * from item"
alias user = open app.db | query db "select * from item"

alias e = exit

def reload  [] {
  exec nu
}
alias r = reload
