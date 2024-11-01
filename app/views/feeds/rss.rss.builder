# apple guidelines: https://help.apple.com/itc/podcasts_connect/#/itcb54353390
#
xml.instruct! :xml, :version => "1.0", encoding: "UTF-8"
xml.rss :version => "2.0", 
  "xmlns:atom" => "http://www.w3.org/2005/Atom", 
  "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd", 
  "xmlns:podcast" => "https://podcastindex.org/namespace/1.0",
  "xmlns:content" => "http://purl.org/rss/1.0/modules/content/" do

  xml.channel do
    # RSS required channel tags
    xml.title "Key Pair"
    xml.link "https://www.keypair.fm"
    xml.description "Two developers exploring Bitcoin, Lightning, and Nostr to build user-empowering apps."
    xml.image do
      xml.link "https://www.keypair.fm"
      xml.title "Key Pair"
      xml.url "https://www.keypair.fm/poster.png"
    end

    # RSS optional channel tags
    xml.language "en-us"
    xml.copyright do
      xml.cdata! "Key Pair"
    end
    xml.managingEditor "hello@keypair.fm (Rob)"
    xml.webMaster "peter@marcano.io (Pete)"
    xml.lastBuildDate @episodes.last.published_at.to_fs(:rfc822) || DateTime.now.to_fs(:rfc822)
    xml.category "Technology"
    xml.ttl 60

    # Apple required channel tags
    xml.itunes :image, href: "https://www.keypair.fm/poster.png"
    xml.itunes :category, :text => "Technology"
    xml.itunes :explicit, "true" 

    # Apple recommended channel tags
    xml.itunes :author, "Pete Marcano & Rob Redacted"
    xml.itunes :owner do
      xml.itunes :email, "peter@marcano.io"
    end

    xml.atom :link, href: url_for(controller: :feeds, action: :rss, only_path: false), rel: "self", type: "application/rss+xml"
    xml.podcast :guid, "https://media.keypair.fm/feed"

    @episodes.each do |episode|
      xml.item do
        # Apple required item tags
        xml.title episode.title
        xml.enclosure(
          url: rails_blob_url(episode.audio, disposition: "inline"), 
          length: episode.audio.byte_size, 
          type: episode.audio.content_type
        )

        xml.guid episode_url(episode)
        xml.description episode.description
        xml.content :encoded do
          xml.cdata! sanitize(episode.show_notes)
        end

        # Apple recommended item tags
        xml.pubDate episode.published_at.to_fs(:rfc822)
        xml.itunes :explicit, episode.explicit?
        xml.itunes :duration, episode.duration if episode.duration.present?
        xml.link episode_url(episode)
        # xml.itunes :image, href: "https://www.keypair.fm/public/episode2.jpg" # 1400x1400 - 3000x3000 episode artwork. jpg or png
      end
    end
  end
end
