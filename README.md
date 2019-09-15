Vim plugin to show GitHub (and now GitLab) URLs in source files.

The generated URLs reference the current commit and not the current branch, so it will not be affected by later commits (e.g. you send someone the URL for a branch and by the time they click the link it's pointing to the wrong line in the file).

## Usage

In Vim, run:

- `:GitHubURLRepo` to view the repo on GitHub
- `:GitHubURLBlob` to view the file under cursor on GitHub
- `:GitHubURLBlame` to view the file under cursor in a git blame on GitHub

And it will use `echomsg` to print the URL to the screen, such as:

https://github.com/pgr0ss/vim-github-url/blob/b8607965090cbbfafcdfc9df25be8a975b330504/plugin/github-url.vim#L6-L6

You can also visually select several lines and the URL will include the range.

If you want to see previous URLs, you can use `:messages`.

## Setup

Using [vim-plug](https://github.com/junegunn/vim-plug):
```vim
Plug 'pgr0ss/vim-github-url'
```
