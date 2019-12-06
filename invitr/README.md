# invitr

This is an event-sharing app to demonstrate basic Active Record associations.

## To run this app locally

1. Install gem dependencies

```bash
bundle install
```

2. Update Yarn packages

```bash
yarn install --check-files
```

3. Install Postgres 
4. Edit config/database.yml to connect to the database
5. Create and migrate your database

```bash
rails db:create
rails db:migrate
```

_Optional, to play around with pre-generated user and event data:_

_6. Add a .env file in the root and add a password for seed users_

```bash
# .env

TEST_PASS=password
```

_7. Seed the database_

```bash
rails db:seed
```

**Run the server**

```bash
rails s
```

_Note:_ To prevent the development server from re-packaging assets every time a page is loaded, you can install Foreman and run an the Foreman server in a bash instance from the root directory:

```bash
gem install foreman

foreman start -f Procfile.dev
```

## License

This project is licensed under the terms of the [MIT license](https://opensource.org/licenses/MIT).
