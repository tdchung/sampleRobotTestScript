import sys
import re

class MyCustomLibrary:
    """This is the example library for robot framework"""

    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    def __init__(self):
        pass

    def is_string_have_A(self, input_data):
        """Demo check if string have a charater 'A'"""
        for i in range(len(input_data)):
            if input_data[i] == 'A':
                return
        raise AssertionError("String is not expected")
