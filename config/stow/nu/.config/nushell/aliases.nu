# https://www.nushell.sh/book/aliases.html#list-all-loaded-aliases

# Query app.db
def q [query: string] { open app.db | query db $query }

alias e = exit



