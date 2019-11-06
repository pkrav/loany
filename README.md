# Loany

This is a simple loan application processing service implemented with Elixir and Phoenix.

## Description and thought process

First of all I have started with development of this application with 
Loan Request scheme, migration for it and validation rules for the fields. 

After that, I thought about 
what is the best way to store the minimum amount for requested loans without 
using Postgres and came to the conclusion that the best way would be 
to implement a simple cache. This cache helped implement required scoring strategy.

When the data scheme and scoring strategy were ready I have started development of
Loan Request Controller and templates for it. I have decided that loan request form should
be shown for `/` and `/requests/new` addresses, `/requests/:id` should show page 
with offer or with rejection depending on the scoring result. New loan requests 
should be added using `POST /requests` request and historical data with loan 
applications should be available on `/requests` with `GET` request.



## Requirements

* Erlang >= 20
* Elixir >= 1.5
* PostgreSQL >= 9.4 with Python >= 3.0 (for plpython)
* NodeJS >= 8

## Install System Dependencies

### macOS

```bash
brew update
brew install elixir python nodejs
brew services start postgres
```


### Ubuntu

```bash
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.deb
curl -sL https://deb.nodesource.com/setup_10.x | bash -
sudo apt-get update
sudo apt-get install -y esl-erlang elixir postgresql postgresql-contrib
sudo apt install -y nodejs inotify-tools
update-rc.d postgresql enable
service postgresql start
```

## Development setup

Fetch dependencies:

```bash
mix deps.get
```

Set up dev & test databases:

```bash
mix ecto.setup
```

Compile:

```bash
mix compile
cd assets && npm i && cd ..
```

Run the server:

```bash
mix phx.server
```

Then visit [http://localhost:4000]()

### Launch tests

In order to run tests run following command:

```bash
mix test
```
