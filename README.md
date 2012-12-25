# TimeLine

Track the entire life cycle of ActiveRecord Items.

## Installation

Add to your Gemfile and run the `bundle` command to install it.

 ```ruby
 gem "timeline"
 ```

**Requires Ruby 1.9.2 or later.**


## Usage

Call `timeline` in an ActiveRecord class and pass the name of the attributes you wish to track of your Model.

Track all attributes change of your AR model:

 ```ruby
 class Product < ActiveRecord::Base
   timeline
 end
 ```
This means that every attributes changes will be tracked.

Track one or more attributes:

```ruby
class Product < ActiveRecord::Base
  timeline(:price, :name)
end
```
Only the changes of name and price will be tracked.


## Development

Questions or problems? Please post them on the [issue tracker](https://github.com/acapilleri/timeline/issues). You can contribute changes by forking the project and submitting a pull request. You can ensure the tests passing by running `bundle` and `rake`.

This gem is created by Angelo Capilleri and is under the MIT License.