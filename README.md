# Moncton User Group

Static site generator for the Moncton User Group site.

The goal is to have a site that is easy to maintain and that integrates with Eventbrite to provide a list of upcoming / past events. Registration takes place on the Eventbrite site.

## Configuration

Configuration can be done with environment variables.

We use a Personal Token, see the [Eventbrite documentation](https://www.eventbrite.com/developer/v3/reference/authentication/#ebapi-personal-tokens) for more details. It should be set in the `EVENTBRITE_OAUTH_TOKEN` environment variable.

## Getting Started

This is a [Middleman](https://middlemanapp.com/) application.

#### Install Dependencies

It requires ruby to be installed, the most recent the better.

You can then install project dependencies by running:

```
gem install bundler
bundle
```

#### Configuration

While developing, it's easier to load environment using a `.env` file (see also `.env.template`).

#### Running (development)

```
bundle exec middleman server
```

#### Building

```
bundle exec middleman build
```
