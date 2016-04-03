# Lru_Cache
A thread-safe memory LRU cache.

#Example
```ruby
cache = LruCache.new(3)

cache.set("Apple",300)
p cache.list # => ["Apple", nil, nil]

cache.set("Orange",200)
p cache.list # => ["Orange", "Apple", nil]

cache.set("Lemon",250)
p cache.list # => ["Lemon", "Orange", "Apple"]


p cache.get("Apple") # => 300
p cache.list #=> ["Apple", "Lemon", "Orange"]

p cache.get("Lemon") # => 250
p cache.list # => ["Lemon", "Apple", "Orange"]

p cache.get("Orange") # => 200
p cache.list # => ["Orange", "Lemon", "Apple"]
```

#API

* `attr_reader :hash,:list`  

* `initialize(max_count = 10)`  
A default maximum item count is 10.

* `set(key,value)`  
Set value of key.

* `get(key) # => value`  
Get the value of key.

* `delete(key)`  
Delete value at key.

* `clear()`  
Clear all items.

