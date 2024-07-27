FUNCTION XML {

    $XML = @'
<?xml version="1.0" encoding="UTF-8"?>
"XML"
'@

    $XMLFILE = New-Item "$($env:temp)\XML" -ItemType Directory -Force

    $XML | Out-File "$($XMLFILE.FullName)\XML.xml" -Encoding utf8

}

XML

FUNCTION XML2 {

    [System.IO.FileInfo]$XML = "$($env:Temp)\XML.xml"

    if (!$XML.Directory.Exists) {
        $XML.Directory.Create()
    }

    '<?xml version="1.0" encoding="UTF-8"?>
"XML"
' | Out-File $XML.FullName -Encoding utf8 -Force

}

XML2