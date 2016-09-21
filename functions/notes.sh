note_file=~/.notes
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
