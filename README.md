
## Google Flights automation 

Automation to search cheap air ticket by google fight and send result by telegram 

<b>Dependency</b>

Robot Framework 

Library SeleniumLibrary

------------------------------------------------------------------------------------------------------------------------------
### Steps for executing test

git clone https://github.com/Rommelfoxx/google_fight.git

The information for the flights is in the command execution.

Exemple:
robot -d results -v FROM:São_Paulo -v TO:Roma -v DEPARTURE:08_setembro_2024 -v ARRIVAL:21_setembro_2024 -v DIAS:2 test-cases 

<b>FROM</b>: - Location DEPARTURE

<b>TO</b>: Location ARRIVAL 

<b>DEPARTURE</b>: Day for the Departure 

<b>ARRIVAL</b>: Day for the Arrival 

<b>DIAS</b>: How many days the search show you more to find the best price 

 
------------------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------------------------
