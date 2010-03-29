case node[:platform]
when "Ubuntu","Debian"
  set[:latex][:packages]=%w(tetex-bin tetex-extra latex-xcolor cm-super)
end
