# Friendships Endpoints

  HTTP Verb | Endpoint                   | Description                    | Link
  ----------|----------------------------|--------------------------------|---------------------------
  GET       | `/users/{user_id}/friendships` | Get a user's friends.      | [Link](#get-users-friends)
  POST      | `/users/{user_id}/friendships` | Create a new friendship.   | [Link](#create-new-friendship)
  DELETE    | `/users/{user_id}/friendships/{followee_id}` | Delete an existing friendship. | [Link](#delete-friendship)

---

## Get User's Friends

  Returns a user's friends (`followees`).

  ```
  GET /users/{user_id}/friendships
  ```

### Parameters

  Name       | Data Type    | In    | Required/Optional | Description
  -----------|--------------|-------|-------------------|------------
  `user_id`  | Integer      | Path  | Required          | The ID of the user.
  `relationship`  | String      | Query Parameters  | Optional          | Return the user's  `followers` (vs `followees`).

### Example Request

  ```
  GET https://spotme-app-api.herokuapp.com/api/v1/users/1/friendships
  ```

### Example Response

  When the user has friends:

  ```
  Status: 200 OK
  ```

  ```
  {
    "data":[
      {
        "id":"5071",
        "type":"user",
        "attributes":{
          "email":"rich@lynch-heller.name",
          "google_id":"123456789102345678910",
          "google_image_url":
           "https://robohash.org/isteanimiillum.png?size=300x300&set=set1",
          "zip_code":"01498",
          "summary":
           "Know how to listen, and you will profit even from those who talk badly.",
          "goal":4,
          "availability_morning":false,
          "availability_afternoon":false,
          "availability_evening":false,
          "full_name":"Toni Mitchell"
        }
      },
      {
        "id":"5072",
        "type":"user",
        "attributes":{
          "email":"catina_altenwerth@wyman.name",
          "google_id":"198765432101987654321",
          "google_image_url":
           "https://robohash.org/officiapariaturdolorem.png?size=300x300&set=set1",
          "zip_code":"42574",
          "summary":"Love is composed of a single soul inhabiting two bodies.",
          "goal":4,
          "availability_morning":false,
          "availability_afternoon":false,
          "availability_evening":true,
          "full_name":"Vince Dickens"
        }
      }
    ]
  }
  ```

## Get User's Followers

  Returns a user's followers.

  ```
  GET /users/{user_id}/friendships
  ```

### Parameters

  Name       | Data Type    | In    | Required/Optional | Description
  -----------|--------------|-------|-------------------|------------
  `user_id`  | Integer      | Path  | Required          | The ID of the user.
  `relationship`  | String      | Query Parameters  | Required          | Return the user's  `followers` (vs `followees`).

### Example Request

  ```
  GET https://spotme-app-api.herokuapp.com/api/v1/users/1/friendships?relationship=followers
  ```

### Example Response

  When the user has followers:

  ```
  Status: 200 OK
  ```

  ```
  {
    "data":[
      {
        "id":"5071",
        "type":"user",
        "attributes":{
          "email":"rich@lynch-heller.name",
          "google_id":"123456789102345678910",
          "google_image_url":
           "https://robohash.org/isteanimiillum.png?size=300x300&set=set1",
          "zip_code":"01498",
          "summary":
           "Know how to listen, and you will profit even from those who talk badly.",
          "goal":4,
          "availability_morning":false,
          "availability_afternoon":false,
          "availability_evening":false,
          "full_name":"Toni Mitchell"
        }
      },
      {
        "id":"5072",
        "type":"user",
        "attributes":{
          "email":"catina_altenwerth@wyman.name",
          "google_id":"198765432101987654321",
          "google_image_url":
           "https://robohash.org/officiapariaturdolorem.png?size=300x300&set=set1",
          "zip_code":"42574",
          "summary":"Love is composed of a single soul inhabiting two bodies.",
          "goal":4,
          "availability_morning":false,
          "availability_afternoon":false,
          "availability_evening":true,
          "full_name":"Vince Dickens"
        }
      }
    ]
  }
  ```

### Example Response

  When the user has no friends:

  ```
  Status: 200 OK
  ```

  ```
  {
    "data":[]
  }
  ```

### Resource Not Found

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

## Create New Friendship

  Create a new friendship.

  ```
  POST /users/{user_id}/friendships
  ```

### Parameters

  Name       | Data Type    | In    | Required/Optional | Description
  -----------|--------------|-------|-------------------|------------
  `user_id`  | Integer      | Path  | Required          | The ID of the user.

### Request Body

  Name          | Data Type    | Required/Optional | Description
  --------------|--------------|-------------------|------------
  `followee_id` | Integer      | Required          | The ID of the friend user.

### Example Request

  ```
  POST https://spotme-app-api.herokuapp.com/api/v1/users/1/friendships
  ```

  With the following request body:

  ```
  {
    followee_id: 2
  }
  ```

### Example Response

  ```
  Status: 201 Created
  ```

  ```
  {
    "data":{
      "id":"1",
      "type":"friendship",
      "attributes":{
        "follower_id":1,
        "followee_id":2
      }
    }
  }
  ```

### Friend User Not Found

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

## Delete Friendship

  Delete an existing friendship.

  ```
  DELETE /users/{user_id}/friendships/{followee_id}
  ```

### Parameters

  Name       | Data Type    | In    | Required/Optional | Description
  -----------|--------------|-------|-------------------|------------
  `user_id` | String | Path | Required | The id of the user record.
  `followee_id` | String | Path | Required | The id of the followed user.

### Example Request

  ```
  DELETE https://spotme-app-api.herokuapp.com/api/v1/users/1/friendships/1
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

### Friend User Not Found

  ```
  Status: 404 Not Found
  ```

  ```
  {
    "message":"your query could not be completed",
    "errors":["Couldn't find User with 'id'=1084"]
  }
  ```
