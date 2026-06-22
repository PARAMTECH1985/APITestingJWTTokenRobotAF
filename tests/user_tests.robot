*** Settings ***
Resource          D:\\robot-tba-rat\\APITestingJWTTokenRobotAF\\credentials\\resources\\auth_keywords.robot
Resource          D:\\robot-tba-rat\\APITestingJWTTokenRobotAF\\retrieval\\user_keywords.robot
Suite Setup       Generate and Set JWT Token
*** Test Cases ***
Verify Fetching User Profile With Valid JWT Token
    [Tags]    Regression    Smoke
    ${response}=          Get User Profile Details    105
    Status Should Be      200    ${response}
    # Validate specific JSON keys in payload response
    Should Be Equal As Strings    ${response.json()['id']}    105
    Dictionary Should Contain Key  ${response.json()}         email
Verify Fetching User Profile Missing Valid Token Fails
    [Tags]    Negative
    Create Session    bad_session    ${BASE_URL}
    ${empty_headers}=  Create Dictionary    Content-Type=application/json
    # Explicitly bypassing ${SECURE_HEADERS} to check 401 Unauthorized compliance
    ${response}=       GET On Session    bad_session    ${USER_ENDPOINT}/105    headers=${empty_headers}    expected_status=401
    Status Should Be   401    ${response}
