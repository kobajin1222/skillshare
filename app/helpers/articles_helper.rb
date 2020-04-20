module ArticlesHelper
  def render_with_hashtags(hashtag)
    hashtag.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/articles/hashtag/#{word.delete("#")}"}.html_safe
  end
end
