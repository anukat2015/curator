[![Build Status](https://travis-ci.org/mntj/curator.svg?branch=master)](https://travis-ci.org/mntj/curator)
[![Code Climate](https://codeclimate.com/github/mntj/curator/badges/gpa.svg)](https://codeclimate.com/github/mntj/curator)
[![Test Coverage](https://codeclimate.com/github/mntj/curator/badges/coverage.svg)](https://codeclimate.com/github/mntj/curator)

# curator

## About
**curator** is a stock curation tool that I created to find companies according to investor Joel Greenblatt's [Magic formula investing](http://en.wikipedia.org/wiki/Magic_formula_investing) technique.

The application retrieves and calculates financial data on 3,000 publicly traded US companies, chosen from the [Russell 3000 Index](https://www.russell.com/indexes/americas/indexes/fact-sheet.page?ic=US3000), using the [Quandl Sharadar-Fundamentals API](https://www.quandl.com/SHARADAR).

**curator** is designed to provide two lists of companies in CSV format — one ranked by earnings yield and one by return on capital. Investment decisions should not be made without further analysis, however initial results have been promising (the top ranked companies by return on capital from Q2 2014 show an average return of over 35% since late June 2014.)

## Usage Instructions

First you'll want to clone curator to your local machine:
```$ git clone git@github.com:mntj/curator.git curator```

You'll also want to [signup for Quandl](https://www.quandl.com/) to receive an auth token and then set this as an environment variable in your ```.bash_profile```. For example:
```export QUANDL_AUTH_TOKEN=123xyz```

From there, modify the call to ```curate``` in ```lib/curate.rb``` to specify the number of companies you'd like to keep.

Finally, run ```$ bin/rails runner lib/curate.rb``` to begin the curation process. When completed, two CSV files will be created with the results in your ```curator``` directory.

## Status
I'm in the middle of a refactor of this application according to Sandi Metz's *Practical Object-Oriented Design in Ruby*, that will result in a much more Rails centric approach as opposed to the existing massive module located in ```lib/stock_reader.rb```.


