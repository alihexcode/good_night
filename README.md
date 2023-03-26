# Good Night API

## Requirements
- Rails v7.0.4
- Ruby v3.1.2
- PostgreSQL database
- JSONAPI::Serializer to render JSON response
- Pagy gem for pagination with Link header standard
- Rswag for API documentation
- Rspec for testing
- Simplecov for test coverage

## Running the project
1. Clone the repository
    ```
    git clone git@github.com:alihexcode/good_night.git
    ```
2. Install dependencies
    ```
    bundle install
    ```
3. Set up the database configuration in `config/database.yml`
4. Prepare the database
    ```
    rails db:create
    rails db:migrate
    rails db:seed
    ```
5. Start the server
    ```
    rails s
    ```

## Rswag documentation
To generate Rswag documentation, run
  ``` rake rswag:specs:swaggerize ```
Open your web browser and navigate to http://localhost:3000/api-docs.
You should see the Swagger UI interface loaded with your API documentation.

```
Note:
that the URL http://localhost:3000/api-docs assumes that your Rails application is running on port 3000. If you are using a different port, you should adjust the URL accordingly.
```


## Check code style with Rubocop
To check the code style, run
```
rubocop
```

## Rspec tests and Test coverage
To run Rspec tests, run
```
bundle exec rspec
```

The coverage report will be generated in `coverage/index.html`
in a debian/ubuntu Terminal,

```
xdg-open coverage/index.html
```

## Pagination
Pagination is handled using the Pagy gem, with Link header standard. You can specify the page number and number of items per page in the API request parameters.
