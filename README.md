<div align="center">

[![Contributors][contributors-badge]][contributors-url]
[![Forks][forks-badge]][forks-url]
[![Stargazers][stars-badge]][stars-url]
[![Issues][issues-badge]][issues-url]
<br>
![Version][version-badge]
[![Ruby Style Guide][rubocop-badge]][rubocop-url]
![Build][build-badge]

# [SpotMe](https://spotme-app.herokuapp.com/) (BE)

This is the back-end architecture of the Spot-Me application, which exposes resources for the fitness application front end by consuming the Google OAuth and Yelp APIs, allowing users to perform the functions described within the application. Google OAuth allows the app to authorize users and retrieve data, such as their name, email address, Google ID, Google image URL, and zip code. Yelp allows the application users to search for specific gyms within an input location (city, state, and/or zip code) based on a predefined radius.

#### SpotMe allows users to:<br>
⭐Search for gyms in their local area<br>
⭐Add gyms to their account<br>
⭐Search for swol-mates that have a gym(s) in common<br>
⭐Add/delete swol-mates as friends<br>
⭐Schedule/delete workout sessions with swol-mates<br><br>

# <a href="https://github.com/tvaroglu/spot_me_frontend"><img src="https://img.shields.io/static/v1?style=flat-square&label=Spot+Me&message=Front+End+Repo&color=9cf"></a><br/><br/>

## Contributors

|Brian Fletcher|Caroline Tan|Ezzedine Alwafai|Gunnar Runkle|Scott Borecki|Taylor Varoglu
|--- |--- |--- |--- |--- |--- |
|[GitHub](https://github.com/bfl3tch)|[GitHub](https://github.com/carolinectan)|[GitHub](https://github.com/ealwafai)|[GitHub](https://github.com/gunnarrunner)|[GitHub](https://github.com/Scott-Borecki)|[GitHub](https://github.com/tvaroglu)
|[LinkedIn](https://www.linkedin.com/in/bfl3tch/)|[LinkedIn](https://www.linkedin.com/in/carolinectan/)|[LinkedIn](https://www.linkedin.com/in/ezzedine-alwafai/)|[LinkedIn](https://www.linkedin.com/in/gunnar-runkle/)|[LinkedIn](https://www.linkedin.com/in/scott-borecki/)|[LinkedIn](https://www.linkedin.com/in/taylorvaroglu/)

<br>
</div>

<div align="center">

## Table of Contents
|Links
|--- |
[Tools Used](#tools-used)
[Endpoints](#endpoints)
[Project Overview](#project-overview)
[Learning Goals](#learning-goals)
[Database Schema](#database-schema)


<br><br>
## Tools Used

  |Development|Development|Testing|Deployment
  |--- |--- |--- |--- |
  |[Ruby 2.7.2](https://www.ruby-lang.org/en/downloads/)|[Bootstrap](https://rubygems.org/gems/bootstrap/versions/4.0.0)|[RSpec for Rails](https://github.com/rspec/rspec-rails)|[Heroku](http://virtual-watch-party.herokuapp.com)|
  |[Rails 5.2.6](https://rubygems.org/gems/rails/versions/5.2.6)|[GitHub](https://desktop.github.com/)|[Capybara](https://github.com/teamcapybara/capybara)|[Travis CI](https://travis-ci.org/)|
  |[Pry](https://rubygems.org/gems/pry/versions/0.10.3)|[Git](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup)|[Webmock](https://github.com/bblimke/webmock)|
  |[PostgresQL](https://www.postgresql.org/)|[HTML](https://developer.mozilla.org/en-US/docs/Web/HTML)|[SimpleCov](https://rubygems.org/gems/simplecov/versions/0.12.0)|
 |[OmniAuth Google OAuth2](https://github.com/zquestz/omniauth-google-oauth2)|[CSS](https://developer.mozilla.org/en-US/docs/Web/CSS)|
 |[Postico](https://eggerapps.at/postico/)|[Rubocop](https://rubygems.org/gems/rubocop/versions/0.39.0)|
 |[Faraday](https://github.com/lostisland/faraday)|[Atom](https://atom.io/)|
 |[Figaro](https://github.com/laserlemon/figaro)|[FactoryBot](https://github.com/thoughtbot/factory_bot)|
 |[Postman](https://www.postman.com/product/rest-client/)|


<br>
</div>


## Endpoints

The `base path` of each endpoint is:

```
https://spotme-app.herokuapp.com/api/v1
```

- For `GET` requests, you can send the endpoint requests through your internet browser, or utilize an API client (i.e. [Postman][postman-url])
- For any other requests (i.e. `POST`, `PATCH`, `DELETE`), you will need to use an API client to provide the required request body


The following table presents each API endpoint and its associated documentation
- For `GET` requests, an example link is provided for demonstration purposes.  
<!-- - Unless otherwise noted, the results are sorted by name in case-sensitive alphabetical order (i.e. A-Z then a-z). -->

Endpoint | Docs | Example
---------|------|--------
**Users** | [docs](/docs/users.md)
Get Existing User | [docs](/docs/users.md#get-one-user) | [example](https://spotme-app-api.herokuapp.com/api/v1/users/1)
Create New User | [docs](/docs/users.md#create-new-user) |
Update Existing User | [docs](/docs/users.md#update-existing-user) |
Get User's Gyms | [docs](/docs/users.md#get-user-gyms) | [example](https://spotme-app-api.herokuapp.com/api/v1/users/1/gyms)
Get User's Friends | [docs](/docs/users.md#get-user-friends) | [example](https://spotme-app-api.herokuapp.com/api/v1/users/1/friendships)
Get User's Events | [docs](/docs/users.md#get-user-events) | [example](https://spotme-app-api.herokuapp.com/api/v1/users/1/events)
**Friends** | [docs][friendships-endpoints-link]
Add Friend | [docs][add-friend-docs] |
Remove Friend | [docs][remove-friend-docs] |
**Events** | [docs][events-endpoints-link]
Get User New Event Page | [docs][get-user-event-new-page-docs] | [example][get-user-event-new-ex]
Create User New Event | [docs][create-user-event-docs] |
**Gyms** | [docs][gyms-endpoints-link]
Get Gyms Near User | [docs][get-gyms-near-user-docs] | [example][get-gyms-near-user-ex]
Get Gym Show Page | [docs][get-gym-show-page-docs] | [example][get-gym-show-page-ex]
Get User Gym Show Page | [docs][get-user-gym-show-page-docs] | [example][get-user-gym-show-page-ex]
Add Gym Member | [docs][add-gym-member-docs] |
Remove Gym | [docs][remove-gym-docs] |

<!-- Note: Did not add unvetted endpoints:
GET /users/:id/events
GET /events/:id
GET /users/search
DELETE /events/:id
PATCH /events/:id
POST /gyms
-->


## Project Overview

This project was developed by Brian Fletcher, Caroline Tan, Ezzedine Alwafai, Gunnar Runkle, Scott Borecki, and Taylor Varoglu during Mod 3 of Turing School's Back End Engineering Program.  Created from scratch and deployed to Heroku, this project consists of a front-end and back-end Ruby on Rails application that was completed in 10 days.

The project description and base requirements can be found  [here][consultancy-home]

In addition to the base project requirements, some extra explorations and extensions completed included:

- Validating query params by leveraging ActiveModel::Validations
- Using customized FactoryBot methods to significantly DRY up code in test files
- Using RSpec's Shared Examples feature for frequently-used tests to DRY up code in test files
- Documenting complicated methods in general accordance with [TomDoc](http://tomdoc.org/) for Ruby specifications
- Creating documentation for each API endpoint to assist user in production
- Using GitHub Projects to track user stories and progress, as well as creating new issues
- Implementing RuboCop and RuboCop extensions for code styling and best practices
- Deploying the API to Heroku for production


### Learning Goals

  - ⭐ Consume two or more external APIs which require authentication
  - ⭐ Build APIs that return JSON responses
  - ⭐ Use an external OAuth provider to authenticate users
  - ⭐ Create a project with a separate front end and back end
  - ⭐ Apply RuboCop’s style guide for code quality
  - ⭐ Organize and refactor code to be more maintainable
  - ⭐ Implement a self-referential relationship in ActiveRecord
  - ⭐ Create instance and class methods on a Rails model that use ActiveRecord methods and helpers
  - ⭐ Use Rails to create web pages that allow users to CRUD resources
  - ⭐ Write model and feature tests that fully cover data logic and potential user behavior
  - ⭐ Utilize Continuous Integration via Travis CI
  - ⭐ Deploy to Heroku
  - ⭐ Implement a production-quality user interface using Bootstrap or other common CSS styling framework
  - ⭐ Implement agile project management by using project boards, participating in daily stand-ups and team retros
  - ⭐ Utilize quality workflow practices: small commits, descriptive pull requests, and code reviews
  - ⭐ Write thorough, understandable documentation


## Database Schema

![schema](https://user-images.githubusercontent.com/81220681/133701997-2e8a1242-d274-4bf2-af16-9f6c2a8a8480.png)

<!-- Top Level Badges and Links -->
[rubocop-badge]: https://img.shields.io/badge/code_style-rubocop-brightgreen.svg?style=flat-square
[rubocop-url]: https://github.com/rubocop/rubocop
[version-badge]: https://img.shields.io/badge/API_version-V1-or.svg?&style=flat-square&logoColor=white
[contributors-badge]: https://img.shields.io/github/contributors/tvaroglu/spot_me_backend.svg?style=flat-square
[contributors-url]: https://github.com/tvaroglu/spot_me_backend/graphs/contributors
[forks-badge]: https://img.shields.io/github/forks/tvaroglu/spot_me_backend.svg?style=flat-square
[forks-url]: https://github.com/tvaroglu/spot_me_backend/network/members
[stars-badge]: https://img.shields.io/github/stars/tvaroglu/spot_me_backend.svg?style=flat-square
[stars-url]: https://github.com/tvaroglu/spot_me_backend/stargazers
[issues-badge]: https://img.shields.io/github/issues/tvaroglu/spot_me_backend.svg?style=flat-square
[issues-url]: https://github.com/tvaroglu/spot_me_backend/issues
[build-badge]: https://img.shields.io/travis/tvaroglu/spot_me_backend?style=flat-square


<!-- Docs -->
<!-- Create .md files for each endpoint then link after each ": " with appropriate file path -->
<!-- [users-endpoints-link]: <!-- enter file path here i.e. /docs/get_users.md -->
<!-- [get-user-dashboard-docs]:
[get-user-profile-docs]:
[update-user-docs]:
[create-register-new-user-docs]:
[friendships-endpoints-link]:
[add-friend-docs]:
[remove-friend-docs]:
[events-endpoints-link]:
[create-user-event-docs]:
[create-user-event-new-page-docs]:
[gyms-endpoints-link]:
[add-gym-member-docs]:
[remove-gym-docs]:
[get-gyms-near-user-docs]:
[get-user-gym-show-page-docs]:
[get-gym-show-page-docs]: -->

<!-- Docs Template -->
<!-- [merchants-endpoints-link]: /doc/merchants_endpoints.md -->

<!-- Examples -->
<!-- [get-user-dashboard-ex]: <!-- enter URL here i.e. https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants?page=1&per_page=3 -->
<!-- [get-user-profile-ex]: <!-- enter URL here i.e. https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants?page=1&per_page=3 -->
<!-- [update-user-ex]: <!-- enter URL here i.e. https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants?page=1&per_page=3 -->
<!-- [create-register-new-user-ex]: <!-- enter URL here i.e. https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants?page=1&per_page=3 -->
<!-- [add-friend-ex]: <!-- enter URL here i.e. https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants?page=1&per_page=3 -->
<!-- [remove-friend-ex]: <!-- enter URL here i.e. https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants?page=1&per_page=3 -->
<!-- [create-user-event-ex]: <!-- enter URL here i.e. https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants?page=1&per_page=3 -->
<!-- [create-user-event-new-ex]: <!-- enter URL here i.e. https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants?page=1&per_page=3 -->
<!-- [add-gym-member-ex]: <!-- enter URL here i.e. https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants?page=1&per_page=3 -->
<!-- [remove-gym-ex]: <!-- enter URL here i.e. https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants?page=1&per_page=3 -->
<!-- [get-gyms-near-user-ex]: <!-- enter URL here i.e. https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants?page=1&per_page=3 -->
<!-- [get-user-gym-show-page-ex]: <!-- enter URL here i.e. https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants?page=1&per_page=3 -->
<!-- [get-gym-show-page-ex]: <!-- enter URL here i.e. https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants?page=1&per_page=3 -->


<!-- Examples Template-->
<!-- [get-all-merchants-ex]: https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants?page=1&per_page=3 -->

<!-- Links -->
[Repository]: https://github.com/tvaroglu/spot_me_backend
[postman-url]: https://www.postman.com/
[consultancy-home]: https://backend.turing.edu/module3/projects/consultancy/

<!-- Badges -->
[github-follow-badge]: https://img.shields.io/github/followers/scott-borecki?label=follow&style=social
[gmail-badge]: https://img.shields.io/badge/gmail-scottborecki@gmail.com-green?style=flat&logo=gmail&logoColor=white&color=white&labelColor=EA4335
[linkedin-badge]: https://img.shields.io/badge/Scott--Borecki-%23OpenToWork-green?style=flat&logo=Linkedin&logoColor=white&color=success&labelColor=0A66C2

<!-- Images -->
[github-avatar]: https://avatars.githubusercontent.com/u/79381792?s=100
