*** Settings ***
Library    String 
Library    Collections
Library    ../CustomLibrary.py
Library    OperatingSystem
Library    DateTime

*** Variables ***
${SEARCH_BUTTON_GRAPHIC}        xpath=//*[text()='Gráfico de preços'] //..
${GRAPHIC_PRICE}                xpath=//*[@series-id='price graph'] //child::*
${SEARCH_BUTTON_LESS_DAY}       xpath=//*[@aria-label='Reduzir a estadia em um dia']
${SEARCH_TEXT_DAY}              xpath=(//*[contains(text(),"Viagem de")])[1]
${LIST_NUMBER_GRAPHIC}
${values}
${LIST_PRICE}                   Create List    

*** Keywords ***
access graphic price
    Wait Until Element Is Visible    ${SEARCH_BUTTON_GRAPHIC}    50 
    Click Element                    ${SEARCH_BUTTON_GRAPHIC}    

capture values for the graphic
    sleep                       10
    Capture Page Screenshot 
    ${LIST_NUMBER_GRAPHIC}     Get Element Count    ${GRAPHIC_PRICE} 
    ${lista_objeto}             Create List          
    #LIST is creat in for 
    FOR                              ${index}                                                IN RANGE                                                2            ${LIST_NUMBER_GRAPHIC}    7 
    Wait Until Element Is Enabled    (//*[@series-id='price graph'] //child::*)[${index}]
    ${data}                          Get Element Attribute                                   (//*[@series-id='price graph'] //child::*)[${index}]    data-id
    ${valor}                         Get Element Attribute                                   (//*[@series-id='price graph'] //child::*)[${index}]    data-rect
    #List is organized for indice and value 
    ${novoValor}                     Split String                                            ${valor}                                                ,
    ${valorFinal}                    Set Variable                                            ${novoValor[-1]} 
    ${valorFinal}                    Evaluate                                                abs(${valorFinal})
    Run Keyword If                   ${valorFinal}==15                                       capture values for the graphic
    ${objeto}         Create Dictionary    indice=${index}    valor=${valorFinal} 
    Append To List    ${lista_objeto}      ${objeto} 
    END
    #Order for less value in final list 
    ${lista_ordenada}                ordenar_por_valor                                                                  ${lista_objeto}                              
    #Capture less values and dates departure and arrival
    ${LIST_PRICE}                   Create List                                                                        
    FOR                              ${index}                                                                           IN RANGE                                     0    5
    Wait Until Element Is Enabled    (//*[@series-id='price graph'] //child::*)[${lista_ordenada[${index}].indice}] 
    Click Element                    (//*[@series-id='price graph'] //child::*)[${lista_ordenada[${index}].indice}] 
    #Creat new object list with final values 
    ${preco}                         Get Text                                                                           (//*[text()="A partir de "])[1] /span        
    ${data}                          Get Text                                                                           (//*[text()="A partir de "])[1] //.. /div    
    ${data_preco}          Create Dictionary          preco=${preco}             data=${data}
    Append To List         ${LIST_PRICE}             ${data_preco} 
    END
    Set Global Variable    ${LIST_NUMBER_GRAPHIC}    ${LIST_NUMBER_GRAPHIC}
    Set Global Variable    ${LIST_PRICE}             ${LIST_PRICE} 

showing the values 
    ${numero_dias _consulta}    Get Text    ${SEARCH_TEXT_DAY} 
    Log To Console             ${numero_dias _consulta}
    write_variable_in_file     ${numero_dias _consulta}   
    FOR                       ${index}                                            IN RANGE                                                                           0    5
    ${arquivo_valor}          Set Variable                                       ${LIST_PRICE[${index}].data} ${LIST_PRICE[${index}].preco}
    Log To Console            ${arquivo_valor}                                    
    write_variable_in_file    ${arquivo_valor}                                    
    END 

clicking less 1 day
    Click Element    ${SEARCH_BUTTON_LESS_DAY} 

searching days less 
#Config for total number of trip 
    [Arguments]      ${dias}=5 

    ${date} =	Get Current Date        result_format=datetime    exclude_millis=True 
    write_variable_in_file            \n${date} \nDestino ${FROM} até ${TO}
    FOR                               ${range}                  IN RANGE                0    ${dias} 
    capture values for the graphic
    showing the values  
    clicking less 1 day
    END

write_variable_in_file
    [Arguments]       ${variable}
    Append To File    ${EXECDIR}/valores.md    \n${variable}

