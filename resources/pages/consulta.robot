*** Settings ***
Library    String 
Library    Collections
Library    ../CustomLibrary.py

*** Variables ***
${CONSULTA_BUTTON_GRAFICO}    xpath=//*[text()='Gráfico de preços'] //..
${GRAFICO_PRECO}              xpath=//*[@series-id='price graph'] //child::*
${values}

*** Keywords ***

acesso grafico de preço
    Wait Until Element Is Visible    ${CONSULTA_BUTTON_GRAFICO}    50 
    Click Element                    ${CONSULTA_BUTTON_GRAFICO}    
    sleep                            9
    Capture Page Screenshot 
    
    #criando lista de valores 
    #Qauntidade de itens no grafico
    ${lista_numero_grafico}                        Get Element Count             ${GRAFICO_PRECO} 
    ${lista_objeto}    Create List    
    
    #Lista é criada no FOR 
    FOR    ${index}    IN RANGE    2    ${lista_numero_grafico}    7 
    ${data}     Get Element Attribute    (//*[@series-id='price graph'] //child::*)[${index}]    data-id
    ${valor}    Get Element Attribute    (//*[@series-id='price graph'] //child::*)[${index}]    data-rect
    #Lista é organizado por indice e valor
    ${novoValor}    Split String   ${valor}   ,
    ${valorFinal}    Set Variable    ${novoValor[-1]} 
    ${valorFinal}    Evaluate   abs(${valorFinal})
    ${objeto}    Create Dictionary    indice=${index}    valor=${valorFinal} 
    Append To List    ${lista_objeto}    ${objeto} 
    END

    #Ordenar por menor valor lista final 
    ${lista_ordenada}    ordenar_por_valor    ${lista_objeto}  
     
    # Log To Console    ${lista_ordenada}  
    

    #Captura valores dos menores e data de partida e chegada 
    ${lista_preco}    Create List  

    FOR    ${index}    IN RANGE    0    4
    # Log To Console    ${lista_ordenada[${index}].indice}
    Wait Until Element Is Enabled     (//*[@series-id='price graph'] //child::*)[${lista_ordenada[${index}].indice}] 
    Click Element   (//*[@series-id='price graph'] //child::*)[${lista_ordenada[${index}].indice}] 

    #Cria nova lista de objeto com valores finais 
    ${preco}     Get Text    (//*[text()="A partir de "])[1] /span     
    ${data}     Get Text   (//*[text()="A partir de "])[1] //.. /div  

    ${data_preco}    Create Dictionary    preco=${preco}     data=${data}
    Append To List    ${lista_preco}    ${data_preco} 

    END


    #apresentação dos resultados 
    ${numero_dias _consulta}    Evaluate    ${lista_numero_grafico}/7
    Log To Console   Consulta realizada para ${numero_dias _consulta} dias de viagem 
    FOR    ${index}    IN RANGE    0    4
    Log To Console    A data é ${lista_preco[${index}].data} e o preço ${lista_preco[${index}].preco}

    END 


    