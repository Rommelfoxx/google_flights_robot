*** Settings ***


*** Variables ***
${HOME_INPUT_SEARCH_TO}         xpath=//*[@placeholder='Para onde?']
${HOME_INPUT_SEARCH_FROM}       xpath=(//*[@aria-placeholder='De onde?'] //input) [1]
${HOME_INPUT_SEARCH_PARTIDA}    xpath=(//*[@aria-label='Partida'])[1]
${HOME_INPUT_LIST}              xpath=(//*[contains(text(),"Mostrando")])[1] //..
${HOME_INPUT_SEARCH_VOLTA}      xpath=(//*[@aria-label='Volta'])[2]
${HOME_BUTTON_SEARCH}           xpath=//*[@aria-label='Pesquisar']
${HOME_BUTTON_CONCLUIDO}        xpath=(//*[text()='Concluído'])[4]


*** Keywords ***

search flight information "${from}" to "${to}" on dates "${departure}" "${arrival}" 
    Set Window Size                  1200                       800
    Wait Until Element Is Visible    ${HOME_INPUT_SEARCH_TO}
    Input Text                       ${HOME_INPUT_SEARCH_TO}    ${to}    True
    sleep                            1
    Wait Until Element Is Enabled    ${HOME_INPUT_LIST}    
    Click Element                    ${HOME_INPUT_LIST}    
    Input Text    ${HOME_INPUT_SEARCH_FROM}    ${from}    True
    sleep                            1
    Wait Until Element Is Enabled    ${HOME_INPUT_LIST}    20
    Click Element                    ${HOME_INPUT_LIST}    
    #Information of dates departure and arrival 
    Wait Until Element Is Visible    ${HOME_INPUT_SEARCH_PARTIDA}    
    sleep                            1
    Click Element    ${HOME_INPUT_SEARCH_PARTIDA}    
    Sleep            1                               
    Input Text                       ${HOME_INPUT_SEARCH_PARTIDA}    ${departure}
    Press Keys    ${HOME_INPUT_SEARCH_PARTIDA}    RETURN
    sleep                      1
    Press Keys                 ${HOME_INPUT_SEARCH_VOLTA}    ${arrival}
    Press Keys                 ${HOME_INPUT_SEARCH_VOLTA}    RETURN
    sleep                      1
    Click Element              ${HOME_BUTTON_CONCLUIDO}
    Capture Page Screenshot    

lower price is reported
    sleep                      1
    Click Element              ${HOME_BUTTON_SEARCH}    
    sleep                      1
    Capture Page Screenshot    



