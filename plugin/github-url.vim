if exists("g:loaded_github_url") || &cp
  finish
endif
let g:loaded_github_url = 1

function! s:repoURL()
  let branch = systemlist("git branch --show-current")[0]
  let remote_lines = systemlist("git config branch." . branch . ".remote")
  if len(remote_lines) > 0
    let remote = remote_lines[0]
  else
    echo "Warning: Could not determine remote from '" . branch . "', assuming origin"
    let remote = "origin"
  endif
  let repo = systemlist("git config --get remote." . remote . ".url | sed 's/\.git$//' | sed 's_^git@\\(.*\\):_https://\\1/_' | sed 's_^git://_https://_'")[0]

  return repo
endfunction

function! s:revision()
  return systemlist("git rev-parse HEAD")[0]
endfunction

function! s:path()
  return systemlist("git ls-files --full-name " . @%)[0]
endfunction

function! s:lineAnchor(repo, first, last)
  let line = "#L" . a:first
  if a:first != a:last
    if a:repo=~#"gitlab"
      let line = line . "-" . a:last
    else
      let line = line . "-L" . a:last
    endif
  endif
  return line
endfunction

function! GitHubURLRepo()
  let url = s:repoURL()

  if has('clipboard')
    let @+ = url
  endif

  echomsg url
endfunction

function! GitHubURLBlob() range
  let repo = s:repoURL()
  let revision = s:revision()
  let path = s:path()
  let line = s:lineAnchor(repo, a:firstline, a:lastline)
  let url = repo . "/blob/" . revision . "/" . path . line

  if has('clipboard')
    let @+ = url
  endif

  echomsg url
endfunction

function! GitHubURLBlame() range
  let repo = s:repoURL()
  let revision = s:revision()
  let path = s:path()
  let line = s:lineAnchor(repo, a:firstline, a:lastline)
  let url = repo . "/blame/" . revision . "/" . path . line

  if has('clipboard')
    let @+ = url
  endif

  echomsg url
endfunction

command! GitHubURLRepo call GitHubURLRepo()

command! -range GitHubURL <line1>,<line2>call GitHubURLBlob()
command! -range GitHubURLBlob <line1>,<line2>call GitHubURLBlob()

command! -range GitHubURLBlame <line1>,<line2>call GitHubURLBlame()
