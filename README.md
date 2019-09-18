# invitr

This is an event-sharing app to demonstrate basic Active Record associations.

## To run this app locally

1. Install gem dependencies

```bash
bundle install
```

2. install [Postgres on your system](https://www.alanvardy.com/posts/7)
3. Edit your database.yml to get the database connected
4. Create and migrate your database

```bash
rails db:create
rails db:migrate
```

_Optional, to play around with pre-generated user and event data:_

_5. Add a .env file in the root and add a username and password_

```bash
# .env

TEST_PASS=password
```

_6. Seed the database_

```bash
rails db:seed
```

**Run the server**

```bash
rails s
```

_Note:_ To prevent the development server from re-packaging assets every time a page is loaded, you can install Foreman and run an instance of the Foreman server in a bash instance from the root directory:

```bash
gem install foreman

foreman start -f Procfile.dev
```

## License

This project is licensed under the terms of the [MIT license](https://opensource.org/licenses/MIT).
