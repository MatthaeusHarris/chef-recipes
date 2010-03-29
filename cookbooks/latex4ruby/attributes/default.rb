case node[:platform]
when "ubuntu","debian"
  set[:latex][:packages]=%w(tetex-bin tetex-extra latex-xcolor cm-super)
end
