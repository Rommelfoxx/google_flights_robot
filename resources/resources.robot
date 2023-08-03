*** Settings ***
Library     SeleniumLibrary      
Library     Collections

*** Variables ***
# ${BROWSER}               Chrome
${BROWSER}               chrome
# ${BROWSER}               headlesschrome
${REMOTE_TESTER_URL}     https://www.google.com/travel/flights?hl=pt-BR&curr=BRL


*** Keywords ***
# Abrir navegador

#         ${chrome_options}=           Evaluate                             sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
#         Call Method                  ${chrome_options}                    add_argument                                         --disable-extensions
#         Call Method                  ${chrome_options}                    add_argument                                         --disable-gpu
#         Call Method                  ${chrome_options}                    add_argument                                         --disable-web-security
#         Call Method                  ${chrome_options}                    add_argument                                         --no-sandbox
#         Call Method                  ${chrome_options}                    add_argument                                         --ignore-certificate-errors
#         Call Method                  ${chrome_options}                    add_argument                                         --allow-running-insecure-content
#         Call Method                  ${chrome_options}                    add_argument                                         --disable-popup-blocking
#         Call Method                  ${chrome_options}                    add_experimental_option                              useAutomationExtension                           False
#         Call Method                  ${chrome_options}                    add_argument                                         --allow-insecure-localhost
#         Call Method                  ${chrome_options}                    add_argument                                         --no-experiments
#         Call Method                  ${chrome_options}                    add_argument                                         --disable-web-security
#         Call Method                  ${chrome_options}                    add_argument                                         --no-first-run
#         Call Method                  ${chrome_options}                    add_argument                                         --disable-blink-features
#         Call Method                  ${chrome_options}                    add_argument                                         --test-type
#         Call Method                  ${chrome_options}                    add_argument                                         --disable-infobars
#         Call Method                  ${chrome_options}                    add_argument                                         --incognito
#         ${options}=                  Call Method                          ${chrome_options}                                    to_capabilities                                  
#         ${WEBDRIVER}=                Create Webdriver                     Chrome                                                desired_capabilities=${options}    
#         Maximize Browser Window


Abrir navegador 

   Open Browser    url:    ${BROWSER}
 
que eu tenha acessado o Google Fight 
   Go To    ${REMOTE_TESTER_URL}