import requests
import json

# URL to send the POST request to
url = "http://localhost:3000/api/v1/faculty"

# Data to be sent in the POST request
payload = {
  "employee_id": "700918",
  "employee_email": "ramx@gitam.edu",
  "employee_name": "Ram X",
  "designation": "Assistant Professor",
  "joining_date": "2024-07-31",
  "department_id": "301",
  "password": "caia123"
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