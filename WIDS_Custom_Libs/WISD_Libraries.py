import sys
import re
import json

# 
# import Robot.Collections
from robot.libraries.Collections import Collections
from robot.libraries.BuiltIn import BuiltIn

class WISD_Libraries:
    """This is the library was customize to use for robot framework and WIDS testing"""

    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    def __init__(self):
        pass

    def create_array_body_input(self, *items):
        """test"""
        output = []
        for item in items:
            # print(item)
            output.append(item)
        return output
    
    def validate_output_should_contain_keys(self, dictionary, *keys):
        for key in keys:
            Collections().dictionary_should_contain_key(dictionary, key)

    def validate_length_of_response(self, response, length):
        BuiltIn().should_be_equal(str(len(response)), length)

    def validate_array_response_contain_keys(self, response, *keys):
        for i in range(len(response)):
            for key in keys:
                Collections().dictionary_should_contain_key(response["{}".format(i+1)], key)