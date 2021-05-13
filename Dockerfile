FROM elixir:alpine

ENV MIX_ENV=prod

ENV APP_HOME /app
RUN mkdir $APP_HOME

WORKDIR $APP_HOME

RUN apk update && \
    apk add git build-base nodejs nodejs nodejs-npm && \
    mix local.hex --force && \
    mix archive.install hex phx_new 1.5.8 --force && \
    mix local.rebar --force

COPY docker-entrypoint.sh /
ENTRYPOINT ["sh", "./docker-entrypoint.sh"]

CMD ["mix", "phx.server"]