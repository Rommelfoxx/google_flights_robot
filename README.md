
## Google Flights automation 

Automation to search cheap air ticket by google fight and send result by telegram 

<b>Dependency</b>

Robot Framework 

Library SeleniumLibrary

------------------------------------------------------------------------------------------------------------------------------
### Steps for executing test

git clone https://github.com/Rommelfoxx/google_fight.git

The information for the flights is in the command execution.

Example:
robot -d results -v FROM:São_Paulo -v TO:Roma -v DEPARTURE:08_setembro_2024 -v ARRIVAL:21_setembro_2024 -v DIAS:2 -v AMPLITUDE:Total   test-cases 

<b>FROM</b>: - Location DEPARTURE

<b>TO</b>: Location ARRIVAL 

<b>DEPARTURE</b>: Day for the Departure 

<b>ARRIVAL</b>: Day for the Arrival 

<b>DIAS</b>: How many days the search show you more to find the best price 

<b>AMPLITUDE</b>: How many days the search will show the diferentes dates, can be this values "baixo","medio","alto","total"

------------------------------------------------------------------------------------------------------------------------------
### Steps for the creating GIT ACTION  



name: Passagens Canada
on:
   workflow_dispatch:
   schedule:
      - cron: '0 8,16,22,3 * * *'
jobs:
  run_automation:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - name: Install Dependecies
      env:
        PYTHON_VERSION: "3.10"
      run: |
        py_version=$PYTHON_VERSION
        sudo apt update
        sudo apt install software-properties-common
        sudo add-apt-repository -y ppa:deadsnakes/ppa
        sudo apt update
        sudo apt install python"$py_version"
        sudo apt install -y nodejs
    - name: Verify Version
      run: |
          python --version
          nodejs -v
          npm --version
          aws --version
    - name: Install libraries for robot
      run: |
          pip install -U pip
          pip install selenium==4.9.1
          pip install -r requirements.txt
          
    - name: Run Tests
      uses: nick-fields/retry@v2
      with:
        timeout_minutes: 10
        max_attempts: 3
        shell: pwsh
        command: |
            robot -d results -v FROM:São_Paulo -v TO:Toronto -v DEPARTURE:23_março_2024 -v ARRIVAL:23_junho_2024 test-cases 
    
    - name: Upload test results
      uses: actions/upload-artifact@v1
      if: always()
      with:
        name: reports
        path: valores.md  
    
    - uses: dtinth/markdown-report-action@v1.0.0
      name: create report from markdown
      with:
               title: reports
               body-file: valores.md
               
    - name: send telegram message on push
      uses: appleboy/telegram-action@master
      with:
          to: -4007623133
          token: 6549097027:AAGZAs99MkBOgpaQLvq3V0rO-7TimDEoMw0
          message: Pesquisa de passagens realizada com sucesso! 
          message_file: valores.md
          format: markdown 

------------------------------------------------------------------------------------------------------------------------------
