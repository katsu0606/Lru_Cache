require 'thread'

class LruCache

  #-----------------------------------------------------
  # Constructor
  #-----------------------------------------------------
  def initialize(max_count = 10)
    if max_count < 1
      raise "ArgumentError"
    end

    @max_item_count = max_count
    @hash = Hash.new
    @list = Array.new(max_count)
    @m = Mutex.new
  end

  #-----------------------------------------------------
  # Set Method
  #-----------------------------------------------------
  def set(key , value)
    @m.synchronize {
      if @hash[key] == nil
        @hash[key] = value

        if @list[@max_item_count - 1] != nil
          @hash.delete(@list[@max_item_count - 1])
        end

        @list.pop

      elsif @hash[key] != nil
        @hash[key] = value
        @list.delete(key)
      end

      @list.unshift(key)
      p @list
      p @hash
    }
  end

  #-----------------------------------------------------
  # Get Method
  #-----------------------------------------------------
  def get(key)
    @m.synchronize {
      if @hash[key] == nil
        return nil
      else
        @list.delete(key)
        @list.unshift(key)
        p @list
        p @hash
        return @hash[key]
      end
    }
  end

  #-----------------------------------------------------
  # All Clear Method
  #-----------------------------------------------------
  def clear
    @m.synchronize {
      @max_item_count.times do |i|
        @hash.delete(@list[i])
        @list[i] = nil
      end
    }
  end

  #-----------------------------------------------------
  # Delete Key Method
  #-----------------------------------------------------
  def delete(key)
    @m.synchronize {
      if @hash.has_key?(key) == false
        return nil
      else
        @list.delete(key)
        @list.push(nil)
        @hash.delete(key)
      end
    }
  end

end
