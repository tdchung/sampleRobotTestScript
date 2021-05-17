*** Variables ***
${SERVER}  http://20.62.231.182:8080          

*** Settings ***
Documentation       The test set to cover WIDS API: email to ticket
...                 Ticket ID: WIDS-307, WIDS-342

Library    Collections                                                                                 
Library    RequestsLibrary      

# custom libraries
Library          ../WIDS_Custom_Libs/WISD_Libraries.py


Suite Setup    Create Session  request_endpoint  ${SERVER}

*** Test Cases ***                                                                                     
WIDS - 1 - Email to Ticket - Normal case - 1
    [Documentation]     Test to validate API is working in normal case. Input data array = 1
    [Tags]              Ready

    ${data1} =       Create dictionary  emailbody=SERVICE REQUEST_SOFTWARE_NOT FOUND_INSTALLATION

    # Known issue: The input body with length of array is 1 will throw error
    # ${data1} =   Create Array Body Input    ${data1}

    ${resp}=    POST On Session    request_endpoint  /meta/general/1.0/getclassified  json=${data1}  expected_status=anything     

    # validate expected response
    Status Should Be                 200  ${resp}
    Validate Output Should Contain Keys  ${resp.json()['1']}  Action_class_name  EmailBody  L1  L2  L3  L4 


WIDS - 1 - Email to Ticket - Normal case - 2
    [Documentation]     Test to validate API is working in normal case. Input data array more than 1
    [Tags]              Ready

    ${data1} =       Create dictionary  emailbody=SERVICE REQUEST_SOFTWARE_NOT FOUND_INSTALLATION
    ${data2} =       Create dictionary  emailbody=test ttest
    ${inputbody} =   Create Array Body Input    ${data1}  ${data2}

    ${resp}=    POST On Session    request_endpoint  /meta/general/1.0/getclassified  json=${inputbody}  expected_status=anything     

    # validate expected response
    Status Should Be                  200  ${resp}
    Validate Length Of Response       ${resp.json()}  2
    validate array response contain keys  ${resp.json()}  Action_class_name  EmailBody  L1  L2  L3  L4 


WIDS - 2 - Email to Ticket - Verify API is working with optional paramester
    [Documentation]     Test to validate API is working with the optional parameter
    [Tags]              N/A


WIDS - 3 - Email to Ticket - Verify API with some parameters are missing
    [Documentation]     Verify API with some parameters are missing
    [Tags]              Not_ready

WIDS - 4 - Email to Ticket - Verify API behavior if the length of input parameters are not valid - 1
    [Documentation]     Verify API behavior if the length of input parameters are not valid - data is empty
    [Tags]              Ready       know_issue
    
    ${data1} =       Create dictionary  emailbody=
    ${data2} =       Create dictionary  emailbody=test ttest
    ${inputbody} =   Create Array Body Input    ${data1}  ${data2}

    ${resp}=    POST On Session    request_endpoint  /meta/general/1.0/getclassified  json=${inputbody}  expected_status=anything     

    # validate expected response
    Status Should Be                  200  ${resp}
    Validate Length Of Response       ${resp.json()}  2
    validate array response contain keys  ${resp.json()}  Action_class_name  EmailBody  L1  L2  L3  L4         


WIDS - 4 - Email to Ticket - Verify API behavior if the length of input parameters are not valid - 2
    [Documentation]     Verify API behavior if the length of input parameters are not valid - data is less than 10
    [Tags]              developing       know_issue
    
    ${data1} =       Create dictionary  emailbody=Main
    ${data2} =       Create dictionary  emailbody=SERVICE REQUEST_SOFTWARE_NOT FOUND_INSTALLATION
    ${inputbody} =   Create Array Body Input    ${data1}  ${data2}

    ${resp}=    POST On Session    request_endpoint  /meta/general/1.0/getclassified  json=${inputbody}  expected_status=anything     

    # validate expected response
    Status Should Be                  200  ${resp}
    Validate Length Of Response       ${resp.json()}  2
    validate array response contain keys  ${resp.json()}  Action_class_name  EmailBody  L1  L2  L3  L4         

WIDS - 4 - Email to Ticket - Verify API behavior if the length of input parameters are not valid - 5
    [Documentation]     Verify API behavior if the length of input parameters are not valid - data is more than 150
    [Tags]              developing      
    ${data1} =       Create dictionary  emailbody=Main
    ${data2} =       Create dictionary  emailbody=SERVICE REQUEST_SOFTWARE_NOT FOUND_INSTALLATION
    ${inputbody} =   Create Array Body Input    ${data1}  ${data2}

    ${resp}=    POST On Session    request_endpoint  /meta/general/1.0/getclassified  json=${inputbody}  expected_status=anything     

    # validate expected response
    Status Should Be                  200  ${resp}
    Validate Length Of Response       ${resp.json()}  2
    validate array response contain keys  ${resp.json()}  Action_class_name  EmailBody  L1  L2  L3  L4         
