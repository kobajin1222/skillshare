module ArticlesHelper
  # def render_with_hashtags(hashtag)
    # hashtag.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/articles/hashtag/#{word.delete("#")}"}.html_safe
  # end
  
  def render_with_hashtags(content)
    new_content = content
    hashtags = content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.each do |h|
      hashtag = Hashtag.find_by(hashname: h.delete("#"))
      change_content = new_content.gsub(h){link_to h, "/articles/hashtag/#{hashtag.id}"}.html_safe
      new_content = change_content
    end
    return new_content
  end
end
