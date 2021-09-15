#!/bin/sh

# 本番環境のときだけ実行したい　環境ごとにDockerfileを分けるやり方もある
if [ "${RAILS_ENV}" = "production" ]
then
    # Railsでのお作法で、本番では固めて必要がある
    bundle exec rails assets:precompile
fi

# Railsサーバを起動する。環境変数でポートを渡すこともできる
bundle exec rails s -p ${PORT:-3000} -b 0.0.0.0
