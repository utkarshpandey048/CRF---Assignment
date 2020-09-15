import unittest
import python_file as lib

"""Pre-requisites: reg_1 and reg_2 should be registered in the system.RobotUI tests should
be run before executing these unittests."""

REG1 = "Ut_pandey_1990_1"
REG2 = "Ut_pandey_1990_2"
PASSWORD = "12345"
NOT_REG = "xyz"
WRONG_PASSWORD = "1234"
USERINFO = {'lastname': 'Pandey', 'firstname': 'Utkarsh', 'phone': '0403456787'}
UPDATED_USER_INFO = {'lastname': 'PandeyUpdatedUnit', 'firstname': 'UtkarshUpdatedUnit', 'phone': '879327439'}

class TestMethods(unittest.TestCase):

    """Review users registered in the system.This test looks for a registered username in the system so the "status"
     should be True and it will print all the users present in the system."""
    def test_review_users_registered_in_system(self):
        url = "http://0.0.0.0:8080/api/users"
        status, usernames = lib.check_user_registered_in_system(url, REG1)
        self.assertIn(REG1, usernames)
        self.assertTrue(status)


    """status should be False when you search the user who is not registered in the system.This test looks for a not
    registered username in the system so the "status" should be False"""
    def test_search_user_not_registered_in_system(self):
        url = "http://0.0.0.0:8080/api/users"
        status, usernames = lib.check_user_registered_in_system(url, NOT_REG)
        self.assertNotIn(NOT_REG, usernames)
        self.assertFalse(status)


    """Authenticate user with username and password and retrieve the token."status" should be "True" in this case as
    the correct user credentials are used to authenticate."""
    def test_get_auth_token_for_registered_user(self):
        url = "http://0.0.0.0:8080/api/auth/token"
        status, token = lib.authenticate_user_and_get_token(url, REG1, PASSWORD)
        self.assertNotEqual(token, "Invalid")
        self.assertTrue(status)


    """Try to authenticate user with invalid credentials."status" should be "False" in this case as the incorrect user credentials
    are used to authenticate. """
    def test_get_auth_token_with_invalid_credentials_for_a_user(self):
        url = "http://0.0.0.0:8080/api/auth/token"
        status, token = lib.authenticate_user_and_get_token(url, REG1, WRONG_PASSWORD)
        self.assertEqual(token, "Invalid")
        self.assertFalse(status)


    """Get user info for a user after authenticating the user"""
    def test_get_user_info_for_a_user(self):
         url = "http://0.0.0.0:8080/api/auth/token"
         status, token = lib.authenticate_user_and_get_token(url, REG1, PASSWORD)
         url = "http://0.0.0.0:8080/api/users/" + REG1
         data = lib.get_user_info(url, token)
         self.assertEqual(USERINFO, data)

         
    """ Update user info for reg_username_2 and verify that the details are updated successfully """
    def test_update_user_info_for_a_user(self):
         url = "http://0.0.0.0:8080/api/auth/token"
         status, token = lib.authenticate_user_and_get_token(url, REG2, PASSWORD)
         url = "http://0.0.0.0:8080/api/users/" +REG2
         data = lib.update_user_info(url, token, UPDATED_USER_INFO)
         data = lib.get_user_info(url, token)
         self.assertEqual(UPDATED_USER_INFO, data)



if __name__ == '__main__':
    unittest.main()
