module ApplicationHelper
  def default_meta_tags
    {
      site: 'もふは正義',
      title: 'もふもふ投稿サービス',
      reverse: true,
      charset: 'utf-8',
      description: 'もふもふの世界に浸りませんか？',
      keywords: '猫,犬,もふもふ,かわいい',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('logo_type.jpg'), # 配置するパスやファイル名によって変更すること
        local: 'ja-JP'
      },
      # Twitter用の設定を個別で設定する
      twitter: {
        card: 'summary_large_image', # Twitterで表示する場合は大きいカードにする
        site: '@mofu_is_justice', # アプリの公式Twitterアカウントがあれば、アカウント名を書く
        image: image_url('logo_type.jpg') # 配置するパスやファイル名によって変更すること
      }
    }
  end
end
