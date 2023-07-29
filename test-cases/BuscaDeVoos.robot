*** Settings ***
Resource   ../resources/resources.robot
Resource   ../resources/pages/home.robot
Resource   ../resources/pages/consulta.robot
Suite Setup       Abrir navegador
Suite Teardown    Close Browser   


*** Test Cases ***

Cenario 1 - Procura de preços de voos 
   #Dado 
   que eu tenha acessado o Google Fight 
   #Quando 
   Consultar informações de voo de "São Paulo" para "Paris" nas datas "10 fevereiro 2024" "10 abril 2024" 
   é informado preço mais baixo 
   acesso grafico de preço

   #Então 
   pesquisa de "5" menos 

