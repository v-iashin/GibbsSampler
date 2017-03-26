# The function returns a DF that contains ‘sample_size’ points (with 
# two coords) on a circle with radius r that no two points is closer to each 
# other than d given initial set of points that is on the disk (initial)

function(sample_size, r, initial) {
    # reassign initial set to some var
    df <- initial
    # number of elements in the set
    n <- nrow(initial)
    
    # dummy DF that we expect to be filled with sampled points
    sampled <- data.frame(x1 = NA, x2 = NA)
    # iterate until we sample the needed amount of points 
    # (+ 1 because it already has one row with NA's which will be deleted)
    while (nrow(sampled) < sample_size + 1) {
        
        # a random unif value
        U <- runif(n = 1)
        # calculate 'I' which is the index that we exclude from 
        idx <- as.integer((n - 1) * U) + 1
        
        # generate two coordinates for a suggested point on a disk w/ radius r
        x1 <- runif(n = 1, min = -r, max = r)
        x2 <- runif(n = 1, min = -r, max = r)
        
        # boolean weither the suggested point is on the disk
        in_circle <- sqrt(x1^2 + x2^2) <= r
        
        # if it is on the disk
        if (in_circle) {
            # the neibourhood of the point with 'idx' index in 'df'
            # the 'df' is rbinded with 'sampled' because the 'sampled' points 
            # should not be within the neibourhood with other 'sampled' points
            nighbours <- rbind(df[-idx, ], sampled)
            
            # calculate all distances between the suggested point and all points
            # except the one that is in idx, i. e. I
            neib_dist <- sqrt(abs(x1 - nighbours$x1)^2 + abs(x2 - nighbours$x2)^2)
            # calculate the num of points that is closer than d to the new point
            neib_numb <- sum(neib_dist < d, na.rm = TRUE)
            # boolean whether the suggested point has no points that is closer
            # than d to the new point or the suggested point is the first in DF
            no_neibor <- (neib_numb == 0) | is.na(neib_numb)
            
            # if the point does not have any neighbours
            if (no_neibor) {
                # add the suggested point to sample df
                sampled <- rbind(sampled, c(x1, x2))
            }
        }
    }
    # Delets 1st row. The 'sampled' was initiated with one row that has two NAs
    sampled <- sampled[-1, ]
    # reset the indexing (it is 2..n) --> 1..n
    rownames(sampled) <- NULL
    return(sampled)
}