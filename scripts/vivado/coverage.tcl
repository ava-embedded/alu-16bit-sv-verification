##=============================================================================
## [Filename]       run.tcl
## [Project]        -
## [Author]         Luis Namigtle namigtle066@gmail.com
## [Language]       Tcl Scripting 
## [Created]        Sep 2025
## [Modified]       -
## [Description]    Custom Tcl script to make coverage
## [Notes]          -
## [Status]         stable
## [Revisions]      -
##=============================================================================

# Configurar directorio de cobertura
puts "I'm here"
set_property xsim.elaborate.coverage.dir ./ [get_filesets sim_1]

# Tipo de cobertura
set_property xsim.elaborate.coverage.type objects [get_filesets sim_1]

# Exportar reporte HTML
export_xsim_coverage -open_html true

# Guardar base de datos de cobertura
write_xsim_coverage -cov_db_name ./add_new_dir/add_new_cov_name



