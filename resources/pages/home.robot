*** Settings ***


*** Variables ***
${HOME_INPUT_SEARCH_TO}         xpath=//*[@placeholder='Para onde?']
${HOME_INPUT_SEARCH_FROM}       xpath=(//*[@aria-placeholder='De onde?'] //input) [1]
${HOME_INPUT_SEARCH_PARTIDA}    xpath=(//*[@aria-label='Partida'])[1]
${HOME_INPUT_SEARCH_VOLTA}      xpath=(//*[@aria-label='Volta'])[2]
${HOME_BUTTON_SEARCH}           xpath=//*[@aria-label='Pesquisar']


*** Keywords ***

Consultar informações de voo de "${from}" para "${to}"

    Set Window Size    1200   800
    #Informações de aeroporto
    Wait Until Element Is Visible    ${HOME_INPUT_SEARCH_TO}
    Input Text                       ${HOME_INPUT_SEARCH_TO}    ${to}    True
    sleep   1

    # Click Element     //*[@aria-placeholder='De onde?']
    
    Wait Until Element Is Visible    //*[text()='Paris, França']    20
    Click Element                    //*[text()='Paris, França']

    
    Input Text                       ${HOME_INPUT_SEARCH_FROM}             ${from}    True
     
    sleep   1
    Wait Until Element Is Visible    //*[text()='Cidade em São Paulo']     20
    Click Element                    //*[text()='Cidade em São Paulo']



    #Informação de DAta de partida e volta

    Wait Until Element Is Visible    ${HOME_INPUT_SEARCH_PARTIDA}    
    sleep  1
    Click Element                    ${HOME_INPUT_SEARCH_PARTIDA}  
    Input Text                       ${HOME_INPUT_SEARCH_PARTIDA}    10 fevereiro 2024   

    Input Text                       ${HOME_INPUT_SEARCH_VOLTA}    10 abril 2024 
    sleep   1
    Press Keys        ${HOME_INPUT_SEARCH_VOLTA}   10 abril 2024 
    Press Keys        ${HOME_INPUT_SEARCH_VOLTA}   RETURN
    sleep   1
    Click Element    (//*[text()='Concluído'])[4]
    Capture Page Screenshot    

é informado preço mais baixo 
    sleep   1
    Click Element    ${HOME_BUTTON_SEARCH}  
    sleep   1
    Capture Page Screenshot  