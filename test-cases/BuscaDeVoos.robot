*** Settings ***
Resource   ../resources/resources.robot
Resource   ../resources/pages/home.robot
Resource   ../resources/pages/consulta.robot
Suite Setup       Abrir navegador
Suite Teardown    Close Browser   

*** Variables ***
${TO}
${FROM}
${DEPARTURE}
${ARRIVAL}
${DIAS}     1
${AMPLITUDE}    
${TYPE}    ROUND

*** Test Cases ***

Cenario 1 - Procura de preços de voos 
   #Dado 
   que eu tenha acessado o Google Fight 
   #Quando 
   Consultar informações de voo de para as datas   ${FROM}  ${TO}  ${DEPARTURE}  ${ARRIVAL}   ${TYPE}
   é informado preço mais baixo 
   acesso grafico de preço

   #Então 
   pesquisa de "${DIAS}" menos 

