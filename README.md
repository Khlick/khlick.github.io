# khrisgriffis.com

This is the backend for my personal website.

---
_Dependencies_

![https://img.shields.io/badge/jekyll-4.3.2-blue](https://img.shields.io/badge/jekyll-4.3.2-blue)

![https://img.shields.io/badge/jekyll-scholar-4.3.2-blue](https://img.shields.io/badge/jekyll--scholar-7.1.0-9cf)

<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="75" height="20" role="img" aria-label="jekyll-scholar: 7.1.0">
  <title>Ruby: 3.2.1</title>
  <linearGradient id="s" x2="0" y2="100%">
    <stop offset="0" stop-color="#fff" stop-opacity=".3" />
    <stop offset="1" stop-opacity=".15" />
  </linearGradient>
  <clipPath id="r">
    <rect width="122" height="20" rx="3" fill="#fff" />
  </clipPath>
  <g clip-path="url(#r)">
    <rect width="36" height="20" fill="#fff" />
    <rect x="36" width="39" height="20" fill="#9cf" />
    <rect width="75" height="20" fill="url(#s)" />
  </g>
  <g fill="#fff" text-anchor="middle" font-family="Verdana,Geneva,DejaVu Sans,sans-serif" text-rendering="geometricPrecision" font-size="110">
    <image href="https://www.ruby-lang.org/images/header-ruby-logo.png" height="16" x="10" y="2"></image>
    <text aria-hidden="true" x="555" y="150" fill="#ccc" fill-opacity=".3" transform="scale(.1)" textLength="290">3.2.1</text>
    <text x="555" y="140" transform="scale(.1)" fill="#333" textLength="290">3.2.1</text>
  </g>
</svg>

---

I modified this from the repo for [arkadianriver.com](https://github.com/arkadianriver/arkadianriver.com), which is based on the awesome design of http://html5up.net/spectral by the talented [@ajlkn](http://twitter.com/ajlkn). Gary ([@arkadianriver](https://twitter.com/arkadianriver)) did a fantastic job porting the theme template into a [Jekyll](https://jekyllrb.com/)-based static site generator, and I've made only a few modifications of my own. Unlike modern Jekyll themes, which function as plugins, this port is more like a templated site.

## First Steps

_If you decide you want to use this theme._

Much of the functionality is the same as [arkadianriver.com](https://github.com/arkadianriver/arkadianriver.com) with a few inclusions that allowed me to turn the portfolio into a digitical CV/resume. To this end, I incorporated a simple timeline from [materializecss](https://www.um.es/docencia/barzana/materializecss/cards.html) cards into an "Experiences" page, as well as a "Publications" page that parses posts with the category "publications" into a table. Lastly, I moved the blog entries into a "Ramblings" heading.

You can clone/fork the `clean` branch of this repo and use the [custom actions](https://github.com/Khlick/khlick.github.io/tree/live/.github) to build and deploy your site on your own github pages (described in [Build](./README.md#Build)), or use any other methods for building and hosting your site. If you use the custom workflow, you can add your markdown posts to the `./_posts` directory and push to the `live` branch. If you change the name of the branch you want to host from, you'll also have to change the workflow triggers (again, see [Build](./README.md#Build)). The build process will create a `github-pages` environment and your deployed site will be hosted from the `./_site` directory.

## Configuration

1. Personalize the information in the [YAML files](http://www.yaml.org/start.html).
   - Start with setting up your author information in `./_data/authors.yml` file.
  Here, you'll want to set a YAML list with your desired author key, I just chose my name. Then you'll set some key fields for `name`, `bio`, `url`, and `avatar`, as shwon in the example below:  
    ```yaml
    khrisgriffis:
      name: Khris Griffis
      bio: >
        Neurophysiology | Statistics | Biosignals Analysis | Data Science
      url: https://khrisgriffis.com
      avatar: kgriffis.jpg
    ```
   - If you wish to include your own google analytics tracking, or add extra site variables for your own customization, edit the `./_data/tokens.yml` accordingly.
   - Edit the `./_config.yml` for Jekyll. This file contains all your site information (see [Jekyll Configuration](https://jekyllrb.com/docs/configuration/)) along with a few custom configurations for this theme.  
  
    Config | Purpose
    -----|-------
    `siteauthor` | The site's author, a keyword matching the first key in `./_data/authors.yml`.
    `bannerimg` | Name of the landing page's background image file.
    `rambleimg` | Name of the image file for the `ramblings` category.
    `pubimg` | Name of the image file for the `publications` category.
    `expimg` | name of the image file for the `experiences` category.
    `greeting.title` | Title string for the greetings section of the landing page. The greetings section contains the social links.
    `greeting.text` | Text to display below the title and above the social icons.
    `closing-head` | Title string to display above the footer of the site.
    `closing-para` | Text to display below the closing head. _Note: this section also contains a `mailto: site.data.authors[site.siteauthor]`._
    Table 1. _Selection of custom configurations for this theme. Note: for all images, the names of the files should omit the directory, unless the directory is a sub-directory of `./images`, e.g. put `"sub/img.jpg"` for a file in `./images/sub`. Also, image names here will be ignored by pages with `image` and `background-image` header tags._
   - Personalize the images with your own, and change the attribution for your new banner at the bottom of `_data/credits.yml`.

    File | Action
    -----|-------
    **`_data/authors.yml`** | Site author(s) information. Set main author as first in the list.
    **`_data/tokens.yml`** | A collection of site variables and extra tokens.
    **`_config.yml`** | Replace the values for each key with your info.
    Table 2. _Personalizable files and their general purpose._


## Build

Initially, I struggled to get any of the available github workflows to build and deploy the site. With Ruby (3.2.1), RubyGems and Jekyll (4.3.2) installed, I was able to create a github workflow and custom action to parse the site, which includes the unsupported [jekyll-scholar](https://github.com/inukshuk/jekyll-scholar) plugin for a scientific feel for posts. A quick google search returned numerous ways of bypassing using unsupported Jekyll plugins, but I didn't want to have to maintain 2 branches for the site, nor did I want to upload the built site and the backend repo every push. For small sites, and certainly my personal site is one, that process is manageable, but not ideal. So, I built a custom github action and wrote a workflow directive that listens for a push (not a PR merge, though) to the `live` branch and executes a build and deploy of the site. For my site, there is about a 1 minute delay between push update and the deployment update. 

On the local side, you can use Jekyll commands to build your site, or serve your site, so you do not have to push to github for testing/viewing your changes/posts.

_TODO: More to come on this readme!_
- Include procedure for setting up github actions with this site.
- Include post examples for `experiences`, `publications`, and `ramblings` "categories".
- Include Liquid examples for using page headers in posts.
