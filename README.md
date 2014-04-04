cube-express
=============

An Express wrapper for Square's Cube: A system for time series visualization.

## Heads Up!

This is an experimental project. Only a limited set of Cube's server
functionality is ported.

##### Cube-Express does not include:

* Websocket support
* UDP support
* Internal cube metrics
* Any of the static assets and features

Also, this projects depends on some trickery and modifications to Cube itself.
Tread lightly.

### Why even...?

Cube is an awesome project. Really awesome. But there's a tight coupling of
*"Cube, the library"* and *"Cube, the server"*. Many of the pull requests in the
Cube project are actually server features, like authentication, logging, etc.

This project is an experiment to separate the server from the library, and does
so in an extreme way.

* It uses Express
* Coffee compiled JavaScript. *(Gasp!)*
* Middleware for things like authentication and CORS.
* Easy to deploy to Heroku


### What's next?

Ideally, Cube can be modifed to use it as a pure library while retaining it's
own server functionality. Someone could choose to integrate Cube however they'd
like, or get started right away using the built in server.

## Getting started

Here's the good news. Getting started and deploying to your favorite PaaS is 
easy!

#### Running Locally

1. Copy `.env.sample` to `.env`. Modify the contents to suit your config.
2. Be sure you modified your MongoDB setting in step 1.
3. Install [foreman](http://ddollar.github.io/foreman/). *Foreman will load up
your ENV vars set in the `.env`. You can use any process supervisor you'd like
here.*
4. Run `foreman start`.


#### Deploying

Want to deploy it to Heroku? Awesome.

1. Create a project. `heroku apps:create <project-name>`
2. Add the ENV you need. `heroku config:set MONGODB_URL=<your url>`
3. Push! `git push heroku master`
4. Make sure a web process is running. `heroku ps:scale web=1`
