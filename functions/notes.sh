note_file=~/.notes

# TODO get this whole thing to work
# it might be worth looking into use node for this

# function note() {
#     if [$note_file -z]; do
#         touch $note_file
#     done;
#     echo "${@}\n\n" >> $note_file
# }
# alias n="note"

function notes() {
    vim $note_file
}
# alias n="notes"
