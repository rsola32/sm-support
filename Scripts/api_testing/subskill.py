import requests
import json

# URL to send the POST request to
url = "http://localhost:3000/api/v1/subskill"

# Data to be sent in the POST request
payload = {
    "subskill_id" : "Java102xx",
    "subskill_name" : "ITC",
    "subskill_description" : "NA",
    "skill_id" : "Java102",
    "required" : True
}

myheaders = {
    "User-Agent": "curl/7.81.0",
    "Accept": "*/*",
    "Content-Type" : "application/json"
}

print(json.dumps(payload))
# Sending the POST request
response = requests.post(url, data=json.dumps(payload), headers=myheaders, verify=False)

# Printing the response
print("Status Code:", response.status_code)
print("Response Body:", response.text)