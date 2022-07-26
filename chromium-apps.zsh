#!/bin/sh

gcolab(){
    chromium --user-data-dir=$HOME/.config/colabapp --app=https://colab.research.google.com/ --enable-desktop-pwas-app-icon-shortcuts-menu-ui --force-app-mode &|
}
