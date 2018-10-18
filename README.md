# TrainsOnRails

I created an architecture using the gem structure to be converted to a gem properly or just use as a library.
On the folder "test" there are the classes to be tested. The main test file is called "tw_main_test.rb". The others are unit tests of the classes.
I choose the Minitest as test performance because it is the default of bundle gem skeleton and because I think it is more simplest and faster than RSpec. I have on mind that the important is to test, not the tool.
I tried to follow the good practices of development following the Ruby community convention, using the gem Rubocop. I also used the
GIT as a version control tool, doing partial commits for each implemented feature.
I tried to use TDD in most part of the implementation, as it can be seen in my git history.
To execute the tests just run the command "rake test" on the root of the project.
I had some doubts about the problem and I couldn't implement the problem number 7. To support the Trains problem, I implemented some classes below:
Location.rb: A class to abstract the cities and store the given data
Route.rb: A class to create a route object, having a Location object to the origin and destination attributes and the distance attribute of the route
Routes.rb: This class is responsible to store many routes also to parse and serialize data.
TrainsError: A class to raise customs errors
Trip: A class to store and calculate trips for given points


## Run the tests

Run this command :

```ruby
rake test

```