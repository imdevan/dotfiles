# https://www.nushell.sh/book/aliases.html#list-all-loaded-aliases

# Query app.db
def q [query: string] { open app.db | query db $query }

def query_table [
  table: string
  --select (-s): string = "*"
  --where (-w): string
] {
  let sql = if $where != null {
    $"select ($select) from ($table) where ($where)"
  } else {
    $"select ($select) from ($table)"
  }
  open app.db | query db $sql
}

def qt [table: string, select?: string, where?: string] {
  if $where != null {
    query_table $table --select ($select | default "*") --where $where
  } else {
    query_table $table --select ($select | default "*")
  }
}

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

def cols [table: string] {
  open app.db | query db $"pragma table_info\(($table))" | select name type
}

def items [] { open app.db | query db "select * from item" }
def video [] { open app.db | query db "select * from video" }
def recap [] { open app.db | query db "select * from recap" }
def user [] { open app.db | query db "select * from user" }
def tag [] { open app.db | query db "select * from tag" }
def ds [] { open app.db | query db "select * from dancestyle" }

alias e = exit
alias r = clear
alias c = clear

def reload  [] {
  exec nu
}
alias r = reload
