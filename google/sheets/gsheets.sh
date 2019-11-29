#FACU#     =BUSCARV(Sede;SedesBD;2;0)
#APE#      =ESPACIOS(MAYUSC('APELLIDO/s'))
#NOM#      =ESPACIOS(NOMPROPIO('Nombre/s'))
#MAIL#     =ESPACIOS(MINUSC('Correo Electrónico'))
#INTEGR#   =ESPACIOS(TEXTJOIN(", ";1;TEXTJOIN(" ";1;NOMPROPIO('Nombre/s');MAYUSC('APELLIDO/s'));SI(O('Nombre/s'>0;'APELLIDO/s'>0);BUSCARV(Sede;SedesBD;2;0);"")))
#TELEFONO# =TEXTJOIN(" ";1;MAX(Prefijo);JOIN("-";IZQUIERDA('Teléfono';LARGO('Teléfono')-4);DERECHA('Teléfono';4)))

=ESPACIOS(Rol)
=MAX('Marca temporal')

TEXTJOIN(" ";1;Ape;Nom)

"https://docs.google.com/forms/d/e/1FAIpQLSfnJLKUAOQd7UaqME7Qhy0BND_XDjo6KPkgIHtp1ya0SouWyw/viewform?usp=pp_url
&entry.699500961="&ENCODEURL(Nom)&
"&entry.378696831="&ENCODEURL(Ape)&
"&entry.437451882="&Rol&
"&entry.114302368="&Sede&
"&entry.1988507996="&TelPre&
"&entry.1312060276="&TelNro&
"&entry.645287604="&Mail

=SI(Estad=5;0;Tarifa*Horas)


=TEXTJOIN(", ";1;TEXTJOIN(" ";1;I2;H2);G2)

SI(SI.ERROR(HALLAR(' ');0)>0;IZQUIERDA(I2;HALLAR(' '));I2)

="https://docs.google.com/forms/d/e/1FAIpQLSfnJLKUAOQd7UaqME7Qhy0BND_XDjo6KPkgIHtp1ya0SouWyw/viewform?usp=pp_url&entry."&JOIN("&entry.";("699500961="&ENCODEURL(Nom));("378696831="&ENCODEURL(Ape));("437451882="&Rol);("114302368="&Sede);("1988507996="&TelPre);("1312060276="&TelNro);("645287604="&Mail))

="https://docs.google.com/forms/d/e/1FAIpQLSfnJLKUAOQd7UaqME7Qhy0BND_XDjo6KPkgIHtp1ya0SouWyw/viewform?usp=pp_url&entry."&JOIN("&entry.";JOIN("=";"699500961";Nom);"378696831=Ape")

=SI(E2>0;HIPERVINCULO("https://docs.google.com/forms/d/e/1FAIpQLSfnJLKUAOQd7UaqME7Qhy0BND_XDjo6KPkgIHtp1ya0SouWyw/viewform?usp=pp_url"&
"&entry.378696831="&ENCODEURL(SI.ERROR(I2))&
"&entry.699500961="&ENCODEURL(SI.ERROR(#REF!))&
"&entry.114302368="&ENCODEURL(SI.ERROR(C2))&
"&entry.645287604="&ENCODEURL(SI.ERROR(L2))&
"&entry.1988507996="&SI.ERROR(D2)&
"&entry.1312060276="&SI.ERROR(E2)
;"※");"")