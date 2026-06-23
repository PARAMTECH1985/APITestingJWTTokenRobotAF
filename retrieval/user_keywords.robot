*** Settings ***
Library    RequestsLibrary
Resource   ../config/env_config.robot
*** Keywords ***
Get User Profile Details
    &{SECURE_HEADERS}
    ...    Authorization=Bearer ${ACCESS_TOKEN}
    ...    Content-Type=application/json
    ...    Accept=application/json
    [Arguments]    ${user_id}
    Create Session    api_session    ${BASE_URL}    verify=True
    # Make request passing the authenticated global header variable
    ${response}=    GET On Session    api_session    ${USER_ENDPOINT}/${user_id}    headers=${SECURE_HEADERS}
    RETURN    ${response}
