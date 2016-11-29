command! -range -nargs=0 ModsExplain :'<,'>w !mods -f "explain this, be very succint"
command! -range -nargs=* ModsRefactor :'<,'>!mods -f "refactor this to improve its readability"
command! -range -nargs=+ Mods :'<,'>w !mods <q-args>
