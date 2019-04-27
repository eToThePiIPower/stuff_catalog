# Stuff Catalog

`Stuff Catalog` is a simple tool for keeping track of the items you own.

This version `v0.1` is just a very-basic CRUD application meant as a framework
on which to build the rest of the features.

It was inspired by a need to keep a catalog of my personal effects, their
approximate values, and their locations for my home-owners insurance. As such,
the early versions are focussing on ease of data entry and printing tabulated
reports.

## Requirements

The following versions are not strictly necessary, but I won't be testing on
earlier versions so can't guarantee current or future compatibility with them.

* Ruby 2.6.2
* Node 10.15.x+
* Postgres 10.6+

A modern POSIX operating system (eg Linux, Mac OSX) is strongly encouraged.
Users may be able to run the `rails server` command on Windows, but I can make
no assurances to that.

## Installation

Install in the standard way

```
git clone https://github.com/eToThePiIPower/stuff_catalog.git
bundle install
yarn install
rails db:setup
```

## Testing

We use `rspec` for BDD specs and `rubocop` for linting. Future linters and spec
runners will likely be added.

```
rspec
```
