# Heroes API

## Getting started

These instructions will get you a copy of the project up and running on your local machine.

### Prerequisites

Before you begin you will need to install docker. Choose one of the methods below:

- [Docker for Mac](https://docs.docker.com/v17.12/docker-for-mac/install/)
- [Docker for Windows](https://docs.docker.com/docker-for-windows/install/)

### Installing and Running

1. Get the repository latest source code: `git clone https://github.com/demianrosas/heroesAPI.git`
2. Run `make images` to build the container
3. Start the container running `make up`
4. Create the database if you didn't create before running `make database`

### Postman file

There is available a json file to import in Postman called `Heroes.postmand_collection.json`.

### Testing

To run the test you can run `make test`. Previously you should run `make up`.
