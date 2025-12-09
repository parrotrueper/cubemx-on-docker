# Run STM32CubeMX on Docker

## CubeMx version

`en.stm32cubemx-lin-v6-16-0.zip`

## Docker Hub

```shell
docker pull parrotrueper/stm32cubemx:v6-16
```

## Building from scratch

Download `stm32cubemx-lin-v6-16-0.zip` to ./docker-data then run

```shell
./build-docker-img
```

## Run CubeMx from a container

```shell
./run-container
```

Inside the container run:

```shell
stm32cubemx&
```
