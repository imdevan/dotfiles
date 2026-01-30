# https://www.nushell.sh/book/aliases.html#list-all-loaded-aliases

# Query app.db
def q [query: string] { open app.db | query db $query }

alias items = open app.db | query db "select * from item"
alias user = open app.db | query db "select * from item"

alias e = exit



