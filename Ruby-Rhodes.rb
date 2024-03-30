=begin
This is another
way of writing 
comments in a 
block fashion
=end


class Athlete
    def initialize(id, name)
        @playerId = id
        @playerName = name
    end 
    def printer()
        puts "The player ID number is #@playerId\n"
        puts "The player's name is #@playerName\n"
    end
    def getId()
        return @playerId
    end
    def getName()
        return @playerName
    end
end

class Events
    def initialize(id, name)
        @eventId = id
        @eventName = name
    end 
    def printer()
        puts "The event ID number is #@eventId\n"
        puts "The event name is #@eventName\n"
    end
    def getId()
        return @eventId
    end
    def getName()
        return @eventName
    end
end

x = 0
y = Array.new
z = Array.new
file = File.open("register.txt")
a = file.readlines.map()
puts a 
a.each do |num|
    myarray = num.split(" ", 2)
    if myarray == [""]
        x+=1
        next
    end
    myarray[1] = myarray[1].to_s.chomp()

    case x 
    when 0
        item = Athlete.new(myarray[0],myarray[1])
        item.printer
        y.push(item)
    when 1
        item = Events.new(myarray[0],myarray[1])
        item.printer
        z.push(item)
    when 2 
        found = false
        y.map{|foo|
        if (myarray[0] == foo.getId)
            puts "Player ID #{myarray[0]} found"
            found = true
            break 
        end
        }
        if (found == false)
            puts "Player ID #{myarray[0]} wasn't found"
        end
        z.map{|bar|
        #puts bar
        if(myarray[1] == myarray[1])
            puts "Event ID #{myarray[1]} found"
            found = true
            break
        end
        }
        if (found == false)
            puts "Event ID #{myarray[1]} wasn't found"
        end



    end
end
