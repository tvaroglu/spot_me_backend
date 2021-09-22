# Gym Memberships Endpoints

HTTP Verb | Endpoint                   | Description                | Link
----------|----------------------------|----------------------------|---------------------------
GET       | `/users/{user_id}/gym_members?yelp_gym_id={yelp_gym_id}` | Get users that belong to the same gym.     | [Link](#get-users-at-same-gym)
GET       | `/users/{user_id}/gym_memberships` | Get a user's gym memberships.     | [Link](#get-users-gym-memberships)
POST      | `/users/{user_id}/gym_memberships` | Create gym membership.     | [Link](#create-gym-membership)
DELETE    | `/users/{user_id}/gym_memberships/{gym_membership_id}` | Remove a gym membership from a user.     | [Link](#delete-gym-membership)

---

## Get Users at Same Gym

Returns all users that belong to the same gym that the user is not already friends with.

```
GET /users/{user_id}/gym_members?yelp_gym_id={yelp_gym_id}
```


### Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`user_id`  | Integer      | Path  | Required          | The ID of the user.
`yelp_gym_id`  | String      | Path  | Required          | The Yelp gym ID of the gym.

### Example Request

```
GET https://spotme-app-api.herokuapp.com/api/v1/users/1/gym_members?yelp_gym_id=lex65fkcol5gfq89rymmd2
```

### Example Response

#### When there are users at the gym that the user isn't already friends with

```
Status: 200 OK
```

```
{
  "data": [
  {
    "id": "4",
    "type": "user",
    "attributes": {
      "email": "cordell_doyle@williamson.net",
      "google_id": "5zfwrgzcm0xx6wxwqd07d",
      "google_image_url": "https://robohash.org/rationesitdeleniti.png?size=300x300&set=set1",
      "zip_code": "96808",
      "summary": "Beware the barrenness of a busy life.",
      "goal": "Increase Stamina",
      "availability_morning": true,
      "availability_afternoon": true,
      "availability_evening": false,
      "full_name": "Isobel Huels"
    }
  },
  {
    "id": "7",
    "type": "user",
    "attributes": {
      "email": "venetta@kilback.io",
      "google_id": "mun5m26nj31nfi6jc4xf7",
      "google_image_url": "https://robohash.org/aliquidexreprehenderit.png?size=300x300&set=set1",
      "zip_code": "48703",
      "summary": "Dignity does not consist in possessing honors, but in deserving them.",
      "goal": "Increase Flexibility",
      "availability_morning": true,
      "availability_afternoon": true,
      "availability_evening": true,
      "full_name": "Monty Beer"
    }
  }]
}
```

#### When the user is already friends with all other users at the same gym

```
Status: 200 OK
```

```
{
  :data=>[]
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

---

## Get User's Gym Memberships

Returns a user's gym memberships.

```
GET /users/{user_id}/gym_memberships
```


### Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`user_id`  | Integer      | Path  | Required          | The ID of the user.

### Example Request

```
GET https://spotme-app-api.herokuapp.com/api/v1/users/1/gym_memberships
```

### Example Response

#### When the user has gym memberships

```
Status: 200 OK
```

```
{:data=>
  [
    {
      :id=>"7172", :type=>"gym_membership",
      :attributes=>{
        :user_id=>8355,
        :yelp_gym_id=>"mkmn8pidmebehvh79u1ovg",
        :gym_name=>"Blick, Hoppe and Cremin"
      }
    },
    {
      :id=>"7173",
      :type=>"gym_membership",
      :attributes=>{
        :user_id=>8355,
        :yelp_gym_id=>"fvdr0ksvy2nhith42ffur2",
        :gym_name=>"Labadie-Wyman"
      }
    }
  ]
}
```

#### When the user has no gym memberships

```
Status: 200 OK
```

```
{
  :data=>[]
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

---

## Create Gym Membership

Add a gym membership to a user.

```
POST /users/{user_id}/gym_memberships
```

### Parameters

Name       | Data Type    | In       | Required/Optional | Description
-----------|--------------|----------|-------------------|------------
`user_id`  | String       | Path     | Required          | The ID of the user record.

### Request Body

Attribute Name | Data Type | Required/Optional | Description
---------------|-----------|-------------------|------------
`yelp_gym_id`  | String    | Required          | The Yelp Gym ID.
`gym_name`     | String    | Required          | The name of the gym.

### Example Request

```
POST https://spotme-app-api.herokuapp.com/api/v1/users/1/gym_memberships
```

With the following request body:

```
{
  yelp_gym_id: 'c2jzsndq8brvn9fbckeec2',
  gym_name: 'Planet Fitness'
}
```

### Example Response

```
Status: 201 Created
```

```
{
  :data=>
    {
      :id=>"3995",
      :type=>"gym_membership",
      :attributes=>{
        :user_id=>1,
        :yelp_gym_id=>'c2jzsndq8brvn9fbckeec2',
        :gym_name=>'Planet Fitness'
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
  :errors=>["Couldn't find User with 'id'=1432"]
}
```

### Unprocessable Entity

When the Yelp Gym ID is not provided:

```
Status: 422 Unprocessable Entity
```

```
{
  :message=>"your query could not be completed",
  :errors=>["Yelp gym can't be blank"]
}
```

### Unprocessable Entity

When the gym name is not provided:

```
Status: 422 Unprocessable Entity
```

```
{
  :message=>"your query could not be completed",
  :errors=>["Gym name can't be blank"]
}
```

---

## Delete Gym Membership

Remove a gym membership from a user.

```
DELETE /users/{user_id}/gym_memberships/{gym_membership_id}
```

### Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`user_id` | String | Path | Required | The id of the user record.
`gym_membership_id` | String | Path | Required | The id of the gym record.

### Example Request

```
DELETE https://spotme-app-api.herokuapp.com/api/v1/users/1/gym_memberships/1
```

### Example Response

```
Status: 204 No Content

```

### User Not Found

```
Status: 404 Not Found
```

```
{
  :message=>"your query could not be completed",
  :errors=>["Couldn't find User with 'id'=4879"]
}
```

### Gym Membership Not Found

```
Status: 400 Bad Request
```

```
{
  :message=>"your query could not be completed",
  :errors=>["Couldn't find GymMembership with 'id'=1084"]
}
```
