# [click]

A simple portfolio-style website w/admin. Basically, I had an idea for simple site to display the occasional
snapshot that I'm happy with, and I was overdue to do an actual site in Rails. 

## What's it do?

It displays your photos. As a bonus, it uses the [exifr](http://exifr.rubyforge.org/) gem to read your EXIF
info and store that as well. On the downside, your photo HAS to have EXIF data. This is on my list of things
to change. Because of the magic of [Paperclip](https://github.com/thoughtbot/paperclip), you can store your images locally or in (on?) ["the cloud"](http://meme.goettner.net/tothecloud).

## Installation

After you install, you'll be able to setup your admin user account at SITEURL/admin. Powered by [Typus](https://github.com/fesplugas/typus/wiki). 



