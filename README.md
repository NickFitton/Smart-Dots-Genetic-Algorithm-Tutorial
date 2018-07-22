# Smart Dots Genetic Algorithm
## Content
## Entity
An `Entity` is a base class for most drawn objects, entities can either be an `ELLIPSE` or a `RECT`.
Entities control how they are drawn.
## Dot
A `Dot` is a class that extends the `Entity` class, it can move around and dies if it hits an obstacle or goes out of bounds. It also has a `Brain` which tells it which direction to accelerate in.
## Brain
A `Brain` has a list of directions, it can also mutate which slightly changes the directions which is part of natural selection.
## Population
A `Population` has an array of Dots it keeps track of Dot fitness and triggers generation steps and Brain mutations.
