require 'sinatra/base'
require 'ostruct'
require 'time'
require 'yaml'
require 'json'
require 'open-uri'

class Blog < Sinatra::Base
  set :root, File.expand_path('../../', __FILE__)
  set :articles, []
  set :app_file, __FILE__
  set :haml, :ugly=>true

  Dir.glob "#{root}/articles/*.md" do |file|
    meta, content = File.read(file).split("\n\n", 2)
    article = OpenStruct.new YAML::load(meta)
    article.date = Time.parse article.date.to_s
    article.content = content
    article.slug = File.basename(file, '.md')

    unless content.include? "---cy---"
      get "/#{article.slug}" do
        haml :post, :locals => { :article => article }
      end
    else
      en, cy = content.split("\n\n---cy---\n\n")
      article.cy = cy
      article.en = en
      get "/#{article.slug}" do
        haml :post_bi, :locals => { :article => article }
      end
    end


    articles << article
  end

  articles.sort_by! {|article| article.date}
  articles.reverse!

  get '/' do
    pier = JSON.parse(open('http://www.pieratnine.com/json').read)
    pier.each{|x| x["blog"] = 'pier';x["site"]="http://www.pieratnine.com"}
    sa = get_json
    sa.each{|x| x["blog"] = 'sa'; x["site"]="/blog"; x["date"] = x["date"].to_s}
    @articles = (pier + sa).sort_by{|k| k["date"] }.reverse
    haml :blog
  end

  get '/rss' do
    content_type 'application/rss+xml'
    haml :rss, :format => :xhtml, :escape_html => true, :layout => false
  end

  def get_json
    settings.articles.map do |article|
      {
        "title" => article.title,
        "date" => article.date,
        "slug" => article.slug,
        "summary" => article.summary
      }
    end
  end

  get '/json' do
    content_type 'application/json'
    json = get_json.to_json
  end
end
