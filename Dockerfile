FROM ruby:2.7

#デフォルトの実行環境を本番環境に設定しておく
ENV RAILS_ENV=production

#nodejs とyarnライブラリをインストールする
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg| apt-key add - \
&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
&& apt-get update -qq \
&& apt-get install -y nodejs yarn
#作業ディレクトリの指定
WORKDIR /app
#ローカルのソースをコピーしておく
COPY ./src /app
#Ruby関連のGemファイルをインストールする
RUN bundle config --local set path 'vendor/bundle' \
  && bundle install

# ルートディレクトリにコピーする
COPY start.sh /start.sh
# 実行権限を持たす
RUN chmod 744 /start.sh
# シェルを実行する
CMD ["sh", "/start.sh"]