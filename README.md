[![Build Status](https://travis-ci.org/mntj/curator.svg?branch=master)](https://travis-ci.org/mntj/curator)
[![Code Climate](https://codeclimate.com/github/mntj/curator/badges/gpa.svg)](https://codeclimate.com/github/mntj/curator)
[![Test Coverage](https://codeclimate.com/github/mntj/curator/badges/coverage.svg)](https://codeclimate.com/github/mntj/curator)

# curator
## About
**curator** is a stock curation tool used to find companies according to investor Joel Greenblatt's [Magic formula investing](http://en.wikipedia.org/wiki/Magic_formula_investing) technique.

The application retrieves and calculates financial data on 3,000 publicly traded US companies, chosen from the [Russell 3000 Index](https://www.russell.com/indexes/americas/indexes/fact-sheet.page?ic=US3000), using the [Quandl Sharadar-Fundamentals API](https://www.quandl.com/SHARADAR).

**curator** is designed to provide two lists of companies in CSV format — one ranked by earnings yield and one by return on capital. Investment decisions should not be made without further analysis, however initial results have been promising (the top ranked companies by return on capital from Q2 2014 show an average return of over 35% since late June 2014.)

## Usage Instructions

Clone curator to your local machine:

    $ git clone git@github.com:mntj/curator.git

and bundle:

    $ bundle install

You'll also want to [signup for Quandl](https://www.quandl.com/) to receive an auth token and then set this as an environment variable in your ```.bash_profile```. For example:

    export QUANDL_AUTH_TOKEN=123xyz

Additionally you'll need to download and run a [PostgreSQL server](http://postgresapp.com) before running the application.

From there, modify the call to ```curate``` in ```lib/tasks/curate.rake``` to specify the number of companies you'd like to keep.

Finally, run:

    $ rake curate

When completed, two CSV files will be created with the results in your ```curator``` directory.

## Contributing

1. Fork the project
2. Create a new branch
3. Write tests
4. Implement your changes
5. Create a pull request
6. Update the Readme (if necessary)

Thanks for contributing!
