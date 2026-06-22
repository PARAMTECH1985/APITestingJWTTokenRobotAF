*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource   D:\\robot-tba-rat\\APITestingJWTTokenRobotAF\\config\\env_config.robot
*** Keywords ***
Generate and Set JWT Token
    [Documentation]    Authenticates and stores JWT as a global header
    Create Session    auth_session    ${BASE_URL}    verify=True
    # Define login payload
    ${payload}=       Create Dictionary    username=${USERNAME}    password=${PASSWORD}
    ${headers}=       Create Dictionary    Content-Type=application/json
    # Send login request
    ${response}=      POST On Session    auth_session    ${LOGIN_ENDPOINT}    json=${payload}    headers=${headers}
    Status Should Be  200    ${response}
    # Extract JWT token from JSON response body
    ${jwt_token}=     Set Variable    ${response.json()['token']}
    # Format bearer header token properly
    ${auth_header}=   Set Variable    Bearer ${jwt_token}
    # Construct global headers dictionary for all upcoming protected calls
    ${secure_headers}=    Create Dictionary    Authorization=${auth_header}    Content-Type=application/json
    Set Global Variable   ${SECURE_HEADERS}    ${secure_headers}
