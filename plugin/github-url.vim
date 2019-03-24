if exists("g:loaded_github_url") || &cp
  finish
endif
let g:loaded_github_url = 1

function! GitHubURL() range
  let branch = systemlist("git name-rev --name-only HEAD")[0]
  let remote_lines = systemlist("git config branch." . branch . ".remote")
  if len(remote_lines) > 0
    let remote = remote_lines[0]
  else
    echo "Warning: Could not determine remote from '" . branch . "', assuming origin"
    let remote = "origin"
  endif
  let repo = systemlist("git config --get remote." . remote . ".url | sed 's/\.git$//' | sed 's_^git@\\(.*\\):_https://\\1/_' | sed 's_^git://_https://_'")[0]
  let revision = systemlist("git rev-parse HEAD")[0]
  let path = systemlist("git ls-files --full-name " . @%)[0]
  let line = "#L" . a:firstline
  if a:firstline != a:lastline
    if repo=~#"gitlab\.com"
      let line = line . "-" . a:lastline
    else
      let line = line . "-L" . a:lastline
    endif
  endif

  let url = repo . "/blob/" . revision . "/" . path . line

  if has('clipboard')
    let @+ = url
  endif

  echomsg url
endfunction
command! -range GitHubURL <line1>,<line2>call GitHubURL()
