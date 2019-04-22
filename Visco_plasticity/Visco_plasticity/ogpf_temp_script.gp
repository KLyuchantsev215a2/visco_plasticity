# ogpf libray
# Rev. 0.22 of March 9th, 2018
# Licence: MIT

# gnuplot global setting
set term wxt size 640,480 enhanced font "verdana,10" title "ogpf libray: Rev. 0.22 of March 9th, 2018"

# ogpf extra configuration
# -------------------------------------------
# color definitions
set style line 1 lc rgb "#800000" lt 1 lw 2
set style line 2 lc rgb "#ff0000" lt 1 lw 2
set style line 3 lc rgb "#ff4500" lt 1 lw 2
set style line 4 lc rgb "#ffa500" lt 1 lw 2
set style line 5 lc rgb "#006400" lt 1 lw 2
set style line 6 lc rgb "#0000ff" lt 1 lw 2
set style line 7 lc rgb "#9400d3" lt 1 lw 2

# Axes
set border linewidth 1.15
set tics nomirror

# grid
# Add light grid to plot
set style line 102 lc rgb "#d6d7d9" lt 0 lw 1
set grid back ls 102

# plot style
set style data linespoints

# -------------------------------------------

 
# options
set style data linespoints
set xrange[-0.1:1.3]
set yrange [-0.1:0.8]


 
# plot scale
 
# Annotation: title and labels
set title "Example 1"
set xlabel "x [mm]"
set ylabel "y [mm]"
 
# axes setting

plot "-" title "square coordinates" with points lt 6 lc rgb "#000000"
  0.723684132099152       0.000000000000000E+000
  0.789473652839661       0.000000000000000E+000
  0.855263113975525       0.000000000000000E+000
  0.921052575111389       0.000000000000000E+000
  0.986842036247253       0.000000000000000E+000
   1.05263149738312       0.000000000000000E+000
   1.11842095851898       0.000000000000000E+000
   1.18421053886414       0.000000000000000E+000
   1.24999988079071       0.000000000000000E+000
e
