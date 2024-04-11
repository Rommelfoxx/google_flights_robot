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

Consultar informações de voo de "${from}" para "${to}" nas datas "${departure}" "${arrival}"

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



    #Informação de DAta de partida e volta

    Wait Until Element Is Visible    ${HOME_INPUT_SEARCH_PARTIDA}    
    sleep                            1

    Click Element    ${HOME_INPUT_SEARCH_PARTIDA}    
    Sleep            1                               

    Input Text                       ${HOME_INPUT_SEARCH_PARTIDA}    ${departure}
    # Press Keys    ${HOME_INPUT_SEARCH_PARTIDA}    ${departure}    
    Press Keys    ${HOME_INPUT_SEARCH_PARTIDA}    RETURN

    # Input Text                 ${HOME_INPUT_SEARCH_VOLTA}      ${arrival}
    sleep                      1
    Click Element              (//*[@placeholder='Volta'])[1]       
    Press Keys                 (//*[@placeholder='Volta'])[1]    ${arrival}
    Press Keys                 (//*[@placeholder='Volta'])[1]    RETURN
    sleep                      1
    Click Element              ${HOME_BUTTON_CONCLUIDO}
    Capture Page Screenshot    

é informado preço mais baixo
    sleep                      1
    Click Element              ${HOME_BUTTON_SEARCH}    
    sleep                      1
    Capture Page Screenshot    



