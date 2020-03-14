*** Settings ***
Documentation    Example
Library          String

# import custom library
Library          ../CustomLib/MyCustomLibrary.py

*** Variables ***
${STRING_VAR}   "Hello World"
${LIST_VAR}    One Two Ten
${DIR_VAR}    bar=foo

*** Test Cases ***
TEST_SAMPLE_0001
    ${NEW_STRING}=    Convert To Lowercase    ${STRING_VAR}
    Should Be Equal    ${NEW_STRING}    "hello world"

TEST_SAMPLE_0002
    # should failed
    Is String Have A  "asdadsa"

    
TEST_SAMPLE_0003
    # should passed
    Is String Have A  "Hello, World! Should Pass. 'A'"