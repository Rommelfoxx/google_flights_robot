*** Settings ***
Library    String 
Library    Collections
Library    ../CustomLibrary.py
Library    OperatingSystem
Library    DateTime

*** Variables ***
${CONSULTA_BUTTON_GRAFICO}       xpath=//*[text()='Gráfico de preços'] //..
${GRAFICO_PRECO}                 xpath=//*[@series-id='price graph'] //child::*
${CONSULTAR_BUTTON_MENOS_DIA}    xpath=//*[@aria-label='Reduzir a estadia em um dia']
${CONSULTAR_TEXT_DIAS}           xpath=(//*[contains(text(),"Viagem")])[1]
${LISTA_NUMERO_GRAFICO}
${values}
${LISTA_PRECO}              Create List    
@{DIAS_CONSUTA_FLEXIVEL}    1     9    16    23    30    37    44    51    58    65    72    79    86    93    100    107    114    121    128    135    142    149    156   163    170    177    184    191   198    205    212    219    226   233   240    247    254    261    268     275   282   289    296    303    310    317    324   331   338   345    352    359    366   373   380  387   394    401
 

*** Keywords ***
acesso grafico de preço
    Wait Until Element Is Visible    ${CONSULTA_BUTTON_GRAFICO}    50 
    Click Element                    ${CONSULTA_BUTTON_GRAFICO}    

captura dos valores do grafico     
     [Arguments]    ${comeco}=128     ${fim}=37
    sleep                       10
    Capture Page Screenshot 
    # ${lista_numero_grafico}     Get Element Count    ${GRAFICO_PRECO}
    ${lista_numero_grafico}     Set Variable    ${DIAS_CONSUTA_FLEXIVEL[${fim}]} 
    ${lista_objeto}             Create List     

    #Lista é criada no FOR
    FOR                              ${index}                                                IN RANGE                                                 ${comeco}           ${lista_numero_grafico}    7 
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
    FOR                              ${index}                                                                           IN RANGE                                     0    7
    Wait Until Element Is Enabled    (//*[@series-id='price graph'] //child::*)[${lista_ordenada[${index}].indice}] 
    Click Element                    (//*[@series-id='price graph'] //child::*)[${lista_ordenada[${index}].indice}] 
    #Cria nova lista de objeto com valores finais
    ${preco}                         Get Text                                                                           (//*[text()="A partir de "])[1] /span        
    ${data}                          Get Text                                                                           (//*[text()="A partir de "])[1] //.. /div    

    ${data_preco}          Create Dictionary          preco=${preco}             data=${data}
    Append To List         ${lista_preco}             ${data_preco} 
    END
    Set Global Variable    ${LISTA_NUMERO_GRAFICO}    ${lista_numero_grafico}
    Set Global Variable    ${LISTA_PRECO}             ${lista_preco} 

apresentacao dos valores
    #apresentação dos resultados
    Wait Until Element Is Visible           ${CONSULTAR_TEXT_DIAS} 
    ${numero_dias _consulta}    Get Text    ${CONSULTAR_TEXT_DIAS} 

    Log To Console            ${numero_dias _consulta}
    write_variable_in_file    ${numero_dias _consulta}    

    FOR                       ${index}            IN RANGE                                                        0    7
    ${arquivo_valor}          Set Variable        ${lista_preco[${index}].data} ${lista_preco[${index}].preco}
    Log To Console            ${arquivo_valor}    
    write_variable_in_file    ${arquivo_valor}    
    END 

clicar menos 1 dia
    Click Element    ${CONSULTAR_BUTTON_MENOS_DIA} 

pesquisa de "${dias}" menos
    ${date} =	Get Current Date        result_format=datetime                   exclude_millis=True 
    write_variable_in_file            \n${date} \nDestino ${FROM} até ${TO}
    FOR                               ${range}                                 IN RANGE                0    ${dias} 
    Run Keyword If  '${AMPLITUDE}' == ''        captura dos valores do grafico 
    Run Keyword If  '${AMPLITUDE}' == 'medio'   captura dos valores do grafico     142     34
    Run Keyword If  '${AMPLITUDE}' == 'baixo'   captura dos valores do grafico     23      22
    Run Keyword If  '${AMPLITUDE}' == 'alto'    captura dos valores do grafico     205     55
    Run Keyword If  '${AMPLITUDE}' == 'total'   captura dos valores do grafico     2       55
    apresentacao dos valores 
    Run Keyword If  '${TYPE}' == 'ROUND'    clicar menos 1 dia
    END

write_variable_in_file
    [Arguments]       ${variable}
    Append To File    ${EXECDIR}/valores2.md    \n${variable}
