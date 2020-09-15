import json
import requests

"""This function checks for the users registered in the system.If the "username" is registered in the system then this function will return "True" status
along with all the users registered in the system.If the user is not registered in the system then it will return "False" along with all the users registered
in the system"""
def check_user_registered_in_system(url, username):
    headers = {'Content-Type': 'application/json'}
    resp = requests.get(url, headers=headers)
    json_data = json.loads(resp.text)
    usernames = json_data.get("payload")
    status = json_data.get("status")
    if(username in usernames):
        print(usernames)
    else:
        print("user not registered in the system")
    return bool(username in usernames and status == "SUCCESS"), usernames
"""This function autheticates the user with username and password.It will return "True" and the token value if the user is authenticated successfully.
 Else it will return "False" and the token value as "Invalid" """
def authenticate_user_and_get_token(url, username, password):
    headers = {'Content-Type': 'application/json'}
    resp = requests.get(url, auth=(username, password), headers=headers)
    json_data = json.loads(resp.text)
    token = json_data.get("token")
    status = json_data.get("status")
    if status == "SUCCESS":
        return True, token
    else:
        token = "Invalid"
        return False, token
"""This function gets the user information after authenticating the user."""    
def get_user_info(url, token):
    headers = {'Content-Type': 'application/json', 'Token': token}
    resp = requests.get(url, headers=headers)
    json_data = json.loads(resp.text)
    user_data = json_data.get("payload")
    user_data ={str(k): str(v) for k, v in user_data.items()}
    return user_data
"""This function updates the user information after authenticating the user"""
def update_user_info(url, token, payload):
    payload = json.dumps(payload)
    headers = {'Content-Type': 'application/json', 'Token': token}
    response = requests.put(url, data=payload, headers=headers)
    print(response.text)
