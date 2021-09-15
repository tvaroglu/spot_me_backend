# Spot Me API

![Version][version-badge]
[![Ruby Style Guide][rubocop-badge]][rubocop-url]
[![Contributors][contributors-badge]][contributors-url]
[![Forks][forks-badge]][forks-url]
[![Stargazers][stars-badge]][stars-url]
[![Issues][issues-badge]][issues-url]

Rails Engine is an API that exposes resources for an e-commerce application using RESTful and non-RESTful endpoints.

## Table of Contents

- [Technologies Used](#technologies-used)
- [Minimum Requirements](#minimum-requirements)
- [Getting Started](#getting-started)
- [Endpoints](#endpoints)
- [Project Background](#project-background)
- [Database Schema](#database-schema)
- [Contributors](#contributors)

## Technologies Used
- Rails 5.2.6
- Ruby 2.7.2
- PostgreSQL 13.3
- Gems: FactoryBot, Faker, Pry, RSpec, RuboCop, Shoulda-Matchers, SimpleCov
- Processes: OOP, TDD, MVC, REST

## Minimum Requirements
To access the API endpoints, you need the following:
- `GET` Requests: Internet browser or API client (such as [Postman][postman-url])
- `POST`, `PATCH`, `DELETE` Requests: API client

## Getting Started

The `base path` of each endpoint is:

```
https://spotme-app.herokuapp.com/api/v1
```

- For `GET` requests, you can simply send the endpoint requests through your internet browser.  
- For any other requests (i.e. `POST`, `PATCH`, `DELETE`), you will need to use an API client to provide the request body and access the endpoints.

## Endpoints

The following table presents each API endpoint and its documentation.  

Notes:
- For `GET` requests, an example link is provided for demonstration purposes.  
- Unless otherwise noted, the results are sorted by name in case-sensitive alphabetical order (i.e. A-Z then a-z).

<!-- Endpoint | Docs | Example
---------|------|--------
**Merchants** | [docs][merchants-endpoints-link]
Get All Merchants | [docs][get-all-merchants-docs] | [example][get-all-merchants-ex]
Get One Merchant | [docs][get-one-merchant-docs] | [example][get-one-merchant-ex]
**Items** | [docs][items-endpoints-link]
Get All Items | [docs][get-all-items-docs] | [example][get-all-items-ex]
Get One Item | [docs][get-one-item-docs] | [example][get-one-item-ex]
Create an Item | [docs][create-an-item-docs]
Update an Item | [docs][update-an-item-docs]
Destroy an Item | [docs][delete-an-item-docs]
**Relationships** | [docs][relationship-endpoints-link]
Get a Merchant's Items | [docs][get-a-merchants-items-docs] | [example][get-a-merchants-items-ex]
Get an Item's Merchant | [docs][get-an-items-merchant-docs] | [example][get-an-items-merchant-ex]
**Search** | [docs][search-endpoints-link]
Find All Items | [docs][find-all-items-docs] | [example][find-all-items-ex]
Find One Item | [docs][find-one-item-docs] | [example][find-one-item-ex]
Find All Merchants | [docs][find-all-merchants-docs] | [example][find-all-merchants-ex]
Find One Merchant | [docs][find-one-merchant-docs] | [example][find-one-merchant-ex]
**Business Intelligence** | [docs][bi-endpoints-link]
Items by Most Revenue | [docs][get-items-with-most-revenue-docs] | [example][get-items-with-most-revenue-ex]
Merchants with Most Revenue | [docs][get-merchants-with-most-revenue-docs] | [example][get-merchants-with-most-revenue-ex]
Merchants with Most Items Sold | [docs][get-merchants-with-most-items-sold-docs] | [example][get-merchants-with-most-items-sold-ex]
Total Revenue for a Given Merchant | [docs][get-total-revenue-for-merchant-docs] | [example][get-total-revenue-for-merchant-ex]
 -->
## Project Background

This project was developed by Brian Fletcher, Caroline Tan, Ezzedine Alwafai, Gunnar Runkle, and Taylor Varoglu during Mod 3 of Turing School's Back End Engineering Program.  The project was completed in 10 days, from creating the two new rails applications from scratch to deploying both to Heroku.

The project description and base requirements can be found here: [link][consultancy-home]

In addition to the base project requirements, some extra explorations and extensions completed included:

- Validating query params by leveraging ActiveModel::Validations
- Using customized FactoryBot methods to significantly DRY up code in test files
- Using RSpec's Shared Examples feature for frequently-used tests to DRY up code in test files
- Documenting complicated methods in general accordance with TomDoc for Ruby specifications
- Creating documentation for each API endpoint to assist user in production
- Using GitHub Projects to track user stories and progress as well as creating new issues
- Implementing RuboCop and RuboCop extensions for code styling and best practices
- Completing all the Find and Find All endpoints for both Merchants and Items
- Completing all the edge case tests
- Deploying the API to Heroku for production

## Database Schema

<img src="https://user-images.githubusercontent.com/74567704/133355636-6dc4278a-bb77-45f2-a277-7899632c85d2.png">

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

<!-- Docs -->
[merchants-endpoints-link]: /doc/merchants_endpoints.md
[get-all-merchants-docs]: /doc/merchants_endpoints.md#get-all-merchants
[get-one-merchant-docs]: /doc/merchants_endpoints.md#get-one-merchant
[items-endpoints-link]: /doc/items_endpoints.md
[get-all-items-docs]: /doc/items_endpoints.md#get-all-items
[get-one-item-docs]: /doc/items_endpoints.md#get-one-item
[create-an-item-docs]: /doc/items_endpoints.md#create-an-item
[update-an-item-docs]: /doc/items_endpoints.md#update-an-item
[delete-an-item-docs]: /doc/items_endpoints.md#delete-an-item
[relationship-endpoints-link]: /doc/relationship_endpoints.md
[get-a-merchants-items-docs]: /doc/relationship_endpoints.md#get-a-merchants-items
[get-an-items-merchant-docs]: /doc/relationship_endpoints.md#get-an-items-merchant
[search-endpoints-link]: /doc/search_endpoints.md
[find-all-items-docs]: /doc/search_endpoints.md#find-all-items
[find-one-item-docs]: /doc/search_endpoints.md#find-one-item
[find-all-merchants-docs]: /doc/search_endpoints.md#find-all-merchants
[find-one-merchant-docs]: /doc/search_endpoints.md#find-one-merchant
[bi-endpoints-link]: /doc/business_intelligence_endpoints.md
[get-items-with-most-revenue-docs]: /doc/business_intelligence_endpoints.md#get-items-with-most-revenue
[get-merchants-with-most-revenue-docs]: /doc/business_intelligence_endpoints.md#get-merchants-with-most-revenue
[get-merchants-with-most-items-sold-docs]: /doc/business_intelligence_endpoints.md#get-merchants-with-most-items-sold
[get-total-revenue-for-merchant-docs]: /doc/business_intelligence_endpoints.md#get-total-revenue-for-a-merchant

<!-- Examples -->
[get-all-merchants-ex]: https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants?page=1&per_page=3
[get-one-merchant-ex]: https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants/42
[get-all-items-ex]: https://rails-engine-scott-borecki.herokuapp.com/api/v1/items?per_page=3
[get-one-item-ex]: https://rails-engine-scott-borecki.herokuapp.com/api/v1/items/179
[get-a-merchants-items-ex]: https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants/33/items
[get-an-items-merchant-ex]: https://rails-engine-scott-borecki.herokuapp.com/api/v1/items/209/merchant
[find-all-items-ex]: https://rails-engine-scott-borecki.herokuapp.com/api/v1/items/find_all?min_price=94.99&max_price=99.99
[find-one-item-ex]: https://rails-engine-scott-borecki.herokuapp.com/api/v1/items/find?min_price=94.99&max_price=99.99
[find-all-merchants-ex]: https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants/find_all?name=ILL
[find-one-merchant-ex]: https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants/find?name=ILL
[get-items-with-most-revenue-ex]: https://rails-engine-scott-borecki.herokuapp.com/api/v1/revenue/items?quantity=3
[get-merchants-with-most-revenue-ex]: https://rails-engine-scott-borecki.herokuapp.com/api/v1/revenue/merchants?quantity=3
[get-merchants-with-most-items-sold-ex]: https://rails-engine-scott-borecki.herokuapp.com/api/v1/merchants/most_items?quantity=3
[get-total-revenue-for-merchant-ex]: https://rails-engine-scott-borecki.herokuapp.com/api/v1/revenue/merchants/42

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
