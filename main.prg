CLEAR

DO XMLExporter.prg
DO JsonExporter.prg

LOCAL tabledb, xmlFile, jsonFile
tabledb = "movimien.dbf"
xmlFile = "movimien.xml"
jsonFile = "movimien.json"

exportToXML(tabledb, xmlFile)
? "XML Exported"
exportToJSON(tabledb, jsonFile)
? "JSON Exported"