case node[:glpi][:selected]
when 'grey'
  default[:glpi][:theme][:url] = "https://sites.google.com/site/airtecmx/glpi---skins/greyskinforglpi084-includesimagesscriptsandcssfiles-/grey.skin.zip\?attredirects=0\&d=1"
  default[:glpi][:theme][:name] = 'grey.skin'
when 'black'
  default[:glpi][:theme][:url] = "https://sites.google.com/site/airtecmx/glpi---skins/blackgreenskinforglpi084/BlackGreen.zip\?attredirects=0\&d=1"
  default[:glpi][:theme][:name] = 'BlackGreen'
end
