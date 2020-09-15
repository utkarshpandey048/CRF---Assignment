*** Settings ***
Resource          common.robot
Resource          ../Variables/UIVariables.txt

*** Keywords ***
Register a new user
    [Arguments]    ${Username}    ${Password}    ${FirstName}    ${FamilyName}    ${PhoneNumber}
    Wait Until Element Is Visible    //a[text()='Register']    10s
    Wait Until Keyword Succeeds    10s    1s    Click Element    //a[text()='Register']
    wait until element is visible    //*[text()='Username']/following::input[1]    10s
    Wait Until Keyword Succeeds    10s    1s    Input Text    //*[text()='Username']/following::input[1]    ${Username}
    Wait Until Keyword Succeeds    10s    1s    Input Password    //*[text()='Password']/following::input[1]    ${Password}
    Wait Until Keyword Succeeds    10s    1s    Input Text    //*[text()='First name']/following::input[1]    ${FirstName}
    Wait Until Keyword Succeeds    10s    1s    Input Text    //*[text()='Family Name']/following::input[1]    ${FamilyName}
    Wait Until Keyword Succeeds    10s    1s    Input Text    //*[text()='Phone number']/following::input[1]    ${PhoneNumber}
    Wait Until Keyword Succeeds    10s    1s    Click Element    //input[@value='Register']
    Set Global Variable    ${Username}
    Set Global Variable    ${Password}
    Set Global Variable    ${FirstName}
    Set Global Variable    ${FamilyName}
    Set Global Variable    ${PhoneNumber}

Launch Application
    Open Browser    ${URL}    gc

Login to Application
    [Arguments]    ${Username}    ${Password}
    Wait Until Keyword Succeeds    10s    1s    Click Element    //a[text()='Log In']
    Wait Until Element Is Visible    //input[@value='Log In']
    Wait Until Keyword Succeeds    10s    1s    Input Text    //*[text()='Username']/following::input[1]    ${Username}
    Wait Until Keyword Succeeds    10s    1s    Input Password    //*[text()='Password']/following::input[1]    ${Password}
    Wait Until Keyword Succeeds    10s    1s    Click Element    //input[@value='Log In']

Review User Info
    [Arguments]    ${Username}    ${FirstName}    ${FamilyName}    ${PhoneNumber}
    wait until page contains    User Information
    Wait Until Element Contains    //*[text()=' Username ']/following::td[1]    ${Username}
    Element Should Contain    //*[text()=' First name ']/following::td[1]    ${FirstName}
    Element Should Contain    //*[text()=' Last name ']/following::td[1]    ${FamilyName}
    Element Should Contain    //*[text()=' Phone number ']/following::td[1]    ${PhoneNumber}

Log out of Application
    Wait until keyword succeeds    5s    1s    Click Link    Log Out

Check Message
    [Arguments]    ${Text}
    Wait until page contains    ${Text}
