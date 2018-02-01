Vim plugin to show GitHub URLs in source files

## Usage

In Vim, run:

```
:GitHubURL
```

And it will use `echomsg` to print the URL to the screen, such as:

https://github.com/pgr0ss/vim-github-url/blob/b8607965090cbbfafcdfc9df25be8a975b330504/plugin/github-url.vim#L6-L6

You can also visually select several lines and the URL will include the range.

If you want to see previous URLs, you can use `:messages`.

## Setup

Using [vim-plug](https://github.com/junegunn/vim-plug):
```vim
Plug 'pgr0ss/vim-github-url'
```