# The function returns a DF that contains points (with two coords) on 
# a circle with radius r that no two points is closer to each other than d

function(threshold = 10000, r = 1, d = 0.1) {
    # dummy for DF that will contain the coordinates for points
    df <- data.frame(x1 = NA, x2 = NA)
    
    # counter for the num of times new suggested points were declined
    skipped <- 0
    # run while the number of rejections is lower than given threshold
    while (skipped < threshold) {
        # in order to present points on a circle, first, we sample two points
        # distributed uniformly then we choose only ones that are in the circle
        x1 <- runif(n = 1, min = -r, max = r)
        x2 <- runif(n = 1, min = -r, max = r)
        
        # boolen whether point w/ coordinates x1 and x2 lies on a disk
        in_circle <- sqrt(x1^2 + x2^2) <= r
        
        # if the point does lie on a dist
        if (in_circle) {
            # calculate the distances between each point and the suggested one
            neib_dist <- sqrt(abs(x1 - df$x1)^2 + abs(x2 - df$x2)^2)
            # calculate the num of points that is closer than d to the new point
            neib_numb <- sum(neib_dist < d, na.rm = TRUE)
            # boolean whether the suggested point has no points that is closer
            # than d to the new point or the suggested point is the first in DF
            no_neibor <- (neib_numb == 0) | is.na(neib_numb)
            
            # if the point does not have any neighbours
            if (no_neibor) {
                # add the suggested point to DF
                df <- rbind(df, c(x1, x2))
                # reset the counter
                skipped <- 0
                # if it already has a neighbouring point
            } else {
                # add to counter
                skipped <- skipped + 1
            }
        }
    }
    # reset the indexing (it is 2..n) --> 1..n
    df <- df[-1, ]
    rownames(df) <- NULL
    
    return(df)
}