# Events Endpoints

HTTP Verb | Endpoint                   | Description                | Link
----------|----------------------------|----------------------------|---------------------------
GET       | `/users/{user_id}/events` | Get a user's events.     | [Link](#get-user-events)
POST       | `/users/{user_id}/gym_memberships/{gym_membership_id}/events` | Create a new event.     | [Link](#create-new-event)
DELETE       | `/users/{user_id}/gym_memberships/{gym_membership_id}/events/{event_id}` | Delete an  existing event.     | [Link](#delete-existing-event)


---

## Get User Events

Returns a user and their associated events.

```
GET /users/{user_id}/events
```


### Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`user_id` | Integer | Path | Required | The ID of the user.
`time_frame`  | String      | Query Parameters  | Optional          | Retrieve `past` events (vs  upcoming events).


### Example Request (Upcoming Events)

```
GET https://spotme-app-api.herokuapp.com/api/v1/users/1/events
```

### Example Response (Successful)
#### (if User has Events)
```
Status: 200 OK
```

```
{
  "data":[
    {
      "id":"1211",
      "type":"event",
      "attributes":
        {
          "user_id":5142,
          "gym_id":613,
          "date_time":"2021-09-21T13:37:24.508Z",
          "activity":"Lifting"
        },
      "meta":
      {
        "friend_name":"John Doe",
        "friend_role":"invited",
        "gym_name":"Planet Fitness",
        "yelp_gym_id":"c2jzsndq8brvn9fbckeec2"
      }
    },
    {
      "id":"1212",
      "type":"event",
      "attributes":
        {
          "user_id":5142,
          "gym_id":613,
          "date_time":"2021-09-20T13:37:24.511Z",
          "activity":"Cycling"
        },
      "meta":
      {
        "friend_name":"Jane Doe",
        "friend_role":"invited",
        "gym_name":"Planet Fitness",
        "yelp_gym_id":"c2jzsndq8brvn9fbckeec2"
      }
    },
    {
      "id":"1213",
      "type":"event",
      "attributes":
        {
          "user_id":5142,
          "gym_id":613,
          "date_time":"2021-09-23T13:37:24.513Z",
          "activity":"Cardio"
        },
      "meta":
      {
        "friend_name":"Joe Doe",
        "friend_role":"invited",
        "gym_name":"Planet Fitness",
        "yelp_gym_id":"c2jzsndq8brvn9fbckeec2"
      }
    }
  ]
}
```

### Example Request (Past Events)

```
GET https://spotme-app-api.herokuapp.com/api/v1/users/1/events?time_frame=past
```

### Example Response (Successful)
#### (if User has Events)
```
Status: 200 OK
```

```
{
  "data":[
    {
      "id":"1211",
      "type":"event",
      "attributes":
        {
          "user_id":5142,
          "gym_id":613,
          "date_time":"2021-09-21T13:37:24.508Z",
          "activity":"Lifting"
        },
      "meta":
      {
        "friend_name":"John Doe",
        "friend_role":"invited",
        "gym_name":"Planet Fitness",
        "yelp_gym_id":"c2jzsndq8brvn9fbckeec2"
      }
    },
    {
      "id":"1212",
      "type":"event",
      "attributes":
        {
          "user_id":5142,
          "gym_id":613,
          "date_time":"2021-09-20T13:37:24.511Z",
          "activity":"Cycling"
        },
      "meta":
      {
        "friend_name":"Jane Doe",
        "friend_role":"invited",
        "gym_name":"Planet Fitness",
        "yelp_gym_id":"c2jzsndq8brvn9fbckeec2"
      }
    },
    {
      "id":"1213",
      "type":"event",
      "attributes":
        {
          "user_id":5142,
          "gym_id":613,
          "date_time":"2021-09-23T13:37:24.513Z",
          "activity":"Cardio"
        },
      "meta":
      {
        "friend_name":"Joe Doe",
        "friend_role":"invited",
        "gym_name":"Planet Fitness",
        "yelp_gym_id":"c2jzsndq8brvn9fbckeec2"
      }
    }
  ]
}
```

### Example Response (Successful)
#### (if User doesn't have any events)

```
Status: 200 OK
```

```
{"data":[]}
```

### Example Response (Resource Not Found)

```
Status: 404 Not Found
```

```
{
  "message":"your query could not be completed",
  "errors":["Couldn't find User with 'id'=40"]
}
```

---

## Create New Event

Create a new event based on provided attributes.

```
POST /users/{user_id}/gym_memberships/{gym_membership_id}/events
```

### Request Body

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`user_id` | String | Path | Required | The id of the user invited to the event.
`gym_membership_id` | String | Path | Required | The id of the gym the event will take place at.
`activity` | String | Body | Required | The activity (title) of the event.
`date_time` | Datetime | Body | Required | The date and time of the event.


### Example Request

```
POST https://spotme-app-api.herokuapp.com/api/v1/users/1/gym_memberships/1/events
```

With the following request body:

```
{
  "date_time":"2022-09-24T00:24:11.000Z",
  "activity":"Lifting"
}
```

### Example Response (Successful)

```
Status: 201 Created
```

```
{
  "data":
    {
      "id":"1962",
      "type":"event",
      "attributes":
        {
          "user_id":4868,
          "gym_id":1055,
          "date_time":"2022-09-24T00:24:11.000Z",
          "activity":"Lifting"
        },
      "meta":
        {
          "friend_name":"Joe Doe",
          "friend_role":"invited",
          "gym_name":"Planet Fitness",
          "yelp_gym_id":"c2jzsndq8brvn9fbckeec2"
        }
    }
}
```

### Example Response (Unprocessable Entity)

```
Status: 422 Unprocessable Entity
```

```
{
  "message":"your record could not be saved",
  "errors":["Date time can't be blank"]
}
```

### Example Response (Bad Request)

```
Status: 400 Bad Request
```

```
{
  "message":"your query could not be completed",
  "errors":["User with 'id'=1432 is not a member of Gym with 'id'=666"]
}
```

### Example Response (User Not Found)

```
Status: 404 Not Found
```

```
{
  "message":"your query could not be completed",
  "errors":["Couldn't find User with 'id'=1432"]
}
```

### Example Response (Gym Not Found)

```
Status: 404 Not Found
```

```
{
  "message":"your query could not be completed",
  "errors":["Couldn't find Gym with 'id'=1432"]
}
```

---

## Delete Existing Event

Delete an existing event.

```
DELETE /users/{user_id}/gym_memberships/{gym_membership_id}/events/{event_id}
```

### Parameters

Name       | Data Type    | In    | Required/Optional | Description
-----------|--------------|-------|-------------------|------------
`user_id` | String | Path | Required | The id of the user.
`gym_membership_id` | String | Path | Required | The id of the gym membership.
`event_id` | String | Path | Required | The id of the event.

### Example Request

```
DELETE https://spotme-app-api.herokuapp.com/api/v1/users/1/gym_memberships/1/events/1
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
  "message":"your query could not be completed",
  "errors":["Couldn't find User with 'id'=4879"]
}
```

### Gym Not Found

```
Status: 404 Not Found
```

```
{
  "message":"your query could not be completed",
  "errors":["Couldn't find GymMembership with 'id'=1084"]
}
```

### Event Not Found

```
Status: 404 Not Found
```

```
{
  "message":"your query could not be completed",
  "errors":["Couldn't find Event with 'id'=420"]
}
```
