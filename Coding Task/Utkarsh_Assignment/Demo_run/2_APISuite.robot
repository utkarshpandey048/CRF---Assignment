*** Settings ***
Resource          Resources/common.robot

*** Test Cases ***
Review user registered in system
    [Documentation]    Review users registered in the system.It will check if the user is registered in the system and will also log all the users registered in the system in the robot logs.
    ${status}    ${users}    check_user_registered_in_system    ${URL}/api/users    ${Username_1}
    Should Be True    ${status}
    Log    ${users}

Authenticate user and get user details
    [Documentation]    Gets the user info by first authenticating with username and password.
    ${status}    ${token}    authenticate_user_and_get_token    ${URL}/api/auth/token    ${Username_1}    ${Password}
    Should be true    ${status}
    ${Get_user_data}    get_user_info    ${URL}/api/users/${Username_1}    ${token}
    Log    ${Get_user_data}

Authenticate user and Update user details
    [Documentation]    Updates the user info by first authenticating with username and password.
    [Tags]    put
    ${status}    ${token}    authenticate_user_and_get_token    ${URL}/api/auth/token    ${Username_2}    ${Password}
    Should be true    ${status}
    ${payload}    Create Dictionary    lastname=Sambar    firstname=Somia    phone=0403456787
    update_user_info    ${URL}/api/users/${Username_2}    ${token}    ${payload}
    ${Get_user_data}    get_user_info    ${URL}/api/users/${Username_2}    ${token}
    Should Be Equal    ${payload}    ${Get_user_data}
