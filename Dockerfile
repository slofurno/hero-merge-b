FROM elixir:latest

RUN apt-get update \
  && apt-get install -y --no-install-recommends jq dnsutils \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app

COPY . /app
WORKDIR /app

ENV MIX_ENV="prod"

RUN dig -t ANY hex.pm > /dev/null
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get

RUN mix compile

CMD ["sh", "start.sh"]
