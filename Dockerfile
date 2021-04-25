# FROM elixir:alpine

# #ENV MIX_ENV=prod

# ENV APP_HOME /opt/app
# RUN mkdir $APP_HOME
# WORKDIR $APP_HOME

# RUN apk update && \
#     apk add git build-base nodejs nodejs nodejs-npm && \
#     mix local.hex --force && \
#     mix archive.install hex phx_new 1.5.8 --force && \
#     mix local.rebar --force

# COPY mix.* ./
# RUN mix do deps.get, deps.compile

# CMD ["mix", "deps.get"]
# CMD ["mix", "phx.server"]

FROM elixir:latest

ENV MIX_ENV=prod

RUN apt-get update && \
    apt-get install -y inotify-tools && \
    apt-get install -y nodejs && \
    curl -L https://npmjs.org/install.sh | sh && \
    mix local.hex --force && \
    mix archive.install hex phx_new 1.5.8 --force && \
    mix local.rebar --force

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

CMD ["mix", "deps.get"]
CMD ["mix", "phx.server"]