*** Settings ***
Library    String 
Library    Collections
Library    ../CustomLibrary.py

*** Variables ***
${CONSULTA_BUTTON_GRAFICO}       xpath=//*[text()='Gráfico de preços'] //..
${GRAFICO_PRECO}                 xpath=//*[@series-id='price graph'] //child::*
${CONSULTAR_BUTTON_MENOS_DIA}    xpath=//*[@aria-label='Reduzir a estadia em um dia']
${CONSULTAR_TEXT_DIAS}           xpath=(//*[contains(text(),"Viagem de")])[1]
${LISTA_NUMERO_GRAFICO}
${values}
${LISTA_PRECO}    Create List    

*** Keywords ***

acesso grafico de preço
    Wait Until Element Is Visible    ${CONSULTA_BUTTON_GRAFICO}    50 
    Click Element                    ${CONSULTA_BUTTON_GRAFICO}    

captura dos valores do grafico
    sleep                       10
    Capture Page Screenshot 
    ${lista_numero_grafico}     Get Element Count    ${GRAFICO_PRECO} 
    ${lista_objeto}             Create List          

    #Lista é criada no FOR
    FOR                              ${index}                                                IN RANGE                                                2            ${lista_numero_grafico}    7 
    Wait Until Element Is Enabled    (//*[@series-id='price graph'] //child::*)[${index}]
    ${data}                          Get Element Attribute                                   (//*[@series-id='price graph'] //child::*)[${index}]    data-id
    ${valor}                         Get Element Attribute                                   (//*[@series-id='price graph'] //child::*)[${index}]    data-rect
    #Lista é organizado por indice e valor
    ${novoValor}                     Split String                                            ${valor}                                                ,
    ${valorFinal}                    Set Variable                                            ${novoValor[-1]} 
    ${valorFinal}                    Evaluate                                                abs(${valorFinal})
    Run Keyword If                   ${valorFinal}==15                                       captura dos valores do grafico
   
    ${objeto}         Create Dictionary    indice=${index}    valor=${valorFinal} 
    Append To List    ${lista_objeto}      ${objeto} 
    END

    #Ordenar por menor valor lista final
    ${lista_ordenada}                ordenar_por_valor                                                                  ${lista_objeto}    
    #Captura valores dos menores e data de partida e chegada
    ${lista_preco}                   Create List                                                                        
    FOR                              ${index}                                                                           IN RANGE           0    4
    # Log To Console    ${lista_ordenada[${index}].indice}
    Wait Until Element Is Enabled    (//*[@series-id='price graph'] //child::*)[${lista_ordenada[${index}].indice}] 
    Click Element                    (//*[@series-id='price graph'] //child::*)[${lista_ordenada[${index}].indice}] 
    #Cria nova lista de objeto com valores finais
    ${preco}    Get Text    (//*[text()="A partir de "])[1] /span        
    ${data}     Get Text    (//*[text()="A partir de "])[1] //.. /div    

    ${data_preco}          Create Dictionary          preco=${preco}             data=${data}
    Append To List         ${lista_preco}             ${data_preco} 
    END
    Set Global Variable    ${LISTA_NUMERO_GRAFICO}    ${lista_numero_grafico}
    Set Global Variable    ${LISTA_PRECO}             ${lista_preco} 

apresentacao dos valores
    #apresentação dos resultados
    ${numero_dias _consulta}    Get Text                                                                           ${CONSULTAR_TEXT_DIAS} 
    Log To Console              Consulta realizada para ${numero_dias _consulta}
    FOR                         ${index}                                                                           IN RANGE                   0    4
    Log To Console              A data é ${lista_preco[${index}].data} e o preço ${lista_preco[${index}].preco}
    END 

clicar menos 1 dia
    Click Element    ${CONSULTAR_BUTTON_MENOS_DIA} 

pesquisa de "${dias}" menos  
     FOR                              ${range}                                                                          IN RANGE          0   ${dias} 
     captura dos valores do grafico
     apresentacao dos valores 
     clicar menos 1 dia
     END