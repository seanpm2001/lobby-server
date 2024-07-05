# lobby-server


## Building


### Before Starting

Need to add github access token.

Create file (or append to):  `~/.gradle/gradle.properties`, the following:

```
triplea.github.username=CHANGE_ME
triplea.github.access.token=CHANGE_ME
```

[Create a personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-personal-access-token-classic)




## Building

```
./verify.sh
```

## Running (from source)

```
./gradlew shadowJar
docker compose up
```

Lobby will be running on localhost with a random port number

(TODO: add env variable so we can do something like: `LOBBY_PORT=8080 docker compose up`)

## Running


```
docker pull ghcr.io/triplea-game/lobby:latest
docker run -e DB_URL="localhost:5432/lobby_db" --network host ghcr.io/triplea-game/lobby
```


