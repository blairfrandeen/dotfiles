#!/usr/bin/env fish
function claude
    docker exec -it pi-agent pi -p --no-session --model anthropic/claude-haiku-4-5:off $argv
end
