# Gym Search Endpoints

HTTP Verb | Endpoint                   | Description                | Link
----------|----------------------------|----------------------------|---------------------------
GET       | `/gym_search` | Retrieve gyms from the Yelp API by zip code.     | [Link](#find-gyms)
GET       | `/gym_search/{yelp_gym_id}` | View a single gym from the Yelp API.     | [Link](#view-gym)


---
## Find Gyms

Returns all gyms from the Yelp API within a 40k meter radius of the user's zip code.

```
GET /gym_search
```


### Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`zip_code`  | String      | Query Parameters  | Required          | The zip code to search for gyms in.

### Example Request

```
GET https://spotme-app-api.herokuapp.com/api/v1/gym_search?zip_code=80302
```

### Example Response

```
Status: 200 OK
```

```
{"data": [
  {
    "id": "c4bIf9XLgG1-CGuPl_QgWw",
    "type": "gym",
    "attributes": {
      "name": "Yoga in Your Park",
      "address": "Boulder, CO 80302",
      "phone": "(207) 664-9220",
      "gym_member_count": 10
      }
    },
    {
      "id": "EAg1SRtEr_0xrd1NJndnPg",
      "type": "gym",
      "attributes": {
        "name": "Origins Rolfing",
        "address": "745 Poplar Ave, Boulder, CO 80304",
        "phone": "(720) 260-4893",
        "gym_member_count": 0
        }
     }]
 }
```

### Example Request (Invalid Zip Code)

```
Status: 400 Bad Request
```

```
{
  "error": "Invalid zip code",
  "status": "Bad Request",
  "code": 400
}
```

---

## View Gym

Returns a single gym from the Yelp API.

```
GET `/gym_search/{yelp_gym_id}`
```

### Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`yelp_gym_id`  | String      | Path  | Required          | The Yelp gym id of the gym record.

### Example Request

```
GET https://spotme-app-api.herokuapp.com/api/v1/gym_search/c4bIf9XLgG1-CGuPl_QgWw
```

### Example Response

```
Status: 200 OK
```

```
{
  "data": {
    "id": "c4bIf9XLgG1-CGuPl_QgWw",
    "type": "gym",
    "attributes": {
      "name": "Yoga in Your Park",
      "address": "Boulder, CO 80302",
      "phone": "(207) 664-9220"
    }
  }
}
```

### Example Request (Invalid Gym Id)

```
Status: 400 Bad Request
```

```
{
  "error": "Invalid ID length",
  "status": "Bad Request",
  "code": 400
}
```
