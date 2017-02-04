api_key=$(curl -sL https://hero-merge.herokuapp.com/getApiKey | jq .apiKey | sed 's/\"//g')

export HERO_MERGE_KEY=$api_key

exec mix run --no-halt
