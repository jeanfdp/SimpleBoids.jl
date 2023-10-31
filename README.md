# SimpleBoids

**SimpleBoids** is a Julia package for simulating the behavior of boids, which are agents that exhibit flocking behavior, inspired by the famous Boids algorithm. This package provides tools to simulate the movement and interaction of boids within a given environment.

## Features

- Simulate the behavior of boids in a 2D space.
- Specify the number of boids, simulation steps, environment size, and various parameters to control their behavior.
- Export simulation data for further analysis.

## Getting Started

To use the SimpleBoids package, you need to have Julia installed. If Julia is not installed, you can download it from the official website: [Julia Downloads](https://julialang.org/downloads/)

Once Julia is installed, you can follow these steps to use the package:

1. Include the SimpleBoids package in your Julia script or interactive session:

```julia
using SimpleBoids
```

2. Choose your parameters:

```

numboids=100
steps=1000
size=1000.
vel=2.
paramMaxRad=100.
paramMinRad=10.
paramPosWeight=0.04
paramRepWeight=0.15
paramVelWeight=0.04
```
Run the simulation, and extract the data you want:
```
states=SimpleBoids.runBoids(numboids,steps,size,vel,paramMaxRad,paramMinRad,paramPosWeight,paramRepWeight,paramVelWeight)
positions=[state.positions for state in states]
```

## Parameters

- `numboids`: The number of boids in the simulation.
- `steps`: The number of simulation steps to run.
- `size`: The size of the simulation environment (2D space).
- `vel`: The initial velocity of boids.
- `paramMaxRad`: The maximum radius for boid interactions.
- `paramMinRad`: The minimum radius before boids repel.
- `paramPosWeight`: Weight for position-based interactions.
- `paramRepWeight`: Weight for repulsion-based interactions.
- `paramVelWeight`: Weight for velocity-based interactions.

## Notes

- This package does not have external dependencies and can be used with a standard Julia installation.

- Make sure to adjust the parameters according to your specific use case and analysis requirements.

## License

This package is distributed under the [MIT License](LICENSE.md).

[![Build Status](https://github.com/jeanfdp/SimpleBoids.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/jeanfdp/SimpleBoids.jl/actions/workflows/CI.yml?query=branch%3Amaster)
