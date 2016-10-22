# Moncton Developer User Group

Static site generator for the Moncton Developer User Group site.

This is a [Middleman](https://middlemanapp.com/) application deployed to GitHub Pages. It's set up as an Organization page living at [https://github.com/monctonug/monctonug.github.io](https://github.com/monctonug/monctonug.github.io)


### Dependencies

* ruby: a reasonably recent version
* bundler: `gem install bundler`
* gems: `bundle install`


### Running in Development Mode

```
bundle exec middleman server
```


### Configuring Eventbrite Sync

Configuration can be done with environment variables. We use a Personal Token set in the `EVENTBRITE_OAUTH_TOKEN` environment variable. See the [Eventbrite documentation](https://www.eventbrite.com/developer/v3/reference/authentication/#ebapi-personal-tokens) for more details.

This project uses [dotenv](https://github.com/bkeepers/dotenv) to manage environment variables in development mode (in the `.env` file).


### Adding Slides

We host slides on [Speaker Deck](https://speakerdeck.com/): [https://speakerdeck.com/monctonug](https://speakerdeck.com/monctonug)

To embed slides on a post, add `speakerdeck_id: {ID}` to the [Frontmatter](https://middlemanapp.com/basics/frontmatter/). The ID can be extracted from the embed code snippet.


### Syncing Events

Syncing events with Eventbrite is done by running `bundle exec ruby sync.rb`

A blog article will be generated in `./source/articles/` for each event found. The event data is serialized to YAML and stored in the article's Frontmatter.
