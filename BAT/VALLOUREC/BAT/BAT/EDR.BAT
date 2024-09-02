md "%userprofile%\desktop\EDR"

XCOPY /h /r /e /y \\BBWD8016\PUBLICO\EDR "%userprofile%\desktop\EDR"

COPY "%userprofile%\desktop\EDR\EDR.lnk" "%userprofile%\desktop"

cls

msg %username% Arquivos Copiados - DESLIGUE A REDE/WI-FI - REINICIE A MAQUINA - APOS O REINICIO EXECUTE O ATALHO EDR CRIADO NA AREA DE TRABALHO 

exit
