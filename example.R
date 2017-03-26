## LOADING FUNCTION FROM WORKING DIRECTORY ##
# The following function returns a DF that contains points (with two coords) on 
# a circle with radius r that no two points is closer to each other than d
unif_circle <- dget(file = 'unif_circle.R')

# The following function returns a DF that contains ‘sample_size’ points (with 
# two coords) on a circle with radius r that no two points is closer to each 
# other than d given initial set of points that is on the disk (initial)
gibbs_sampler <- dget(file = 'gibbs_sampler.R')

## PARAMETERS ##
# the amount of declined points on initialization. The higher threshold 
# the lower \beta = P[no two points are within d of each other]
threshold <- 10000
# the lowest distance between neighbours
d <- 1 / 10
# number of suggested points in the gibbs sampler
sam_size <- 20

## INITIALIZING ##
init <- unif_circle(threshold = threshold, d = d)

## SAMPLING ##
smpl <- gibbs_sampler(sample_size = sam_size, r = 1, initial = init)

## PLOT RESULTS ##
# plots the initial points (red)
plot(init, pch = 20, cex = 0.7, asp = 1, col = rgb(1, 0, 0, alpha = 0.3),
     xlim = c(-1.2, 1.2), ylim = c(-1.2, 1.2))
# add the generated ones to the plot (blue)
points(smpl, pch = 20, cex = 0.7, asp = 1, col = rgb(0, 0, 1, alpha = 0.3))

# also draw the neighourhoods for each point for initial set and gerenated
symbols(x = init$x1, y = init$x2, circles = rep(d / 2, nrow(init)), 
        inches = F, add = T, fg = rgb(1, 0, 0, alpha = 0.3))
symbols(x = smpl$x1, y = smpl$x2, circles = rep(d / 2, nrow(smpl)), 
        inches = F, add = T, fg = rgb(0, 0, 1, alpha = 0.3))

# add legend
legend(x = 'topright', c('Initial', 'New'), 
       col = c(rgb(1, 0, 0, alpha = 0.3), rgb(0, 0, 1, alpha = 0.3)),
       pch = c(20, 20), pt.bg = c('red', 'blue'))