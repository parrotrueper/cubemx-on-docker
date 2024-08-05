# Run STM32CubeMX on Docker


# CubeMx version

`en.stm32cubemx-lin-v6-12-0.zip`

# Docker Hub

```bash
docker pull parrotrueper/stm32cubemx
```

# Building from scratch

Download `en.stm32cubemx-lin-v6-12-0.zip` to ./docker-data then run

```bash
./build-docker-img
```

# Run CubeMx from a container

```bash
./run-container
```

Inside the container run:

```bash
stm32cubemx&
```

