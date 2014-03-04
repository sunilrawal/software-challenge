# Challenge for Software Engineer or Frontend Engineer

See our open jobs http://www.vervemobile.com/jobs/

To better assess a candidates development skills, we would like to provide the following challenge.  You have as much time as you’d like though we ask that you not spend more that a few hours.

## Project Description

Imagine that Verve has just received a new advertising campaign from a national coffee franchise to promote their new Chocolate Macchiato.  They will be delivering a tab separated document with each store location so we can drive foot traffic into each location.  Geo targeted ads are typically target to a 5 mile radius around the business.  Your task is to create a web interface that accepts file uploads, stores it in a database and then displays a list ordered ordered by distance from the Verve Carlsbad office ( 33.1243208, -117.32582479999996 ).

Here’s what your web-based application must do:

1. Your app must accept ( via a form ) a tab delimited file with the following columns: business name, address, city, state, postal code, country, latitude, longitude.  The example file is named offers_poi.tab is included in this repo.
2. Your app must parse the given file and store the information in a database.
3. After upload, your application should display each location ordered by distance from the Verve Carlsbad office.
4. (Bonus Points) Provide an api to query for locations near a given latitude and longitude.

Your application does not need to:

1. handle authentication or authorization
2. be written in any particular language or framework

Bonus points for:

• Being aesthetically pleasing  
• Using Google Maps  
• Using Ruby, Rails, Lua, Go, or PostGIS  
• TDD/BDD  

Your application should be easy to set up and should run on Mac OS X.  It should not require any for-pay software.

## Evaluation

Evaluation of your submission will be based not he following criteria.  Additional, reviewers will attempt to access your familiarity with standard libraries.  If your code submission is in Ruby or JavaScript, reviewers will attempt to access your experience with object-orented programming based on how you’ve structured your submission.

1. Did you application fulfill the basic requirements?
2. Did you document the method for setting up and running your application?


## Submission

After completing the challenge submit it to your Verve contact or jspooner[at]vervemobile.com
