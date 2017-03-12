NOTES
=====

## Setting ENV variables
This website is excellent: [http://railsapps.github.io/rails-environment-variables.html](http://railsapps.github.io/rails-environment-variables.html)

Instead of modifying .bashrc to export all ENV variables for every app ever, can use the figaro gem.

The gem provides a generator:
```
bundle exec figaro install
```
The generator creates a config/application.yml file and modifies the .gitignore file to prevent the file from being checked into a git repository.

You can add environment variables as key/value pairs to config/application.yml:

```
GMAIL_USERNAME: Your_Username
```
The environment variables will be available anywhere in your application as ENV variables:
```
ENV["GMAIL_USERNAME"]
```
This gives you the convenience of using the same variables in code whether they are set by the Unix shell or the figaro gem’s config/application.yml. Variables in the config/application.yml file will override environment variables set in the Unix shell.

In tests or other situations where ENV variables might not be appropriate, you can access the configuration values as Figaro method calls:
```
Figaro.env.gmail_username
```

Figaro provides a rake task to set the environment variables in the config/application.yml file as Heroku environment variables:
```
rake figaro:heroku
```
If you’re using one of the RailsApps example applications or you have generated a starter application using the Rails Composer tool, you’ll find a file named config/application.yml. This file was added by the figaro gem and contains key/value entries for each environment variable you may need. Each entry is commented out. Remove the comment character if you want to override environment variables from the Unix shell or set the environment variables using the config/application.yml file.
