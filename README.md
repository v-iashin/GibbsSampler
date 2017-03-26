# Gibbs Sampler in R

![My image](https://raw.githubusercontent.com/vdyashin/GibbsSampler/master/gibbs_sampler_plot.png)

### Problem Statement
_(Ross, p. 252)_
Suppose we want to generate `n` random points in the circle of radius `r` centered at the origin, conditional on the event that no two points are within a distance `d` of each other, where

<a href="https://www.codecogs.com/eqnedit.php?latex=\beta&space;=&space;P\{\text{no&space;two&space;points&space;are&space;within&space;d&space;of&space;each&space;other}\}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\beta&space;=&space;P\{\text{no&space;two&space;points&space;are&space;within&space;d&space;of&space;each&space;other}\}" title="\beta = P\{\text{no two points are within d of each other}\}" /></a>

is assumed to be a small positive number. (If <a href="https://www.codecogs.com/eqnedit.php?latex=\beta" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\beta" title="\beta" /></a> were not small, then we could just continue to generate sets of `n` random points in the circle, stopping the first time that no two points in the set are within `d` of each other.)

### Algorithm
1. Start with `n` points in the circle, <a href="https://www.codecogs.com/eqnedit.php?latex=x_1,&space;x_2,&space;\dots,&space;x_n" target="_blank"><img src="https://latex.codecogs.com/gif.latex?x_1,&space;x_2,&space;\dots,&space;x_n" title="x_1, x_2, \dots, x_n" /></a>, such that no two are within a distance `d` of each other.
2. Then generate a random number `U` and let <a href="https://www.codecogs.com/eqnedit.php?latex=I&space;=&space;\text{Int}(nU)&space;&plus;&space;1" target="_blank"><img src="https://latex.codecogs.com/gif.latex?I&space;=&space;\text{Int}(nU)&space;&plus;&space;1" title="I = \text{Int}(nU) + 1" /></a>.
3. Generate a random point in the circle.
4. If this point is not within `d` of any of the other `n - 1` points excluding <a href="https://www.codecogs.com/eqnedit.php?latex=X_I" target="_blank"><img src="https://latex.codecogs.com/gif.latex?X_I" title="X_I" /></a> then replace <a href="https://www.codecogs.com/eqnedit.php?latex=X_I" target="_blank"><img src="https://latex.codecogs.com/gif.latex?X_I" title="X_I" /></a> by this generated point; otherwise, generate a new point and repeat the operation.
5. After a large number of iterations, the set of `n` points will approximately have the desired distribution.

### Repository Files
- `unif_circle.R` the function that implements the first step of the algorithm (initialization);
- `gibbs_sampler.R` the function that does the rest of the algorithm steps;
- `example.R` contains the code that implements the algorithm given some arbitrary parameters;
- `gibbs_sampler_plot.png` illustrates the results of the algorithm (see the construction in `example.R`).
