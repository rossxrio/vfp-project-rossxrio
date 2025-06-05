PROCEDURE exportToJSON(tableName, outputFileName)
    LOCAL fileOut, nField, i
    LOCAL fieldName, fieldValue, jsonContent
    LOCAL totalRecords, recordNum

    USE (tableName) IN 0

    totalRecords = RECCOUNT()
    recordNum = 0

    fileOut = FCREATE(outputFileName)
    nField = FCOUNT()
    
    jsonContent = '{' + CHR(13)
    jsonContent = jsonContent + '  "tabla": "' + tableName + '",' + CHR(13)
    jsonContent = jsonContent + '  "lineas": {' + CHR(13)

    GO TOP
    DO WHILE !EOF()
        recordNum = recordNum + 1

        jsonContent = jsonContent + '    "' + TRANSFORM(recordNum) + '": {' + CHR(13)

        FOR i = 1 TO nField
            fieldName = FIELD(i)
            fieldValue = TRANSFORM(EVALUATE(fieldName))

            fieldValue = STRTRAN(fieldValue, CHR(13), "")
            fieldValue = STRTRAN(fieldValue, CHR(10), "")

            fieldValue = '"' + fieldValue + '"'
            jsonContent = jsonContent + '      "' + fieldName + '": ' + fieldValue

            IF i < nField
                jsonContent = jsonContent + ',' + CHR(13)
            ELSE
                jsonContent = jsonContent + CHR(13)
            ENDIF
        ENDFOR

        IF recordNum < totalRecords
            jsonContent = jsonContent + '    },' + CHR(13)
        ELSE
            jsonContent = jsonContent + '    }' + CHR(13)
        ENDIF
        
        SKIP
    ENDDO

    jsonContent = jsonContent + '  }' + CHR(13) + '}'

    =FWRITE(fileOut, STRCONV(jsonContent, 9))
    =FCLOSE(fileOut)
    USE
ENDPROC