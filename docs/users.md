# Users Endpoints

HTTP Verb | Endpoint                   | Description                | Link
----------|----------------------------|----------------------------|---------------------------
GET       | `/users/{user_id}` | Get a single user.     | [Link](#get-one-user)
POST       | `/users` | Create a new user.     | [Link](#create-new-user)
PATCH       | `/users/{user_id}` | Update an existing user.     | [Link](#update-existing-user)
GET       | `/users/{:user_id}/gyms` | Get a user's gyms.     | [Link](#get-user-gyms)
GET       | `/users/{:user_id}/friendships` | Get a user's friends.     | [Link](#get-user-friends)

---

## Get One User

Returns a user and their attributes.

```
GET /users/{user_id}
```


### Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`user_id` | Integer | Path | Required | The ID of the user.

### Example Request

```
GET https://spotme-app-api.herokuapp.com/api/v1/users/1
```

### Example Response (Successful)

```
Status: 200 OK
```

```
{:data=>
  {:id=>"4965",
   :type=>"user",
   :attributes=>
    {:email=>"ron_hermiston@schinner.net",
     :google_id=>"123456789102345678910",
     :google_image_url=>
      "https://robohash.org/doloribusutmagni.png?size=300x300&set=set1",
     :zip_code=>"55919",
     :summary=>"The secret to humor is surprise.",
     :goal=>4,
     :availability_morning=>false,
     :availability_afternoon=>true,
     :availability_evening=>true,
     :full_name=>"Alvaro Stanton"}}
}
```

### Example Response (Resource Not Found)

```
Status: 404 Not Found
```

```
{:message=>"your query could not be completed",
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

### Example Response (Successful)

```
Status: 201 Created
```

```
{:data=>
  {:id=>"5265",
   :type=>"user",
   :attributes=>
    {:email=>"jenna@runolfsdottir.info",
     :google_id=>"123456789102345678910",
     :google_image_url=>"https://robohash.org/rerumnamenim.png?size=300x300&set=set1",
     :zip_code=>"41895",
     :summary=>"The virtue of justice consists in moderation, as regulated by wisdom.",
     :goal=>5,
     :availability_morning=>false,
     :availability_afternoon=>false,
     :availability_evening=>false,
     :full_name=>"Joann Champlin"}
  }
}
```

### Example Response (Unprocessable Entity)

```
Status: 422 Unprocessable Entity
```

```
{:message=>"your record could not be saved",
 :errors=>
  ["Email can't be blank",
   "Google id can't be blank",
   "Google image url can't be blank",
   "Zip code can't be blank",
   "Goal is not a number",
   "Summary can't be blank",
   "Full name can't be blank"]
}
```

---

## Update Existing User

Update an existing user based on provided attributes.

```
PATCH /users/{user_id}
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
PATCH https://spotme-app-api.herokuapp.com/api/v1/users/1
```

### Example Response (Successful)

```
Status: 200 OK
```

```
{:data=>
  {:id=>"5265",
   :type=>"user",
   :attributes=>
    {:email=>"jenna@runolfsdottir.info",
     :google_id=>"123456789102345678910",
     :google_image_url=>"https://robohash.org/rerumnamenim.png?size=300x300&set=set1",
     :zip_code=>"41895",
     :summary=>"The virtue of justice consists in moderation, as regulated by wisdom.",
     :goal=>5,
     :availability_morning=>false,
     :availability_afternoon=>false,
     :availability_evening=>false,
     :full_name=>"Joann Champlin"}
  }
}
```

### Example Response (Unprocessable Entity)

```
Status: 422 Unprocessable Entity
```

```
{:message=>"your record could not be saved",
 :errors=>
   "Zip code can't be blank",
   "Goal is not a number",
   "Summary can't be blank",
   "Full name can't be blank"]
}
```

---

## Get User Gyms

Returns a user and their associated gyms.

```
GET /users/{:user_id}/gyms
```


### Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`user_id` | Integer | Path | Required | The ID of the user.

### Example Request

```
GET https://spotme-app-api.herokuapp.com/api/v1/users/1/gyms
```

### Example Response (Successful)
#### (if User has registered to gyms)
```
Status: 200 OK
```

```
{:data=>
  [{:id=>"574",
    :type=>"gym",
    :attributes=>{:yelp_gym_id=>"12ic9bhcnd0tr8umv7e1mw"}},
   {:id=>"575",
    :type=>"gym",
    :attributes=>{:yelp_gym_id=>"n49x89v92nvrku8w0xztaz"}}]
}
```

### Example Response (Successful)
#### (if User hasn't registered to any gyms)

```
Status: 200 OK
```

```
{:data=>[]}
```

### Example Response (Resource Not Found)

```
Status: 404 Not Found
```

```
{:message=>"your query could not be completed",
 :errors=>["Couldn't find User with 'id'=40"]
}
```

---

## Get User Friends

Returns a user and their associated friends.

```
GET /users/{:user_id}/friendships
```


### Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`user_id` | Integer | Path | Required | The ID of the user.

### Example Request

```
GET https://spotme-app-api.herokuapp.com/api/v1/users/1/friendships
```

### Example Response (Successful)
#### (if User has friends)
```
Status: 200 OK
```

```
{:data=>
  [
   {:id=>"5071",
    :type=>"user",
    :attributes=>
     {:email=>"rich@lynch-heller.name",
      :google_id=>"123456789102345678910",
      :google_image_url=>
       "https://robohash.org/isteanimiillum.png?size=300x300&set=set1",
      :zip_code=>"01498",
      :summary=>
       "Know how to listen, and you will profit even from those who talk badly.",
      :goal=>5,
      :availability_morning=>false,
      :availability_afternoon=>false,
      :availability_evening=>false,
      :full_name=>"Toni Mitchell"}},
   {:id=>"5072",
    :type=>"user",
    :attributes=>
     {:email=>"catina_altenwerth@wyman.name",
      :google_id=>"198765432101987654321",
      :google_image_url=>
       "https://robohash.org/officiapariaturdolorem.png?size=300x300&set=set1",
      :zip_code=>"42574",
      :summary=>"Love is composed of a single soul inhabiting two bodies.",
      :goal=>4,
      :availability_morning=>false,
      :availability_afternoon=>false,
      :availability_evening=>true,
      :full_name=>"Vince Dickens"}}
  ]
}
```

### Example Response (Successful)
#### (if User doesn't have any friends)

```
Status: 200 OK
```

```
{:data=>[]}
```

### Example Response (Resource Not Found)

```
Status: 404 Not Found
```

```
{:message=>"your query could not be completed",
 :errors=>["Couldn't find User with 'id'=40"]
}
```
