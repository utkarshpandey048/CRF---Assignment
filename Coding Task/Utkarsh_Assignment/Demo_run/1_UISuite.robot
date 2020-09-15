*** Settings ***
Suite Teardown
Resource          Resources/UIKeywords.robot

*** Test Cases ***
Register through web portal
    [Documentation]    Register users through web portal.This script registers 2 users in the system (separate user is created for the user for which the update is to be done by put request)
    [Setup]
    Launch Application
    Register a new user    ${Username_1}    ${Password}    ${FirstName}    ${FamilyName}    ${Phonenumber}
    #Register another user for which update would be done by PUT request
    Register a new user    ${Username_2}    ${Password}    ${FirstName}    ${FamilyName}    ${Phonenumber}
    [Teardown]

Review my own user information from the main view
    [Documentation]    After registration,this script verifies the user information.
    Login to Application    ${Username_1}    ${Password}
    Review User Info    ${Username_1}    ${FirstName}    ${FamilyName}    ${Phonenumber}
    Log out of Application
    [Teardown]

Try to register a user which already exists
    [Documentation]    This script verifies the valisation message shown to the user on trying to register a user which already exists in the system.
    Register a new user    ${Username_1}    ${Password}    ${FirstName}    ${FamilyName}    ${Phonenumber}
    Check Message    User ${Username_1} is already registered.
    [Teardown]

Success message verification on registration
    [Documentation]    Bug/Improvement: Successful user registration should show a success message.Currently there is no notification if user is registered or not
    Register a new user    SUCCESS_USER_1    ${Password}    ${FirstName}    ${FamilyName}    ${Phonenumber}
    #Some successfull message should be shown to the user on doing registration
    wait until page contains    "User successfully registered"
    [Teardown]    Close All Browsers
