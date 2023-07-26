require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'nameとbodyが入力されている場合' do
    let!(:article) do
      Article.new({ name: 'RSpecテスト', body: 'RSpecテストの内容' })
    end
    it '記事を保存できる' do
      expect(article).to be_valid
    end
  end
end
