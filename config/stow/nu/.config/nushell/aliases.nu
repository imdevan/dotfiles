# https://www.nushell.sh/book/aliases.html#list-all-loaded-aliases

# Query app.db
def q [query: string] { open app.db | query db $query }

def docker_query [sql: string, container: string = "backend-backend-1"] {
  let script = "import sqlite3,json,sys
sql=sys.argv[1]
conn=sqlite3.connect('/app/data/app.db')
conn.row_factory=sqlite3.Row
cur=conn.execute(sql)
conn.commit()
print(json.dumps([dict(r) for r in cur.fetchall()]))"
  docker exec $container python3 -c $script $sql | from json
}

def query_table [
  table: string
  --select (-s): string = "*"
  --where (-w): string
  --container (-c): string
] {
  let sql = if $where != null {
    $"select ($select) from ($table) where ($where)"
  } else {
    $"select ($select) from ($table)"
  }
  if $container != null {
    docker_query $sql $container
  } else {
    open app.db | query db $sql
  }
}

def qt [table: string, select?: string, where?: string] {
  if $where != null {
    query_table $table --select ($select | default "*") --where $where
  } else {
    query_table $table --select ($select | default "*")
  }
}

def qd [table: string, select?: string, where?: string, container?: string] {
  let c = ($container | default "backend-backend-1")
  if $where != null {
    query_table $table --select ($select | default "*") --where $where --container $c
  } else {
    query_table $table --select ($select | default "*") --container $c
  }
}

def qdu [table: string, set: string, where?: string, container?: string] {
  let c = ($container | default "backend-backend-1")
  let sql = if $where != null {
    $"update ($table) set ($set) where ($where)"
  } else {
    $"update ($table) set ($set)"
  }
  docker_query $sql $c
}

def qdd [table: string, where: string, container?: string] {
  let c = ($container | default "backend-backend-1")
  docker_query $"delete from ($table) where ($where)" $c
}

def td [container?: string] {
  let c = ($container | default "backend-backend-1")
  docker_query "select name from sqlite_master where type='table'" $c
  | each { |table|
      let table_name = $table.name
      let row_count = (docker_query $"select count\(*) as count from ($table_name)" $c | get count.0)
      { table: $table_name, rows: $row_count }
    }
  | table -i false
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
