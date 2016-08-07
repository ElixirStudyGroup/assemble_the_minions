# Assemble The Minions

[![Assemble the Minitions](https://img.youtube.com/vi/oHpzvFdPLQA/0.jpg)](https://www.youtube.com/watch?v=oHpzvFdPLQA)

## An exercise in Supervision, workers and GenServers

Our mission here is to create a fault tolerant systems of workers to do our evil bidding.

Here are the specifications:

 - There can be only one leader (Gru), Gru supervises all of the minions.
 - Minions aren't very clever and will respond to very simple commands
 - Minions are important enough that we will give them names, but no two minions may have the same name
 - If a minion dies, it should be replaced immediately with a minion who'll have the same name
 - If you don't have tests, you didn't do it

## Getting Started

`mix deps.get` - Get our dependencies
`mix test.watch` - Run tests on save

## How?

Fork this project and get cracking.  I've provided the basics of a mix project for you and the very first test.

Work on a branch of your own naming and submit pull requests.

We'll give each other feedback on what we've acheived so far and freely steal each others ideas where they aid our goals.
