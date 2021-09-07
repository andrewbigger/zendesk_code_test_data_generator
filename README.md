# Zendesk Code Test Data Generator

Simple gem for generating tricky code test data

## Description

The Zendesk coding challenge provides our candidate with a simple problem around building a CLI search. We provide a small set of data which they build their solution against.

This gem generates that data to specification, so one is able to create a very large data set (i.e. 100,000) users to test the performance of the candidate's submission.

Further, the gem is able to mangle json replacing types and deleting keys at random, in such a way that we can see how a candidate's submission behaves when it encounters unexpected data.

## Installation

First clone this repo and bundle install:

```bash
git clone git@github.com:andrewbigger/zendesk_code_test_data_generator

bundle install
```

Then once the bundling is complete - build and install the gem into your system.

```bash
gem build code_test_data_generator.gemspec
gem install code_test_data_generator-*.gem
rm code_test_data_generator-*.gem
```

And you should be good to go!

## Usage

Once installed in your system you can call the `zendesk_code_test_data` executable. Usage instructions can be viewed by passing the `-h` or `--help` flags to the exe:

```bash
bundle exec ./bin/zendesk_code_test_data -h
```

### Generating data

To generate data, call the generate command. You will be prompted for the necessary inputs.

```bash
bundle exec ./bin/zendesk_code_test_data generate
```

Flags can be used to control the generation thus:

```bash
# To create json files on the desktop, with 20 organisations, 200 users and 1000 tickets:
bundle exec ./bin/zendesk_code_test_data generate --location /Users/abigger/Desktop --orgs 20 --users 200 --tickets 1000
```

### Mangling data

Beyond the creation of test data, the gem is also capable of mangling test data by removing keys at random, or changing the value of keys. This can help test the defensiveness of a submission by ensuring the input is unexpected.

```bash
bundle exec ./bin/zendesk_code_test_data mangle -l /Users/abigger/Desktop/users.json --distortion 50 
```
