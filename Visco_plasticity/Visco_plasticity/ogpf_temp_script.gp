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
  0.000000000000000E+000  0.510000050067902     
  3.124999813735490E-002  0.510000050067902     
  6.249999627470970E-002  0.510000050067902     
  9.374999254941940E-002  0.510000050067902     
  0.000000000000000E+000  0.525000035762787     
  3.124999813735490E-002  0.525000035762787     
  6.249999627470970E-002  0.525000035762787     
  9.374999254941940E-002  0.525000035762787     
  0.000000000000000E+000  0.540000021457672     
  3.124999813735490E-002  0.540000021457672     
  6.249999627470970E-002  0.540000021457672     
  9.374999254941940E-002  0.540000021457672     
  0.000000000000000E+000  0.555000007152557     
  3.124999813735490E-002  0.555000007152557     
  6.249999627470970E-002  0.555000007152557     
  9.374999254941940E-002  0.555000007152557     
  0.000000000000000E+000  0.569999992847443     
  3.124999813735490E-002  0.569999992847443     
  6.249999627470970E-002  0.569999992847443     
  9.374999254941940E-002  0.569999992847443     
  0.000000000000000E+000  0.585000038146973     
  3.124999813735490E-002  0.585000038146973     
  6.249999627470970E-002  0.585000038146973     
  9.374999254941940E-002  0.585000038146973     
  0.000000000000000E+000  0.600000023841858     
  3.124999813735490E-002  0.600000023841858     
  6.249999627470970E-002  0.600000023841858     
  9.374999254941940E-002  0.600000023841858     
e
