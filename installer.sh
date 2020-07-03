BLACK='\e[0;30m'
RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
BLUE='\e[0;34m'
MAGENTA='\e[0;35m'
CYAN='\e[0;36m'
WHITE='\e[0;37m'
END_COLOR='\e[0m'

# BASIC SETUP TOOLS
msg() {
        printf $MAGENTA'%b\n'$END_COLOR "$1" >&2
}

success() {
        echo -e "$GREEN[✔]$END_COLOR ${1}${2}"
}

read -p "project name (default my-project): " name
read -p "Laravel version (default 6): " version

if [ -z $name ]; then
    name="my-project"
else
    name=$name
fi

if [ $version!"6" ] && [ $version!"7" ]; then
    version="6"
else
    version=$version
fi

echo -e "\n\n"
msg "Initializing Laravel project"
composer create-project laravel/laravel $name "${version}.*" --prefer-dist
cd ${name}

echo -e "\n\n"
msg "Installing composer packages..."
composer require laravel/socialite "laravel/ui:^1.2" balping/artisan-bash-completion deployer/deployer deployer/recipes barryvdh/laravel-ide-helper
php artisan ide-helper:generate
php artisan ide-helper:meta
dep init

echo -e "\n\n"
msg "Installing npm packages..."
npm init
npm i -S axios bootstrap laravel-mix browser-sync browser-sync-webpack-plugin cross-env jquery popper.js vue vue-axios @fortawesome/fontawesome-free laravel-mix-polyfill vue-toast-notification
npm i
npm audit fix

echo -e "\n\n"
msg "Set permissions..."
chmod 777 storage -R
chmod 777 bootstrap/cache -R

echo -e "\n\n\n"
success "Installation completed."
