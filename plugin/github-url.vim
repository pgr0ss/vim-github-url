if exists("g:loaded_github_url") || &cp
  finish
endif
let g:loaded_github_url = 1

function! GitHubURL() range
  let branch = systemlist("git name-rev --name-only HEAD")[0]
  let remote = systemlist("git config branch." . branch . ".remote")[0]
  let repo = systemlist("git config --get remote." . remote . ".url | sed 's/\.git$//' | sed 's_^git@\\(.*\\):_https://\\1/_' | sed 's_^git://_https://_'")[0]
  let revision = systemlist("git rev-parse HEAD")[0]
  let path = systemlist("git ls-files --full-name " . @%)[0]
  let url = repo . "/blob/" . revision . "/" . path . "#L" . a:firstline . "-L" . a:lastline
  echomsg url
endfunction
command! -range GitHubURL <line1>,<line2>call GitHubURL()
