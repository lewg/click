# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://click.goettner.net"
SitemapGenerator::Sitemap.include_root = false

SitemapGenerator::Sitemap.add_links do |sitemap|
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: sitemap.add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  # 
  # 
  # Examples:
  # 
  # Add '/articles'
  #   
  #   sitemap.add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add individual articles:
  #
  #   Article.find_each do |article|
  #     sitemap.add article_path(article), :lastmod => article.updated_at
  #   end
  
  images = []
  Photo.find(:all, :order => 'taken_on DESC').each do |photo|
    images << { 
      :loc => photo.image.url(:display), 
      :title => photo.name, 
      :caption => photo.description,
      :license => 'http://creativecommons.org/licenses/by-nc-sa/3.0/'
    }
  end
  sitemap.add(root_path, :lastmod => Time.now, :changefreq => 'always', :priority => 1.0, :images => images)
  
end