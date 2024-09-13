#!/bin/sh

echo "==> 📜 Installing Visual Studio Code"

brew install --cask visual-studio-code

echo "==> 📜 Installing Visual Studio Code extensions"

# Editor
# code --install-extension christian-kohler.npm-intellisense
# code --install-extension eamodio.gitlens
# code --install-extension mhutchie.git-graph
# code --install-extension EditorConfig.EditorConfig
# code --install-extension GitHub.vscode-pull-request-github
# code --install-extension GitHub.copilot
# code --install-extension keesschollaart.vscode-home-assistant
# code --install-extension mikestead.dotenv
# code --install-extension ninoseki.vscode-gem-lens
# code --install-extension shyykoserhiy.vscode-spotify
# code --install-extension streetsidesoftware.code-spell-checker
# code --install-extension tgreen7.vs-code-node-require
# code --install-extension vincaslt.highlight-matching-tag
# code --install-extension WakaTime.vscode-wakatime
# code --install-extension wix.vscode-import-cost
# code --install-extension gruntfuggly.todo-tree

# Languages
# code --install-extension bierner.lit-html
# code --install-extension bung87.vscode-gemfile
# code --install-extension digitalstreamio.mjml-syntax
# code --install-extension idleberg.applescript
# code --install-extension rebornix.ruby
# code --install-extension redhat.vscode-yaml
# code --install-extension csstools.postcss
# code --install-extension wingrunr21.vscode-ruby

# Linting
# code --install-extension DavidAnson.vscode-markdownlint
# code --install-extension dbaeumer.vscode-eslint
# code --install-extension esbenp.prettier-vscode
# code --install-extension kokororin.vscode-phpfmt
# code --install-extension stylelint.vscode-stylelint
# code --install-extension timonwong.shellcheck

# Themes
# code --install-extension enkia.tokyo-night

code --install-extension abusaidm.html-snippets
code --install-extension alfnielsen.vsc-rename-files
code --install-extension atipugin.rails-partial
code --install-extension bung87.vscode-gemfile
code --install-extension coenraads.bracket-pair-colorizer-2
code --install-extension dbankier.vscode-quick-select
code --install-extension editorconfig.editorconfig
code --install-extension formulahendry.auto-rename-tag
code --install-extension hookyqr.beautify
code --install-extension hridoy.rails-snippets
code --install-extension icrawl.discord-vscode
code --install-extension jduponchelle.rainbow-end
code --install-extension jeremyrajan.file-script-runner
code --install-extension kaiwood.endwise
code --install-extension khaeransori.json2csv
code --install-extension marioqueiros.camelcase
code --install-extension miguel-savignano.ruby-symbols
code --install-extension mohsen1.prettify-json
code --install-extension mrmlnc.vscode-duplicate
code --install-extension oderwat.indent-rainbow
code --install-extension phplasma.csv-to-table
code --install-extension rebornix.ruby
code --install-extension ritwickdey.liveserver
code --install-extension romanpeshkov.vscode-text-tables
code --install-extension shan.code-settings-sync
code --install-extension takezoe.vscode-csv-markdown
code --install-extension truman.autocomplate-shell
code --install-extension vortizhe.simple-ruby-erb
code --install-extension wingrunr21.vscode-ruby
code --install-extension wmaurer.change-case
code --install-extension zignd.html-css-class-completion
code --install-extension fnando.linter
code --install-extension dotjoshjohnson.xml
code --install-extension maptz.camelcasenavigation
code --install-extension adpyke.vscode-sql-formatter
code --install-extension groksrc.ruby
code --install-extension vincaslt.highlight-matching-tag
code --install-extension anderseandersen.html-class-suggestions
code --install-extension lorankloeze.ruby-rubocop-revived
code --install-extension kevinrose.vsc-python-indent
code --install-extension letmaik.git-tree-compare
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension donjayamanne.python-environment-manager
code --install-extension idleberg.applescript
code --install-extension 2gua.rainbow-brackets
code --install-extension 4ops.terraform
code --install-extension castwide.solargraph
code --install-extension formulahendry.auto-close-tag
code --install-extension yzhang.markdown-all-in-one
code --install-extension thadeu.vscode-run-rspec-file
code --install-extension sandcastle.vscode-open
code --install-extension atlassian.atlascode
code --install-extension tonka3000.raycast
code --install-extension rioj7.html-related-links
code --install-extension shd101wyy.markdown-preview-enhanced
code --install-extension formulahendry.code-runner
code --install-extension timonwong.shellcheck
code --install-extension zhuangtongfa.material-theme
code --install-extension fabiospampinato.vscode-open-in-finder
code --install-extension robocorp.robocorp-code
code --install-extension mechatroner.rainbow-csv
code --install-extension mateuszdrewniak.ruby-test-runner
code --install-extension github.vscode-github-actions
code --install-extension redhat.vscode-yaml
code --install-extension alexkrechik.cucumberautocomplete
code --install-extension molunerfinn.revealfileinfolder
code --install-extension vmware.vscode-manifest-yaml
code --install-extension ecmel.vscode-html-css
code --install-extension circleci.circleci
code --install-extension janisdd.vscode-edit-csv
code --install-extension ms-python.debugpy
code --install-extension pjmiravalle.terraform-advanced-syntax-highlighting
code --install-extension hashicorp.terraform
code --install-extension ms-python.debugpy
code --install-extension uctakeoff.vscode-counter
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-python.python
code --install-extension esbenp.prettier-vscode
code --install-extension github.copilot-chat
code --install-extension petli-full.json-to-yaml-and-more
code --install-extension ms-python.vscode-pylance
code --install-extension aliariff.vscode-erb-beautify
code --install-extension amazonwebservices.aws-toolkit-vscode
code --install-extension danielsanmedium.dscodegpt
code --install-extension github.copilot
code --install-extension eamodio.gitlens

echo "==> 🔗 Symlinking Visual Studio Code settings"

ln -s ~/projects/personal/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -s ~/projects/personal/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
ln -s ~/projects/personal/dotfiles/vscode/syncLocalSettings.json ~/Library/Application\ Support/Code/User/syncLocalSettings.json
