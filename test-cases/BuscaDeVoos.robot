*** Settings ***
Resource   ../resources/resources.robot
Resource   ../resources/pages/home.robot
Resource   ../resources/pages/search.robot
Suite Setup       Abrir navegador
Suite Teardown    Close Browser   

*** Variables ***
${TO}
${FROM}
${DEPARTURE}
${ARRIVAL}
${DIAS}


*** Test Cases ***

Cenario 1 - Procura de preços de voos 
   #Given
   that i have accessed google fight
   #Then
   search flight information "${from}" to "${to}" on dates "${departure}" "${arrival}" 
   lower price is reported
   access graphic price
   #than
   searching days less   ${DIAS}

