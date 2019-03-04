rem rmBootWX.cmd: Lista de comandos para generar un pendrive booteable de windows 10.
diskpart 
  list disk
  select disk 1
  clean
  create partition primary
  select partition 1
  active
  format fs=ntfs label=RM-WX quick
  assign
  exit

xcopy e:\*.* /s/e/f f:\
