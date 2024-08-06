#SELECIONA LOCAL ATUAL DA PASTA DO ONEDRIVE JÁ CRIADA PREVIAMENTE.
Set-Location $HOME\OneDrive

#EXEMPLO 1 - CRIA UM LINK SIMBÓLICO DA UNIDADE D: COM UMA PASTA DE NOME TESTE
New-Item -ItemType symboliclink -Path . -Name TESTE -Value D:\

#EXEMPLO 2 - CRIA UM LINK SIMBÓLICO DA PASTA TESTE na UNIDADE D:
New-Item -ItemType symboliclink -Path . -Name TESTE -Value D:\TESTE

#EXEMPLO 3 - CRIA UM LINK SIMBÓLICO DO ARQUIVO TESTE.txt localizado na pasta TESTE na UNIDADE D:
New-Item -ItemType symboliclink -Path . -Name TESTE.txt -Value D:\TESTE\TESTE.txt
