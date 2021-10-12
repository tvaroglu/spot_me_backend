<div align="center">

![Version][version-badge]
[![Contributors][contributors-badge]][contributors-url]
[![Forks][forks-badge]][forks-url]
[![Stargazers][stars-badge]][stars-url]
[![Issues][issues-badge]][issues-url]
[![Ruby Style Guide][rubocop-badge]][rubocop-url]
![Build][build-badge]
[![SpotMe][front-end-badge]][front-end-url]

# [SpotMe](https://spotme-app.herokuapp.com/)

This is the back-end architecture of the SpotMe application, which exposes resources for the fitness application front end by consuming the Google OAuth 2.0 and Yelp APIs. Google OAuth allows the app to authorize users and retrieve data, such as their name, email address, zip code, Google ID, Google image URL, and Google token. The incorporation of the Yelp API allows users to search for gyms in their local area based on their zip code.

### SpotMe allows users to:<br>
&nbsp; &nbsp; 🏋🏽 &nbsp; Search for gyms in their local area 🏋 <br>
&nbsp; &nbsp; 🏋🏽 &nbsp; Add gyms to their account 🏋 <br>
&nbsp; &nbsp; 🏋🏽 &nbsp; Search for SwoleMates that have gyms in common 🏋 <br>
&nbsp; &nbsp; 🏋🏽 &nbsp; Add/delete SwoleMates as friends 🏋 <br>
&nbsp; &nbsp; 🏋🏽 &nbsp; Schedule/delete workout sessions with SwoleMates 🏋 <br>


## Contributors

|Brian Fletcher|Caroline Tan|Ezzedine Alwafai|Gunnar Runkle|Scott Borecki|Taylor Varoglu
|--- |--- |--- |--- |--- |--- |
|[GitHub](https://github.com/bfl3tch)|[GitHub](https://github.com/carolinectan)|[GitHub](https://github.com/ealwafai)|[GitHub](https://github.com/gunnarrunner)|[GitHub](https://github.com/Scott-Borecki)|[GitHub](https://github.com/tvaroglu)
|[LinkedIn](https://www.linkedin.com/in/bfl3tch/)|[LinkedIn](https://www.linkedin.com/in/carolinectan/)|[LinkedIn](https://www.linkedin.com/in/ezzedine-alwafai/)|[LinkedIn](https://www.linkedin.com/in/gunnar-runkle/)|[LinkedIn](https://www.linkedin.com/in/scott-borecki/)|[LinkedIn](https://www.linkedin.com/in/taylorvaroglu/)


## Table of Contents
|Links
|--- |
[Tools Used](#tools-used)
[Project Overview](#project-overview)
[Learning Goals](#learning-goals)
[Database Schema](#database-schema)
[Endpoints](#endpoints)


## Tools Used

|Development|Development|Testing|Deployment
|--- |--- |--- |--- |
|[Ruby 2.7.2](https://www.ruby-lang.org/en/downloads/)|[Atom](https://atom.io/)|[RSpec for Rails](https://github.com/rspec/rspec-rails)|[Heroku](http://virtual-watch-party.herokuapp.com)|
|[Rails 5.2.6](https://rubygems.org/gems/rails/versions/5.2.6)|[GitHub](https://desktop.github.com/)|[Webmock](https://github.com/bblimke/webmock)|[CircleCI](https://circleci.com/)|
|[Pry](https://rubygems.org/gems/pry/versions/0.10.3)|[Git](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup)|[VCR](https://github.com/vcr/vcr)|
|[PostgresQL](https://www.postgresql.org/)|[HTML5](https://developer.mozilla.org/en-US/docs/Web/HTML)|[SimpleCov](https://rubygems.org/gems/simplecov/versions/0.12.0)|
|[Postico](https://eggerapps.at/postico/)|[CSS3](https://developer.mozilla.org/en-US/docs/Web/CSS)|
|[OmniAuth Google OAuth2](https://github.com/zquestz/omniauth-google-oauth2)|[Rubocop](https://rubygems.org/gems/rubocop/versions/0.39.0)|
|[Faraday](https://github.com/lostisland/faraday)|[FactoryBot](https://github.com/thoughtbot/factory_bot)|
|[Figaro](https://github.com/laserlemon/figaro)||
|[Postman](https://www.postman.com/product/rest-client/)|

</div>

<div align="center">

## Project Overview

</div>

This project was developed by Brian Fletcher, Caroline Tan, Ezzedine Alwafai, Gunnar Runkle, Scott Borecki, and Taylor Varoglu during Mod 3 of Turing School's Back End Engineering Program.  

Created from scratch and deployed to Heroku in a short period of 10 days, this project consists of a Ruby on Rails web application utilizing a service-oriented architecture.  The front-end and back-end applications were both built in Rails. The front end communicates with the back end through an API. The back-end application houses the application database, authenticates users with [Google OAuth 2.0](https://developers.google.com/identity/protocols/oauth2), and consumes a third-party [Yelp API](https://www.yelp.com/developers).

The project description and base requirements can be found [here][consultancy-home]

<div align="center">

## Learning Goals

</div>

&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Create a project with a separate front-end and back-end<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Use Rails to create web pages that allow users to CRUD resources<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Use an external OAuth provider to authenticate users<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Build APIs that return JSON responses<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Consume two or more external APIs which require authentication<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Create instance and class methods on a Rails model that use ActiveRecord methods and helpers<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Write model and feature tests that fully cover data logic and potential user behavior<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Implement a self-referential relationship in ActiveRecord<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Utilize Continuous Integration via CircleCI<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Deploy to Heroku<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Implement a production-quality user interface using Bootstrap or other common CSS styling framework<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Implement agile project management via Kanban boards, daily stand-ups, and team retros<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Utilize quality workflow practices: small commits, descriptive pull requests, and code reviews<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Organize and refactor code to be more maintainable<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Apply RuboCop’s style guide for code quality<br>
&nbsp; &nbsp; ⭐ &nbsp; &nbsp; Write thorough, understandable documentation<br>

<div align="center">

## Database Schema

</div>

![schema](https://user-images.githubusercontent.com/58891447/134605631-b3d29050-7a44-46d4-8676-a746f7f258e1.jpeg)

<div align="center">

## Endpoints

</div>

The `base path` of each endpoint is:

```
https://spotme-app-api.herokuapp.com/api/v1
```

- For `GET` requests, you can send the endpoint requests through your internet browser, or utilize an API client (i.e. [Postman][postman-url])
- For any other requests (i.e. `POST`, `PATCH`, `DELETE`), you will need to use an API client to provide the required request body


The following table presents each API endpoint and its associated documentation
- For `GET` requests, an example link is provided for demonstration purposes  

**Users**                  | [Docs](/docs/users.md) | Examples
---------------------------|------------------------------------------|--------
Find User by Google ID     | [docs](/docs/users.md#find-user)          | [example](https://spotme-app-api.herokuapp.com/api/v1/users/find?google_id=atcsd36zl1b150p2m38wp)
Get User by User ID        | [docs](/docs/users.md#get-user)          | [example](https://spotme-app-api.herokuapp.com/api/v1/users/1)
Create New User            | [docs](/docs/users.md#create-new-user)   |
Update User                | [docs](/docs/users.md#update-user)       |

**Friendships**            | [Docs](/docs/friendships.md) | Examples
---------------------------|------------------------------------------|--------
Get User's Friends         | [docs](/docs/friendships.md#get-users-friends) | [example](https://spotme-app-api.herokuapp.com/api/v1/users/1/friendships)
Create New Friendship      | [docs](/docs/friendships.md#create-new-friendship)
Delete Friendship          | [docs](/docs/friendships.md#delete-friendship)

**Events**                 | [Docs](/docs/events.md) | Examples
---------------------------|------------------------------------------|--------
Get User's Events          | [docs](/docs/events.md#get-user-events)  | [example](https://spotme-app-api.herokuapp.com/api/v1/users/1/events)
Create User New Event      | [docs](/docs/events.md#create-new-event) |
Delete Existing Event      | [docs](/docs/events.md#delete-existing-event) |

**Gym Members**            | [Docs](/docs/gym_memberships.md) | Examples
---------------------------|------------------------------------------|--------
Get Users at Gym | [docs](/docs/gym_memberships.md#get-users-at-gym) | [example](https://spotme-app-api.herokuapp.com/api/v1/users/1/gym_members?yelp_gym_id=lex65fkcol5gfq89rymmd2)
Get User's Gym Memberships | [docs](/docs/gym_memberships.md#get-users-gym-memberships)
Create Gym Membership      | [docs](/docs/gym_memberships.md#create-gym-membership)
Delete Gym Membership      | [docs](/docs/gym_memberships.md#delete-gym-membership)


**Gym Search**             | [Docs](/docs/gym_search.md) | Examples
---------------------------|------------------------------------------|--------
Get Gyms Near User         | [docs](/docs/gym_search.md#find-gyms) | [example](https://spotme-app-api.herokuapp.com/api/v1/gym_search?zip_code=80302)
Get Gym Show Page          | [docs](/docs/gym_search.md#view-gym) | [example](https://spotme-app-api.herokuapp.com/api/v1/gym_search/c4bIf9XLgG1-CGuPl_QgWw)


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
[build-badge]: https://img.shields.io/circleci/build/github/tvaroglu/spot_me_backend?style=flat-square
[front-end-badge]: https://img.shields.io/static/v1?style=flat-square&label=SpotMe&message=Front+End+Repo&color=9cf
[front-end-url]: https://github.com/tvaroglu/spot_me_frontend

<!-- Links -->
[Repository]: https://github.com/tvaroglu/spot_me_backend
[consultancy-home]: https://backend.turing.edu/module3/projects/consultancy/
[postman-url]: https://www.postman.com/

<!-- Images -->
[github-avatar]: https://avatars.githubusercontent.com/u/79381792?s=100
