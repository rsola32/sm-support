import requests
import json

# URL to send the POST request to
url = "http://localhost:3000/api/v1/course"

# Data to be sent in the POST request
payload = {
    "course_id"             : "CSE3122",
    "course_name"           : "Operating Systems",
    "course_category"       : "PC",
    "offered_department_id" : "301",
    "course_coordinator_id" : "700917",
    "course_champion_id"    : "700917",
    "caia_coordinator_id"   : "700917"
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