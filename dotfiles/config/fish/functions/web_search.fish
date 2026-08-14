# functions/web_search.fish
# mirrors: dotfiles/zsh.conf.d/web-search.plugin.zsh

function web_search --description "Search the web from the terminal"
    switch "$argv[1]"
        case google
            set url "https://www.google.com/search?q="
        case bing
            set url "https://www.bing.com/search?q="
        case yahoo
            set url "https://search.yahoo.com/search?p="
        case duckduckgo
            set url "https://www.duckduckgo.com/?q="
        case startpage
            set url "https://www.startpage.com/do/search?q="
        case yandex
            set url "https://yandex.ru/yandsearch?text="
        case github
            set url "https://github.com/search?q="
        case baidu
            set url "https://www.baidu.com/s?wd="
        case ecosia
            set url "https://www.ecosia.org/search?q="
        case goodreads
            set url "https://www.goodreads.com/search?q="
        case qwant
            set url "https://www.qwant.com/?q="
        case givero
            set url "https://www.givero.com/search?q="
        case stackoverflow
            set url "https://stackoverflow.com/search?q="
        case wolframalpha
            set url "https://www.wolframalpha.com/input/?i="
        case archive
            set url "https://web.archive.org/web/*/"
        case scholar
            set url "https://scholar.google.com/scholar?q="
        case '*'
            echo "Search engine '$argv[1]' not supported."
            return 1
    end

    if test (count $argv) -gt 1
        # search: join the terms with '+' and append to the engine url
        set url "$url"(string join '+' $argv[2..-1])
    else
        # no terms: go to the engine's main page (protocol + domain)
        set -l parts (string split -n '/' $url)
        set url (string join '//' $parts[1] $parts[2])
    end

    open_command $url
end
