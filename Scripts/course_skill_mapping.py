import requests
import json

# URL to send the POST request to
url = "http://localhost:3000/api/v1/course_skill_mapping"

# Data to be sent in the POST request
payload = {
    "mapping_id" : "dummy2",
    "course_id" : "CSE3122",
    "skill_id" : "Java102",
    "skill_type" : "Tech/Core"
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