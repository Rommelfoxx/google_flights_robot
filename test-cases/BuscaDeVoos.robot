*** Settings ***
Resource   ../resources/resources.robot
Resource   ../resources/pages/home.robot
Resource   ../resources/pages/consulta.robot
Suite Setup       Abrir navegador
Suite Teardown    Close Browser   


*** Test Cases ***

Cenario 1 - Procura de preços de voos 
   #Dado 
   que eu tenha acessado o Google Fight 
   #Quando 
   Consultar informações de voo de "São Paulo" para "Paris" 
   #Então 
   é informado preço mais baixo 
   acesso grafico de preço 

