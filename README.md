# BlackJax

![BlackJax Logo](https://github.com/dafrancis/BlackJax/raw/master/public/blackjax/logo.png)

## What is this?

BlackJax is a CMS that was originally written in PHP. I then decided to reimplement it in ruby using
[Sinatra](http://www.sinatrarb.com). I've used BlackJax as the main CMS for [my website](http://www.somethingafal.com/)

## So what's the difference between this CMS and the gajillion others?

Well I suppose there's not much I can do to convince you why mine is better (to be honest I don't think
it is). I made this as an experiment to see if I could have a CMS that shows the content and manages the
content all on one page, making some silly JavaScript animations whilst doing so. The end result in my opinion
is quite satisfactory yet there are still a lot of stuff I want to work on such as theming and tweaking
the JavaScript a bit.

## What's new?

* Replaced TinyMCE with EpicEditor. Markdown is the new replacement for WYSIWYG.
* Bootstrapped it and chose a decent theme from bootswatch.com
* Modified the JavaScript *A LOT*. Should be a lot more efficient
* Added easter eggs
* Added a blogging system based on the "Sinatra: Up and running" book

## To-Do

* Better Login
* Remove the dependance on jqui. I know I can do it someday~

## How to use

1. Get the repository
2. Install bundler (gem install bundler)
3. Install the required gems with "bundle install"
4. Use rackup/passenger/unicorn/thin/whatever to run the application
5. ???
6. PROFIT

To get to the admin just go to /admin wherever your application is installed

## Project Info

BlackJax is hosted on github: https://github.com/dafrancis/BlackJax, where your contributions, forkings and feedback are greatly welcomed.

Copyright &copy; 2011 Dafydd Francis, released under the [MIT](http://en.wikipedia.org/wiki/MIT_License) license.
