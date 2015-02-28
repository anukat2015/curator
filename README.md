[![Build Status](https://travis-ci.org/mntj/curator.svg?branch=master)](https://travis-ci.org/mntj/curator)
[![Code Climate](https://codeclimate.com/github/mntj/curator/badges/gpa.svg)](https://codeclimate.com/github/mntj/curator)
[![Test Coverage](https://codeclimate.com/github/mntj/curator/badges/coverage.svg)](https://codeclimate.com/github/mntj/curator)

# curator
## About
**curator** is a stock curation tool used to find companies according to investor Joel Greenblatt's [Magic formula investing](http://en.wikipedia.org/wiki/Magic_formula_investing) technique.

The application retrieves and calculates financial data on 3,000 publicly traded US companies, chosen from the [Russell 3000 Index](https://www.russell.com/indexes/americas/indexes/fact-sheet.page?ic=US3000), using the [Quandl Sharadar-Fundamentals API](https://www.quandl.com/SHARADAR).

**curator** is designed to provide a list of companies that can be ranked by earnings yield and return on capital. Investment decisions should not be made without further analysis, however initial results have been promising (the top ranked companies by return on capital from Q2 2014 show an average return of over 35% since late June 2014.)

**curator** is no longer a command-line application, but if you'd like to use it that way, check out the v0.1 release above. There is now a web interface found at the link at the top of this repo page. Data is usually refreshed from the API once a week.

## Contributing

1. Fork the project
2. Create a new branch
3. Write tests
4. Implement your changes
5. Create a pull request

Thanks for contributing!
