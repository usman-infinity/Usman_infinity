# install.packages("ggplot2")  # Uncomment if not installed
library(ggplot2)
data(mpg)  # Load the mpg dataset
head(mpg)  # Preview: displ, hwy, class, etc.
# 2. Basic ggplot2: Initializing a plot
# Blank plot with data and aesthetics
ggplot(mpg, aes(x = displ, y = hwy))
# 3. Adding a geom (scatterplot)  
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point()
# 4. Adding a statistical transformation (smooth trend line)
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth(method = "loess")  # loess = local regression
# 5. Customizing with a color scale (categorical)
ggplot(mpg, aes(x = displ, y = hwy, color = class)) + 
  geom_point() + 
  scale_color_brewer(palette = "Set2")  # Brewer palette for colors
# 6. Coordinate system: Flipped bar chart
ggplot(mpg, aes(x = factor(cyl), y = hwy , color=cyl , fill=cyl)) + 
  geom_bar(stat = "summary", fun = "mean") +
coord_flip()  # Mean hwy per cylinder

# 7. Polar coordinates for a pie-like chart
ggplot(mpg, aes(x = factor(1), fill = factor(cyl))) + 
  geom_bar(width = 1) + 
  coord_polar(theta = "y")
# 8. Faceting by class      
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  facet_wrap(~ class)
# 9. Applying a theme and labels
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  theme_minimal() + 
  labs(title = "Engine Size vs Highway MPG", x = "Engine Displacement (L)", y = "Highway Miles per Gallon")
# 10. Building a complex plot iteratively with mpg dataset
# Step 1: Initialize
p <- ggplot(mpg, aes(x = displ, y = hwy))  # displ: engine size, hwy: highway mpg
p  # Blank canvas
# Step 2: Add scatter points
p <- p + geom_point()
p
# Step 3: Add color by class
p <- ggplot(mpg, aes(x = displ, y = hwy, color = class)) + geom_point()
p
# Step 4: Add smooth trend
p <- p + geom_smooth(method = "loess")
p
# Step 5: Apply theme and labels
p <- p + theme_minimal() + 
  labs(title = "Engine Size vs Highway MPG by Class", x = "Engine Displacement (L)", y = "Highway Miles per Gallon")
p
# Note: Each step builds upon the previous one, allowing for iterative refinement of the plot.
# The final plot visualizes the relationship between engine size and highway MPG, colored by vehicle class, with a smooth trend line and minimal theme for clarity.
