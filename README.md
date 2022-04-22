# Tea Service

## What is Tea Service?
- Tea Service is a "take home" for the technical portion of a job interview.
- A Backend application with endpoints that allow users to subscribe to different teas they find interesting.
- This repository is made using `rails v. 5.2.7`

## How to run tests for this repository
1. `git clone` this repository.
2. `cd tea_service`
3. run `bundle exec rspec` to see the passing tests!
4. All testing can be found in `/spec` directory.

## Endpoint Information:

### Get All User Subscriptions
- `GET '/api/v1/subscriptions'`
```json
{
  "user_id": "<user_id>"
}
```

### Get All Active User Subscriptions
- `GET '/api/v1/subscriptions'`
```json
{
  "user_id": "<user_id>",
  "status": "active"
}
```

### Get All Cancelled User Subscriptions
- `GET '/api/v1/subscriptions'`
```json
{
  "user_id": "<user_id>",
  "status": "cancelled"
}
```

### Cancel A subscription
- `DELETE '/api/v1/subscriptions'`
```json
{
  "tea_id": "<tea_id>"
}
```

### Create a new Subscription
- `'POST '/api/v1/subscriptions'`
```json
{
  "email": "<email>",
  "tea_id": "<tea_id>"
}
```

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/90fcbcf72d555bcbc462?action=collection%2Fimport)

## Database Design Schema
<img width="725" alt="Screen Shot 2022-04-20 at 10 30 25 AM" src="https://user-images.githubusercontent.com/69736499/164280862-e0411530-e22f-42f3-8c6e-4d7473027d1e.png">
