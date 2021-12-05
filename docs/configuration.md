# Configuration
The content of the homepage is configured using the `config.yml` file located in `/assets` directory. Styling of the homepage is done by modifying the `custom.css` file. More about it in [styling](docs/styling.md).

## Editing the config.yml
To add a new app or a bookmark, open the config.yml file with any text editor. The config.yml inside the container is located in `/assets/`folder. If you used the provided docker-compose example, the path to it will be something like: `/username/appdata/yet-another-homepage/assets/config.yml`

Once the config.yml is open you will see something like this:
```yaml
title: Home
author: Captain
dark: true
showLinks: true
stylesheet: "/assets/themes/default/custom.css"
applications:
  - title: Getting Started
    entries:
      - name: "Quick Start"
        icon: "/assets/themes/default/icons/yet-another-homepage.svg"
        url: "https://github.com/captain-otter/yet-another-homepage/blob/master/docs/quick-start.md"
      - name: "Documentation"
        icon: "fas fa-book"
        url: "https://github.com/captain-otter/yet-another-homepage"
      - name: "Contribute"
        icon: "fab fa-github"
        url: "https://github.com/captain-otter/yet-another-homepage"
  - title: About
    entries:
      - name: "About Me"
        icon: "/assets/themes/default/icons/captain-otter.svg"
        url: "https://captainotter.com/about"
      - name: "Support Me"
        icon: "/assets/themes/default/icons/kofi.svg"
        url: "https://ko-fi.com/captainotter"
bookmarks:
  - title: Self Hosting
    entries:
      - name: Awesome Selfhosted
        url: 'https://github.com/awesome-selfhosted/awesome-selfhosted'
        icon: fas fa-list
      - name: /r/selfhosted
        url: 'https://www.reddit.com/r/selfhosted/'
        icon: fab fa-reddit-alien
```

### Adding new applications
In the config example above after the `applications:` line, each `- title: XXX` defines a group of applications and each section after `entries:` defines a single application.

for example:
```yaml
- name: "Quick Start"
  icon: "fas fa-rocket"
  url: "https://github.com/captain-otter/yet-another-homepage/blob/master/docs/quick-start.md"
```
defines an application with a name "Quick Start" that uses a rocket icon from `font-awesome` pack and points to `https://github.com/captain-otter/yet-another-homepage/blob/master/docs/quick-start.md`

So the easiest way to add a new application is to duplicate that section and change the variables to your liking.

### Adding new bookmarks
Adding new bookmarks happens in almost an identical way to regular applications. With only difference being that they are now written after the `bookmarks:` section of the config.yml.

Here is an example of a bookmark entry:
```yaml
- name: Awesome Selfhosted
  url: 'https://github.com/awesome-selfhosted/awesome-selfhosted'
  icon: fas fa-list
```

