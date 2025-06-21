local pwd = arg[1]
function prefix_if(prefix,pat,str)
    local match = str:match(pat)
    if match then
        return prefix .. match
    end
    return str
end
pwd = prefix_if('~',os.getenv("HOME") .. '(.*)',pwd)
pwd = prefix_if(' ','^~/codec/(.*)',pwd)
pwd = prefix_if(' ','^~/code/(.*)',pwd)
pwd = prefix_if(' ','^~/.local/share/nvim/lazy/(.*)',pwd)
pwd = prefix_if(' ','^~/.config/nvim/lua/(.*)',pwd)
pwd = prefix_if(' ','^~/.config/(.*)',pwd)

print(pwd)
