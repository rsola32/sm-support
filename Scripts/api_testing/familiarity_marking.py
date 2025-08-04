import requests
import json

# URL to send the POST request to
url = "http://localhost:3000/api/v1/familiarity_marking"

# Data to be sent in the POST request
payload = {
    "marking_id" : "M102",
    "subskill_id" : "Java101S1",
    "employee_id" : "700914",
    "familiarity" : True
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