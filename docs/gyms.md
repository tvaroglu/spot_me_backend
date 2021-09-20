# Gyms Endpoints

HTTP Verb | Endpoint                   | Description                | Link
----------|----------------------------|----------------------------|---------------------------
POST       | `/users/{user_id}/gym_memberships` | Create a new gym member.     | [Link](#create-new-gym-member)
DELETE       | `/users/{user_id}/gym_memberships/{gym_membership_id}` | Remove an existing gym member.     | [Link](#remove-existing-gym-member)


---

## Create New Gym Member

Add a gym to the user's dashboard.

```
POST /users/{user_id}/gym_memberships
```


### Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`user_id` | String | Body | Required | The id of the user record.
`gym_id` | String | Body | Required | The id of the gym record.


### Example Request

```
POST https://spotme-app-api.herokuapp.com/api/v1/users/1/gym_memberships
```

### Example Response (Successful)

```
Status: 201 Created
```

```
{:data=>
  {:id=>"3995",
   :type=>"gym_membership",
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
DELETE /users/{user_id}/gym_memberships/{gym_membership_id}
```


### Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`user_id` | String | Body | Required | The id of the user record.
`gym_id` | String | Body | Required | The id of the gym record.


### Example Request

```
DELETE https://spotme-app-api.herokuapp.com/api/v1/users/1/gym_memberships/1
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
