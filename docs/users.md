# Users Endpoints

HTTP Verb | Endpoint                   | Description                | Link
----------|----------------------------|----------------------------|---------------------------
GET       | `/users/{user_id}`         | Get a single user.         | [Link](#get-user)
POST      | `/users`                   | Create a new user.         | [Link](#create-new-user)
PATCH     | `/users/{user_id}`         | Update an existing user.   | [Link](#update-user)
GET       | `/users/{user_id}/friendships` | Get a user's friends.  | [Link](#get-user-friends)

---

## Get User

Returns a user and their attributes.

```
GET /users/{user_id}
```

### Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`user_id`  | Integer      | Path  | Required          | The ID of the user.

### Example Request

```
GET https://spotme-app-api.herokuapp.com/api/v1/users/1
```

### Example Response

```
Status: 200 OK
```

```
{
  :data=>{
    :id=>"4965",
    :type=>"user",
    :attributes=>{
      :email=>"ron_hermiston@schinner.net",
      :google_id=>"123456789102345678910",
      :google_image_url=>
        "https://robohash.org/doloribusutmagni.png?size=300x300&set=set1",
      :zip_code=>"55919",
      :summary=>"The secret to humor is surprise.",
      :goal=>4,
      :availability_morning=>false,
      :availability_afternoon=>true,
      :availability_evening=>true,
      :full_name=>"Alvaro Stanton"
    }
  }
}
```

### Resource Not Found

```
Status: 404 Not Found
```

```
{
  :message=>"your query could not be completed",
  :errors=>["Couldn't find User with 'id'=40"]
}
```

---

## Create New User

Create a new user based on their provided attributes.

```
POST /users
```


### Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`email` | String | Body | Required | The email of the user.
`google_id` | String | Body | Required | The Google id of the user.
`google_image_url` | String | Body | Required | The Google profile picture for the user.
`zip_code` | String | Body | Required | The zip code of the user.
`summary` | String | Body | Required | The summary of the user for their profile.
`goal` | Integer | Body | Required | The primary goal of the user.
`availability_morning` | Boolean | Body | Required | The morning availability of the user.
`availability_afternoon` | Boolean | Body | Required | The afternoon availability of the user.
`availability_evening` | Boolean | Body | Required | The evening availability of the user.
`full_name` | String | Body | Required | The name of the user.


### Example Request

```
POST https://spotme-app-api.herokuapp.com/api/v1/users
```

### Example Response

```
Status: 201 Created
```

```
{
  :data=>{
    :id=>"5265",
    :type=>"user",
    :attributes=>{
      :email=>"jenna@runolfsdottir.info",
      :google_id=>"123456789102345678910",
      :google_image_url=>
        "https://robohash.org/rerumnamenim.png?size=300x300&set=set1",
      :zip_code=>"41895",
      :summary=>
        "The virtue of justice consists in moderation, as regulated by wisdom.",
      :goal=>5,
      :availability_morning=>false,
      :availability_afternoon=>false,
      :availability_evening=>false,
      :full_name=>"Joann Champlin"
    }
  }
}
```

### Unprocessable Entity

```
Status: 422 Unprocessable Entity
```

```
{
  :message=>"your record could not be saved",
  :errors=>[
    "Email can't be blank",
    "Google id can't be blank",
    "Google image url can't be blank",
    "Zip code can't be blank",
    "Goal is not a number",
    "Summary can't be blank",
    "Full name can't be blank"
  ]
}
```

---

## Update User

Update an existing user based on provided attributes.

```
PATCH /users/{user_id}
```

### Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`user_id`  | Integer      | Path  | Required          | The ID of the user.

### Request Body

Name                      | Data Type | Required/Optional | Description
--------------------------|-----------|-------------------|------------
`full_name`               | String    | Optional          | The name of the user.
`email`                   | String    | Optional          | The email of the user.
`google_id`               | String    | Optional          | The Google id of the user.
`google_image_url`        | String    | Optional          | The Google profile picture for the user.
`zip_code`                | String    | Optional          | The zip code of the user.
`summary`                 | String    | Optional          | The summary of the user for their profile.
`goal`                    | Integer   | Optional          | The primary goal of the user.
`availability_morning`    | Boolean   | Optional          | The morning availability of the user.
`availability_afternoon`  | Boolean   | Optional          | The afternoon availability of the user.
`availability_evening`    | Boolean   | Optional          | The evening availability of the user.

### Example Request

```
PATCH https://spotme-app-api.herokuapp.com/api/v1/users/1
```

### Example Response

```
Status: 200 OK
```

```
{
  :data=>{
    :id=>"5265",
    :type=>"user",
    :attributes=>{
      :email=>"jenna@runolfsdottir.info",
      :google_id=>"123456789102345678910",
      :google_image_url=>
        "https://robohash.org/rerumnamenim.png?size=300x300&set=set1",
      :zip_code=>"41895",
      :summary=>
        "The virtue of justice consists in moderation, as regulated by wisdom.",
      :goal=>5,
      :availability_morning=>false,
      :availability_afternoon=>false,
      :availability_evening=>false,
      :full_name=>"Joann Champlin"
    }
  }
}
```

### User Not Found

```
Status: 404 Not Found
```

```
{
  :message=>"your query could not be completed",
  :errors=>["Couldn't find User with 'id'=40"]
}
```

### Unprocessable Entity

```
Status: 422 Unprocessable Entity
```

```
{
  :message=>"your record could not be saved",
  :errors=>[
    "Zip code can't be blank",
    "Goal is not a number",
    "Summary can't be blank",
    "Full name can't be blank"
  ]
}
```
