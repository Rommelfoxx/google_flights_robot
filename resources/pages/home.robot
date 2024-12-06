*** Settings ***


*** Variables ***
${HOME_INPUT_SEARCH_TO}         xpath=//*[@placeholder='Para onde?']
${HOME_INPUT_SEARCH_FROM}       xpath=(//*[@data-placeholder='De onde?'] //input) [1]
${HOME_INPUT_SEARCH_PARTIDA}    xpath=(//*[@aria-label='Partida'])[1]
${HOME_INPUT_LIST}              xpath=(//*[contains(text(),"Mostrando")])[1] //..
${HOME_INPUT_SEARCH_VOLTA}      xpath=(//*[@aria-label='Volta'])[2]
${HOME_BUTTON_SEARCH}           xpath=//*[@aria-label='Pesquisar']
${HOME_BUTTON_CONCLUIDO}        xpath=(//*[text()='Concluído'])[4]





*** Keywords ***

Consultar informações de voo de para as datas 
    [Arguments]     ${from}    ${to}   ${departure}     ${arrival}="1_março_2024"   ${type}= "ROUND"
     
    Set Window Size                  1200                       800
    Wait Until Element Is Visible    ${HOME_INPUT_SEARCH_TO}

    Run Keyword If  '${type}' == 'ONE'  change the type of ticket 
    Input Text                       ${HOME_INPUT_SEARCH_TO}    ${to}    True
    sleep                            1

    Wait Until Element Is Enabled    ${HOME_INPUT_LIST}    
    Click Element                    ${HOME_INPUT_LIST}    

    Input Text    ${HOME_INPUT_SEARCH_FROM}    ${from}    True

    sleep                            1
    Wait Until Element Is Enabled    ${HOME_INPUT_LIST}    20
    Click Element                    ${HOME_INPUT_LIST}    

    #Informação de DAta de partida e volta
    Wait Until Element Is Visible    ${HOME_INPUT_SEARCH_PARTIDA}    
    sleep                            1
    Click Element    ${HOME_INPUT_SEARCH_PARTIDA}    
    Sleep            1                               
    Input Text                       ${HOME_INPUT_SEARCH_PARTIDA}    ${departure}
    # Press Keys    ${HOME_INPUT_SEARCH_PARTIDA}    ${departure}    
    Press Keys    ${HOME_INPUT_SEARCH_PARTIDA}    RETURN 
    
    #insert return dates only for Round trip  
    Run Keyword If  '${type}' == 'ROUND'  Insert return date 

    Run Keyword And Continue On Failure    Click Element              ${HOME_BUTTON_CONCLUIDO}
    Capture Page Screenshot    

é informado preço mais baixo
    sleep                      1
    Click Element              ${HOME_BUTTON_SEARCH}    
    sleep                      1
    Capture Page Screenshot    


#Change the type of ticket "ROUND TRIP" or "ONE WAY"
change the type of ticket 
    Wait Until Element Is Visible      (//*[@role="combobox"])[1]
    Click Element      (//*[@role="combobox"])[1]
    Wait Until Element Is Visible   (//*[@role="option"])[2]
    Click Element     (//*[@role="option"])[2]
    sleep                      1
    

Insert return date 
    # Input Text                 ${HOME_INPUT_SEARCH_VOLTA}      ${arrival}
    sleep                      3
    Click Element              (//*[@placeholder='Volta'])[1] 
    sleep    1
    Press Keys                  (//*[@placeholder='Volta'])[2]   ${arrival}
    Press Keys                 (//*[@placeholder='Volta'])[2]   RETURN
    sleep                      1
