/**
Esta función lee datos de una hoja de cálculo que contiene el nombre del proyecto y los dos URLs que buscamos: repo y web, en las columnas 1, 3 y 19 de la hoja de cálculo (respuestas a un formulario en Google Spreadsheet). Los escribe en tres columnas de otra hoja de cálculo, previo borrado de la misma
Funciona con Herramientas->Editor de secuencias de comandos. La primera vez que lo ejecutes sobre una hoja de cálculo tendrás que autorizarla. Aparte, hay que crear una segunda hoja de cálculo resumen y copiar el id para sustituir donde pone *unIdCualquiera*
El resultado de la ejecución está aquí: https://docs.google.com/spreadsheets/d/1RE2yPUs67D2AsQuo59Pj5ROSB3_4WTKqF0HmN3gupRw/edit?usp=sharing
 */
function summarize_projects() {
  var sheet = SpreadsheetApp.getActiveSheet();
  var output_sheet = SpreadsheetApp.openById("unIdCualquiera")
  var rows = sheet.getDataRange();
  var numRows = rows.getNumRows();
  var values = rows.getValues();

  // Delete output.
  var output_range = output_sheet.getDataRange().getNumRows();
  Logger.log(output_range);
  output_sheet.deleteRows(1, output_range);
  for (var i = 1; i < numRows; i++) {
    output_sheet.appendRow([values[i][1],values[i][3],values[i][19]]);
  }
};

/**
 * Este trigger añade un elemento llamado "Programillas" a la hoja de cálculo al abrirla.
 */
function onOpen() {
  var spreadsheet = SpreadsheetApp.getActiveSpreadsheet();
  var entries = [{
    name : "Resume proyectos",
    functionName : "summarize_projects"
  }];
  spreadsheet.addMenu("Programillas", entries);
};