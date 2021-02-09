This is the minimal extension - it uses pathogen and a limited number
of extra packages - in this case:

* vim commentary

To conigure the `vim` directory, use:

```
mkdir -p vim/autoload vim/bundle && curl -LSso vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
```

The go to `vim/bundle` and run:

```
git clone https://github.com/tpope/vim-commentary
```
