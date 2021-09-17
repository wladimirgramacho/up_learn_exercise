## UpLearn Exercise

### Specification
Write a function `fetch(url)` that fetches the page corresponding to the url and returns an object
that has the following attributes:
+ assets: an array of urls present in the `<img>` tags on the page
+ links: an array of urls present in the `<a>` tags on the page

Assume that the code will run on a server. Assume that this work is a part of a web app that
needs to be built further by multiple development teams and will be maintained and evolved for
several years in the future. In addition to these, make any assumptions necessary, but list those
assumptions explicitly.

### Assumptions I made
- I'm assuming this function would be called by a service or class, so I decided to always return an object (`OpenStruct`) with a `success` flag. That flag should be treated by the function caller.
- Since this code would be running on a server, I added a comment where we should log to Sentry (or analogous) when an unknown error happens. That is to avoid throwing exceptions across our code or to the user but also managing to solve those errors afterwards.
- I don't need to test the libraries I'm working with, since I'm assuming they are properly tested.
- I'm adding static code analysis (rubocop) to follow the community standards. Also, is what I always use on my projects.

### How to run

Install dependencies
`bundle install`

To run the code:
1. Open a ruby interpreter
`irb`
2. Import the main.rb file
`require_relative 'lib/main'`
3. Call the function with an URL
`fetch('http://google.com')`

To run the tests:
`bundle exec rspec`

To statically analyze the code:
`bundle exec rubocop`
