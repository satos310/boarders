# frozen_string_literal: true

module Public::ReviewsHelper
  def render_with_hashtags(hashbody)
    hashbody.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/) { |word| link_to word, "/review/hashtag/#{word.delete("#")}", data: { "turbolinks" => false } }.html_safe
  end
end
