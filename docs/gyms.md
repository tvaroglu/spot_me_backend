# Gyms Endpoints

HTTP Verb | Endpoint                   | Description                | Link
----------|----------------------------|----------------------------|---------------------------
GET       | `/gyms/{gym_id}` | Get a single gym.     | [Link](#get-gym)
POST       | `/users/{user_id}/gyms/{gym_id}/gym_members` | Create a new gym member.     | [Link](#create-new-gym-member)
DELETE       | `/users/{user_id}/gyms/{gym_id}` | Remove an existing gym member.     | [Link](#remove-existing-gym-member)

---

## Get Gym

Returns a gym and its attributes.

```
GET /gyms/{gym_id}
```


### Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`gym_id` | Integer | Path | Required | The ID of the gym.

### Example Request

```
GET https://spotme-app-api.herokuapp.com/api/v1/gyms/16
```

### Example Response (Successful)

```
Status: 200 OK
```

```
{:data=>
  {:id=>"1654",
   :type=>"gym",
   :attributes=>{
    :yelp_gym_id=>"preb6u3g2bot2u0ouivy02"
    :name=>"Planet Fitness"}}
}
```

### Example Response (Resource Not Found)

```
Status: 404 Not Found
```

```
{:message=>"your query could not be completed",
  :errors=>["Couldn't find Gym with 'id'=1684"]
}
```

---

## Create New Gym Member

Add a gym to the user's dashboard.

```
POST /users/{user_id}/gyms/{gym_id}/gym_members
```


### Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`user_id` | String | Body | Required | The id of the user record.
`gym_id` | String | Body | Required | The id of the gym record.


### Example Request

```
POST https://spotme-app-api.herokuapp.com/api/v1/users/31/gyms/16/gym_members
```

### Example Response (Successful)

```
Status: 201 Created
```

```
{:data=>
  {:id=>"3995",
   :type=>"gym_member",
   :attributes=>{:user_id=>5866, :gym_id=>1861}}
}
```

### Example Response (User Not Found)

```
Status: 404 Not Found
```

```
{:message=>"your query could not be completed",
  :errors=>["Couldn't find User with 'id'=1432"]
}
```

### Example Response (Gym Not Found)

```
Status: 404 Not Found
```

```
{:message=>"your query could not be completed",
  :errors=>["Couldn't find Gym with 'id'=5866"]
}
```

---

## Remove Existing Gym Member

Remove a gym from the user's dashboard.

```
DELETE /users/{user_id}/gyms/{gym_id}
```


### Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`user_id` | String | Body | Required | The id of the user record.
`gym_id` | String | Body | Required | The id of the gym record.


### Example Request

```
DELETE https://spotme-app-api.herokuapp.com/api/v1/users/31/gyms/16
```

### Example Response (No Content)

```
Status: 204 No Content

```

### Example Response (User Not Member of Gym)

```
Status: 400 Bad Request
```

```
{:message=>"your query could not be completed",
  :errors=>["User with 'id'=4897 is not a member of Gym with 'id'=1084"]
}
```

### Example Response (User Not Found)

```
Status: 404 Not Found
```

```
{:message=>"your query could not be completed",
  :errors=>["Couldn't find User with 'id'=4879"]
}
```

### Example Response (Gym Not Found)

```
Status: 404 Not Found
```

```
{:message=>"your query could not be completed",
  :errors=>["Couldn't find Gym with 'id'=1064"]
}
```
